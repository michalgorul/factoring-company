package com.polsl.factoringcompany.files;

import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@AllArgsConstructor
@RestController
@RequestMapping(path = "/api/file")
public class FileController {

    private final FileService fileService;

    @PostMapping
    public ResponseEntity<String> uploadFile(@RequestParam("file") MultipartFile file) {
        return this.fileService.uploadFile(file);
    }

    @GetMapping
    public List<FileResponse> getFiles() {
        return this.fileService.getAllFiles();
    }


    @GetMapping("{id}")
    public ResponseEntity<byte[]> getFile(@PathVariable UUID id) {
        return this.fileService.getFile(id);
    }
}
