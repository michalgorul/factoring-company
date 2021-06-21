package com.polsl.factoringcompany.order;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;

    public List<OrderEntity> getOrders() {
        return this.orderRepository.findAll();
    }

    public OrderEntity getOrder(Long id) {
        return this.orderRepository.findById(id)
                .orElseThrow(() -> new IdNotFoundInDatabaseException("Order", id));
    }

    public OrderEntity addOrder(OrderDto orderDto) {

        try {
            return this.orderRepository.save(new OrderEntity(orderDto));

        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public OrderEntity updateOrder(Long id, OrderDto orderDto) {

        Optional<OrderEntity> orderEntityOptional = orderRepository.findById(id);

        if (orderEntityOptional.isEmpty())
            throw new IdNotFoundInDatabaseException("Order", id);

        try {
            orderEntityOptional.get().setOrderType(orderDto.getOrderType());
            orderEntityOptional.get().setOrderDate(orderDto.getOrderDate());
            orderEntityOptional.get().setFirstPayAmmount(BigDecimal.valueOf(orderDto.getAmmount().doubleValue() * 0.80f));
            orderEntityOptional.get().setSecondPayAmmount(BigDecimal.valueOf(orderDto.getAmmount().doubleValue() * 0.20f));
            orderEntityOptional.get().setCommissionRate(orderDto.getCommissionRate());
            orderEntityOptional.get().setCommissionValue(BigDecimal.valueOf(
                    orderDto.getAmmount().doubleValue() * orderDto.getCommissionRate().doubleValue()));
            orderEntityOptional.get().setInvoiceId(orderDto.getInvoiceId());
            orderEntityOptional.get().setUserId(orderDto.getUserId());
            orderEntityOptional.get().setStatusId(orderDto.getStatusId());


            return this.orderRepository.save(orderEntityOptional.get());
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteOrder(Long id) {
        try {
            this.orderRepository.deleteById(id);
        } catch (RuntimeException ex) {
            throw new IdNotFoundInDatabaseException("Order", id);
        }
    }
}
