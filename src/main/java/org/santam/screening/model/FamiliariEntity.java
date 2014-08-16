package org.santam.screening.model;

import javax.persistence.*;

@Entity
@Table(name = "familiari")
public class FamiliariEntity {
    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;
    @Column(name = "grado")
    private int grado;
    @Column(name = "ccr")
    private Boolean ccr;
    @Column(name = "pa")
    private Boolean pa;
    @Column(name = "altric")
    private Boolean altric;
    @Column(name = "desc_altri")
    private String descAltri;
    @Column(name = "sindrome")
    private String sindrome;
    @Column(name = "mutazioni")
    private String mutazioni;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getGrado() {
        return grado;
    }

    public void setGrado(int grado) {
        this.grado = grado;
    }

    public Boolean getCcr() {
        return ccr;
    }

    public void setCcr(Boolean ccr) {
        this.ccr = ccr;
    }

    public Boolean getPa() {
        return pa;
    }

    public void setPa(Boolean pa) {
        this.pa = pa;
    }

    public Boolean getAltric() {
        return altric;
    }

    public void setAltric(Boolean altric) {
        this.altric = altric;
    }

    public String getDescAltri() {
        return descAltri;
    }

    public void setDescAltri(String descAltri) {
        this.descAltri = descAltri;
    }

    public String getSindrome() {
        return sindrome;
    }

    public void setSindrome(String sindrome) {
        this.sindrome = sindrome;
    }

    public String getMutazioni() {
        return mutazioni;
    }

    public void setMutazioni(String mutazioni) {
        this.mutazioni = mutazioni;
    }
}
