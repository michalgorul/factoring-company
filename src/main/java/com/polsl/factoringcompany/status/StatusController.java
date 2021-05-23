package com.polsl.factoringcompany.status;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/status")
public class StatusController {

    private final StatusService statusService;


    @GetMapping
    public List<StatusEntity> getCurrencies(){
        return statusService.getStatuses();
    }


    @GetMapping(path = "/{id}")
    public ResponseEntity<StatusEntity> getStatus(@PathVariable Long id){
        Optional<StatusEntity> response = statusService.getStatus(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @PostMapping
    public StatusEntity addStatus(@RequestParam() String name) {
        return statusService.addStatus(name);
    }


    @PutMapping("/{id}")
    public ResponseEntity<StatusEntity> updateStatus(@PathVariable Long id, @RequestParam(required = false) String name) {
        Optional<StatusEntity> response = statusService.updateStatus(id, name);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<StatusEntity> deleteStatus(@PathVariable Long id) {
        Optional<StatusEntity> response = statusService.deleteStatus(id);

        return response
                .map(currencyEntity -> ResponseEntity.status(HttpStatus.OK).body(response.get()))
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).body(null));
    }
}
