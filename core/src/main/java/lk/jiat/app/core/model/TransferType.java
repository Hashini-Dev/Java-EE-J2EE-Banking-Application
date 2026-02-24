package lk.jiat.app.core.model;

import jakarta.persistence.*;

@Entity
@Table(name = "transfer_type")
public class TransferType implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(unique = true, nullable = false, length = 45)
    private String type;

    public TransferType() {
    }

    public TransferType(String type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
