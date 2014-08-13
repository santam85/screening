package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "polipi")
public class PolipiEntity {
    private int id;
    private Float dimensione;
    private String tipo;
    private String sede;
    private String displasia;
    private String istologia;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "dimensione")
    public Float getDimensione() {
        return dimensione;
    }

    public void setDimensione(Float dimensione) {
        this.dimensione = dimensione;
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
    @Column(name = "sede")
    public String getSede() {
        return sede;
    }

    public void setSede(String sede) {
        this.sede = sede;
    }

    @Basic
    @Column(name = "displasia")
    public String getDisplasia() {
        return displasia;
    }

    public void setDisplasia(String displasia) {
        this.displasia = displasia;
    }

    @Basic
    @Column(name = "istologia")
    public String getIstologia() {
        return istologia;
    }

    public void setIstologia(String istologia) {
        this.istologia = istologia;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PolipiEntity that = (PolipiEntity) o;

        if (id != that.id) return false;
        if (dimensione != null ? !dimensione.equals(that.dimensione) : that.dimensione != null) return false;
        if (displasia != null ? !displasia.equals(that.displasia) : that.displasia != null) return false;
        if (istologia != null ? !istologia.equals(that.istologia) : that.istologia != null) return false;
        if (sede != null ? !sede.equals(that.sede) : that.sede != null) return false;
        if (tipo != null ? !tipo.equals(that.tipo) : that.tipo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (dimensione != null ? dimensione.hashCode() : 0);
        result = 31 * result + (tipo != null ? tipo.hashCode() : 0);
        result = 31 * result + (sede != null ? sede.hashCode() : 0);
        result = 31 * result + (displasia != null ? displasia.hashCode() : 0);
        result = 31 * result + (istologia != null ? istologia.hashCode() : 0);
        return result;
    }
}
