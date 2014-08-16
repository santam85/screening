package org.santam.screening.model;

import javax.persistence.*;

@Entity
@Table(name = "polipi")
public class PolipiEntity {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;
    @Column(name = "dimensione")
    private Float dimensione;
    @Column(name = "tipo")
    private String tipo;
    @Column(name = "sede")
    private String sede;
    @Column(name = "displasia")
    private String displasia;
    @Column(name = "istologia")
    private String istologia;

    @ManyToOne
    @JoinColumn(name = "colonscopia_esami_id", referencedColumnName = "esami_id", nullable = false)
    private ColonscopiaEntity colonscopia;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Float getDimensione() {
        return dimensione;
    }

    public void setDimensione(Float dimensione) {
        this.dimensione = dimensione;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getSede() {
        return sede;
    }

    public void setSede(String sede) {
        this.sede = sede;
    }

    public String getDisplasia() {
        return displasia;
    }

    public void setDisplasia(String displasia) {
        this.displasia = displasia;
    }

    public String getIstologia() {
        return istologia;
    }

    public void setIstologia(String istologia) {
        this.istologia = istologia;
    }

    public ColonscopiaEntity getColonscopia() {
        return colonscopia;
    }

    public void setColonscopia(ColonscopiaEntity colonscopia) {
        this.colonscopia = colonscopia;
    }
}
