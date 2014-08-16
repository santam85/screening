package org.santam.screening.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "famhistory")
public class FamhistoryEntity {

    @EmbeddedId
    private FamhistoryEntityPK id;

    @Column(name = "fccr")
    private Boolean fccr;
    @Column(name = "nccrgrado1")
    private Integer nccrgrado1;
    @Column(name = "faltrigrado1")
    private Boolean faltrigrado1;
    @Column(name = "tipoaltri")
    private String tipoaltri;
    @Column(name = "fpa")
    private Boolean fpa;
    @Column(name = "sindrome")
    private String sindrome;
    @Column(name = "mutazioni")
    private String mutazioni;

    public FamhistoryEntityPK getId() {
        return id;
    }

    public void setId(FamhistoryEntityPK id) {
        this.id = id;
    }

    public Boolean getFccr() {
        return fccr;
    }

    public void setFccr(Boolean fccr) {
        this.fccr = fccr;
    }

    public Integer getNccrgrado1() {
        return nccrgrado1;
    }

    public void setNccrgrado1(Integer nccrgrado1) {
        this.nccrgrado1 = nccrgrado1;
    }

    public Boolean getFaltrigrado1() {
        return faltrigrado1;
    }

    public void setFaltrigrado1(Boolean faltrigrado1) {
        this.faltrigrado1 = faltrigrado1;
    }

    public String getTipoaltri() {
        return tipoaltri;
    }

    public void setTipoaltri(String tipoaltri) {
        this.tipoaltri = tipoaltri;
    }

    public Boolean getFpa() {
        return fpa;
    }

    public void setFpa(Boolean fpa) {
        this.fpa = fpa;
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

    @Embeddable
    public class FamhistoryEntityPK implements Serializable{
        @GeneratedValue
        @Column(name = "id")
        private int id;

        @ManyToOne
        @JoinColumn(name = "anagrafica_id", referencedColumnName = "id")
        private Paziente paziente;

        public int getId() {
            return id;
        }
        public void setId(int id) {
            this.id = id;
        }

        public Paziente getPaziente() {
            return paziente;
        }

        public void setPaziente(Paziente paziente) {
            this.paziente = paziente;
        }
    }
}


