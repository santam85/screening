package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "terapie")
public class TerapieEntity {
    private int id;
    private String tipo;
    private String descrizione;
    private Date inizio;
    private Date fine;
    private Integer durata;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "tipo")
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Basic
    @Column(name = "descrizione")
    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    @Basic
    @Column(name = "inizio")
    public Date getInizio() {
        return inizio;
    }

    public void setInizio(Date inizio) {
        this.inizio = inizio;
    }

    @Basic
    @Column(name = "fine")
    public Date getFine() {
        return fine;
    }

    public void setFine(Date fine) {
        this.fine = fine;
    }

    @Basic
    @Column(name = "durata")
    public Integer getDurata() {
        return durata;
    }

    public void setDurata(Integer durata) {
        this.durata = durata;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TerapieEntity that = (TerapieEntity) o;

        if (id != that.id) return false;
        if (descrizione != null ? !descrizione.equals(that.descrizione) : that.descrizione != null) return false;
        if (durata != null ? !durata.equals(that.durata) : that.durata != null) return false;
        if (fine != null ? !fine.equals(that.fine) : that.fine != null) return false;
        if (inizio != null ? !inizio.equals(that.inizio) : that.inizio != null) return false;
        if (tipo != null ? !tipo.equals(that.tipo) : that.tipo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (tipo != null ? tipo.hashCode() : 0);
        result = 31 * result + (descrizione != null ? descrizione.hashCode() : 0);
        result = 31 * result + (inizio != null ? inizio.hashCode() : 0);
        result = 31 * result + (fine != null ? fine.hashCode() : 0);
        result = 31 * result + (durata != null ? durata.hashCode() : 0);
        return result;
    }
}
