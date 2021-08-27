package com.polsl.factoringcompany.order;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/order")
public class OrderController {

    private final OrderService orderService;

    @GetMapping
    public List<OrderEntity> getOrders() {
        return this.orderService.getOrders();
    }


    @GetMapping(path = "/{id}")
    public OrderEntity getOrder(@PathVariable Long id) {
        return this.orderService.getOrder(id);
    }


    @PostMapping
    public OrderEntity addOrder(@RequestBody OrderDto orderDto) {
        return this.orderService.addOrder(orderDto);
    }


    @PutMapping("/{id}")
    public OrderEntity updateOrder(@PathVariable Long id, @RequestBody OrderDto orderDto) {
        return this.orderService.updateOrder(id, orderDto);
    }


    @DeleteMapping("/{id}")
    public void deleteOrder(@PathVariable Long id) {
        this.orderService.deleteOrder(id);
    }
}
