package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "familiari")
public class FamiliariEntity {
    private int id;
    private Integer grado;
    private Boolean ccr;
    private Boolean pa;
    private Boolean altric;
    private String descAltri;
    private String sindrome;
    private String mutazioni;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "grado")
    public Integer getGrado() {
        return grado;
    }

    public void setGrado(Integer grado) {
        this.grado = grado;
    }

    @Basic
    @Column(name = "ccr")
    public Boolean getCcr() {
        return ccr;
    }

    public void setCcr(Boolean ccr) {
        this.ccr = ccr;
    }

    @Basic
    @Column(name = "pa")
    public Boolean getPa() {
        return pa;
    }

    public void setPa(Boolean pa) {
        this.pa = pa;
    }

    @Basic
    @Column(name = "altric")
    public Boolean getAltric() {
        return altric;
    }

    public void setAltric(Boolean altric) {
        this.altric = altric;
    }

    @Basic
    @Column(name = "desc_altri")
    public String getDescAltri() {
        return descAltri;
    }

    public void setDescAltri(String descAltri) {
        this.descAltri = descAltri;
    }

    @Basic
    @Column(name = "sindrome")
    public String getSindrome() {
        return sindrome;
    }

    public void setSindrome(String sindrome) {
        this.sindrome = sindrome;
    }

    @Basic
    @Column(name = "mutazioni")
    public String getMutazioni() {
        return mutazioni;
    }

    public void setMutazioni(String mutazioni) {
        this.mutazioni = mutazioni;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FamiliariEntity that = (FamiliariEntity) o;

        if (id != that.id) return false;
        if (altric != null ? !altric.equals(that.altric) : that.altric != null) return false;
        if (ccr != null ? !ccr.equals(that.ccr) : that.ccr != null) return false;
        if (descAltri != null ? !descAltri.equals(that.descAltri) : that.descAltri != null) return false;
        if (grado != null ? !grado.equals(that.grado) : that.grado != null) return false;
        if (mutazioni != null ? !mutazioni.equals(that.mutazioni) : that.mutazioni != null) return false;
        if (pa != null ? !pa.equals(that.pa) : that.pa != null) return false;
        if (sindrome != null ? !sindrome.equals(that.sindrome) : that.sindrome != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (grado != null ? grado.hashCode() : 0);
        result = 31 * result + (ccr != null ? ccr.hashCode() : 0);
        result = 31 * result + (pa != null ? pa.hashCode() : 0);
        result = 31 * result + (altric != null ? altric.hashCode() : 0);
        result = 31 * result + (descAltri != null ? descAltri.hashCode() : 0);
        result = 31 * result + (sindrome != null ? sindrome.hashCode() : 0);
        result = 31 * result + (mutazioni != null ? mutazioni.hashCode() : 0);
        return result;
    }
}
