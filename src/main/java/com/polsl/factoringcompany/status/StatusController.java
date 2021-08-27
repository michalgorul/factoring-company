package com.polsl.factoringcompany.status;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/status")
public class StatusController {

    private final StatusService statusService;


    @GetMapping
    public List<StatusEntity> getStatuses() {
        return statusService.getStatuses();
    }


    @GetMapping(path = "/{id}")
    public StatusEntity getStatus(@PathVariable Long id) {
        return this.statusService.getStatus(id);
    }


    @PostMapping
    public StatusEntity addStatus(@RequestParam() String name) {
        return this.statusService.addStatus(name);
    }


    @PutMapping("/{id}")
    public StatusEntity updateStatus(@PathVariable Long id, @RequestParam String name) {
        return this.statusService.updateStatus(id, name);
    }


    @DeleteMapping("/{id}")
    public void deleteStatus(@PathVariable Long id) {
        this.statusService.deleteStatus(id);
    }
}
