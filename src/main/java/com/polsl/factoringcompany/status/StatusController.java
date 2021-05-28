package com.polsl.factoringcompany.status;

import com.polsl.factoringcompany.exceptions.IdNotFoundInDatabaseException;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/status")
public class StatusController {

    private final StatusService statusService;


    @GetMapping
    public List<StatusEntity> getStatuses(){
        return statusService.getStatuses();
    }


    @GetMapping(path = "/{id}")
    public StatusEntity getStatus(@PathVariable Long id){
        try {
            return this.statusService.getStatus(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }


    @PostMapping
    public StatusEntity addStatus(@RequestParam() String name) {
        try {
            return this.statusService.addStatus(name);
//        } catch (ItemExistsInDatabaseException e) {
//            System.out.println(e.getMessage());
//            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
        } catch (RuntimeException  e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @PutMapping("/{id}")
    public StatusEntity updateStatus(@PathVariable Long id, @RequestParam String name) {
        try {
            return this.statusService.updateStatus(id, name);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage(), e);
//        } catch (ItemExistsInDatabaseException e) {
//            System.out.println(e.getMessage());
//            throw new ResponseStatusException(HttpStatus.CONFLICT, e.getMessage(), e);
        } catch (RuntimeException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage(), e);
        }
    }


    @DeleteMapping("/{id}")
    public void deleteStatus(@PathVariable Long id) {
        try {
            this.statusService.deleteStatus(id);
        } catch (IdNotFoundInDatabaseException e) {
            System.out.println(e.getMessage());
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage(), e);
        }
    }
}
