package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "users")
public class User {
    private int id;
    private String email;
    private String passwordhash;
    private String salt;
    private Boolean status;
    private String role;
    private String nome;
    private String cognome;
    private Timestamp lastlogged;
    private Timestamp dateCreated;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "email")
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "passwordhash")
    public String getPasswordhash() {
        return passwordhash;
    }
    public void setPasswordhash(String passwordhash) {
        this.passwordhash = passwordhash;
    }

    @Basic
    @Column(name = "salt")
    public String getSalt() {
        return salt;
    }
    public void setSalt(String salt) {
        this.salt = salt;
    }

    @Basic
    @Column(name = "status")
    public Boolean getStatus() {
        return status;
    }
    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Basic
    @Column(name = "role")
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }

    @Basic
    @Column(name = "nome")
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }

    @Basic
    @Column(name = "cognome")
    public String getCognome() {
        return cognome;
    }
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    @Basic
    @Column(name = "lastlogged")
    public Timestamp getLastlogged() {
        return lastlogged;
    }
    public void setLastlogged(Timestamp lastlogged) {
        this.lastlogged = lastlogged;
    }

    @Basic
    @Column(name = "date_created")
    public Timestamp getDateCreated() {
        return dateCreated;
    }
    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }
}
