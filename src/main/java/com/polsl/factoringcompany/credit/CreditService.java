package com.polsl.factoringcompany.credit;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CreditService {

    private final CreditRepository creditRepository;
    private final UserService userService;

    public List<CreditEntity> getCredits() {
        return this.creditRepository.findAll();
    }

    public CreditEntity getCredit(Long id) {
        return this.creditRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Credit", id));
    }

    public void deleteCredit(Long id) {
        try {
            this.creditRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Credit", id);
        }
    }

    public List<CreditEntity> getCreditsCurrentUser() {
        Long currentUserId = userService.getCurrentUserId();
        return this.creditRepository.findAllByUserId(Math.toIntExact(currentUserId));
    }

    public Double getLeftToPay() {
        Long currentUserId = userService.getCurrentUserId();

        List<CreditEntity> allByUserId = this.creditRepository.findAllByUserId(Math.toIntExact(currentUserId));

        DecimalFormat df = new DecimalFormat("#.##");
        return Double.valueOf(df.format(allByUserId.stream()
                .map(CreditEntity::getLeftToPay)
                .mapToDouble(BigDecimal::doubleValue).sum()).replace(",","."));

    }
}
