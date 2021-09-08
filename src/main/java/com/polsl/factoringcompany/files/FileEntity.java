package com.polsl.factoringcompany.files;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.polsl.factoringcompany.user.UserEntity;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Arrays;
import java.util.Objects;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "file")
public class FileEntity {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid2")
    private UUID id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "size", nullable = false)
    private Long size;

    @Column(name = "content_type", nullable = false)
    private String contentType;

    @Lob
    @Column(name = "data", nullable = false)
    private byte[] data;

    @Column(name = "user_id", nullable = false)
    private int userId;

    @Column(name = "catalog", nullable = false, length = 50)
    private String catalog;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", nullable = false, insertable = false, updatable = false)
    private UserEntity userByUserId;


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FileEntity that = (FileEntity) o;
        return userId == that.userId && Objects.equals(id, that.id) && Objects.equals(name, that.name) && Objects.equals(size, that.size) && Objects.equals(contentType, that.contentType) && Arrays.equals(data, that.data) && Objects.equals(catalog, that.catalog) && Objects.equals(userByUserId, that.userByUserId);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(id, name, size, contentType, userId, catalog, userByUserId);
        result = 31 * result + Arrays.hashCode(data);
        return result;
    }
}