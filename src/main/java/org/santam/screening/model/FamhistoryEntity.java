package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "famhistory")
@IdClass(FamhistoryEntityPK.class)
public class FamhistoryEntity {
    private int id;
    private int anagraficaId;
    private Boolean fccr;
    private Integer nccrgrado1;
    private Boolean faltrigrado1;
    private String tipoaltri;
    private Boolean fpa;
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

    @Id
    @Column(name = "anagrafica_id")
    public int getAnagraficaId() {
        return anagraficaId;
    }

    public void setAnagraficaId(int anagraficaId) {
        this.anagraficaId = anagraficaId;
    }

    @Basic
    @Column(name = "fccr")
    public Boolean getFccr() {
        return fccr;
    }

    public void setFccr(Boolean fccr) {
        this.fccr = fccr;
    }

    @Basic
    @Column(name = "nccrgrado1")
    public Integer getNccrgrado1() {
        return nccrgrado1;
    }

    public void setNccrgrado1(Integer nccrgrado1) {
        this.nccrgrado1 = nccrgrado1;
    }

    @Basic
    @Column(name = "faltrigrado1")
    public Boolean getFaltrigrado1() {
        return faltrigrado1;
    }

    public void setFaltrigrado1(Boolean faltrigrado1) {
        this.faltrigrado1 = faltrigrado1;
    }

    @Basic
    @Column(name = "tipoaltri")
    public String getTipoaltri() {
        return tipoaltri;
    }

    public void setTipoaltri(String tipoaltri) {
        this.tipoaltri = tipoaltri;
    }

    @Basic
    @Column(name = "fpa")
    public Boolean getFpa() {
        return fpa;
    }

    public void setFpa(Boolean fpa) {
        this.fpa = fpa;
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

        FamhistoryEntity that = (FamhistoryEntity) o;

        if (anagraficaId != that.anagraficaId) return false;
        if (id != that.id) return false;
        if (faltrigrado1 != null ? !faltrigrado1.equals(that.faltrigrado1) : that.faltrigrado1 != null) return false;
        if (fccr != null ? !fccr.equals(that.fccr) : that.fccr != null) return false;
        if (fpa != null ? !fpa.equals(that.fpa) : that.fpa != null) return false;
        if (mutazioni != null ? !mutazioni.equals(that.mutazioni) : that.mutazioni != null) return false;
        if (nccrgrado1 != null ? !nccrgrado1.equals(that.nccrgrado1) : that.nccrgrado1 != null) return false;
        if (sindrome != null ? !sindrome.equals(that.sindrome) : that.sindrome != null) return false;
        if (tipoaltri != null ? !tipoaltri.equals(that.tipoaltri) : that.tipoaltri != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + anagraficaId;
        result = 31 * result + (fccr != null ? fccr.hashCode() : 0);
        result = 31 * result + (nccrgrado1 != null ? nccrgrado1.hashCode() : 0);
        result = 31 * result + (faltrigrado1 != null ? faltrigrado1.hashCode() : 0);
        result = 31 * result + (tipoaltri != null ? tipoaltri.hashCode() : 0);
        result = 31 * result + (fpa != null ? fpa.hashCode() : 0);
        result = 31 * result + (sindrome != null ? sindrome.hashCode() : 0);
        result = 31 * result + (mutazioni != null ? mutazioni.hashCode() : 0);
        return result;
    }
}
