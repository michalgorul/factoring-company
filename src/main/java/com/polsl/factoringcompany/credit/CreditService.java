package com.polsl.factoringcompany.credit;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import com.polsl.factoringcompany.user.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

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

    public CreditEntity getCreditBuNumber(String creditNumber) {
        return this.creditRepository.findByCreditNumber(creditNumber)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Credit", 0L));
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
                .mapToDouble(BigDecimal::doubleValue).sum()).replace(",", "."));

    }

    public CreditEntity createCurrentUserCredit(CreditRequestDto creditRequestDto) {
        try {
            String newCreditNumber = getNewCreditNumber();
            userService.getCurrentUserId();
            return this.creditRepository.save(new CreditEntity(
                    creditRequestDto, newCreditNumber, Math.toIntExact(userService.getCurrentUserId())));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private String getNewCreditNumber() {
        StringBuilder newCreditNumber = new StringBuilder();
        Formatter formatter = new Formatter(newCreditNumber);
        int month = LocalDateTime.now().getMonthValue();
        int year = LocalDateTime.now().getYear();
        long lastCreditIdPlusOne = 1L;

        try {
            lastCreditIdPlusOne = creditRepository.getCreditNumber(month, year) + 1;
        } catch (NullPointerException ignored) {
        }
        formatter.format("%d/%d/%d", lastCreditIdPlusOne, month, year);

        return newCreditNumber.toString();
    }

    private void updateFromInReviewToActive(CreditEntity creditEntity) {
        try {
            creditEntity.setStatus("active");
            this.creditRepository.save(creditEntity);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private HashMap<String, String> ifProperFileUploadedAndReturnNameAndCreditNumber(String fileName) {
        String patterns = "\\S*[_]\\S*[_]\\d{1,2}[_]\\d{1,2}[_]\\d{4}.pdf";
        Pattern pattern = Pattern.compile(patterns);
        if (pattern.matcher(fileName).matches()) {
            String name = fileName.replaceAll("(\\S*)[_](\\S*)[_]\\d{1,2}[_]\\d{1,2}[_]\\d{4}.pdf", "$1 $2");
            String creditNumber = fileName.replaceAll("(\\S*)[_](\\S*)[_](\\d{1,2}[_]\\d{1,2}[_]\\d{4}).pdf", "$3");
            creditNumber = creditNumber.replaceAll("_", "/");
            HashMap<String, String> returnMap = new HashMap<>();
            returnMap.put("name", name);
            returnMap.put("creditNumber", creditNumber);
            return returnMap;
        } else
            return null;
    }

    public void updateFromProcessingToInReview(String fileName) {
        try {
            HashMap<String, String> mapToCheck = ifProperFileUploadedAndReturnNameAndCreditNumber(fileName);
            if(mapToCheck != null){
                Optional<CreditEntity> creditEntity = this.creditRepository.findByCreditNumber(mapToCheck.get("creditNumber"));
                if(creditEntity.isPresent() &&
                        (userService.getUser((long) creditEntity.get().getUserId()).getFirstName() + " " +
                                userService.getUser((long) creditEntity.get().getUserId()).getLastName())
                                .equals(mapToCheck.get("name"))){
                    creditEntity.get().setStatus("review");
                    this.creditRepository.save(creditEntity.get());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //    @Scheduled(cron = "[Seconds] [Minutes] [Hours] [Day of month] [Month] [Day of week] [Year]")
//    Fires at 12 PM every day:
    @Scheduled(cron = "0 1 0 * * ?")
    public void updateFromInReviewToActiveScheduled() {
        List<CreditEntity> allByStatusEquals = this.creditRepository.findAllByStatusEquals("review");

        for (CreditEntity creditEntity : allByStatusEquals) {
            updateFromInReviewToActive(creditEntity);
        }
        System.out.println("changed");
    }
}
