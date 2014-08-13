package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "anagrafica")
public class AnagraficaEntity {
    private int id;
    private Boolean screening;
    private String cartella;
    private String nome;
    private String cognome;
    private String iniziali;
    private String sesso;
    private Date datanascita;
    private String luogonascita;
    private String nazionenascita;
    private Float peso;
    private Float altezza;
    private Float bmi;
    private Boolean fumo;
    private Boolean alcohol;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "screening")
    public Boolean getScreening() {
        return screening;
    }

    public void setScreening(Boolean screening) {
        this.screening = screening;
    }

    @Basic
    @Column(name = "cartella")
    public String getCartella() {
        return cartella;
    }

    public void setCartella(String cartella) {
        this.cartella = cartella;
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
    @Column(name = "iniziali")
    public String getIniziali() {
        return iniziali;
    }

    public void setIniziali(String iniziali) {
        this.iniziali = iniziali;
    }

    @Basic
    @Column(name = "sesso")
    public String getSesso() {
        return sesso;
    }

    public void setSesso(String sesso) {
        this.sesso = sesso;
    }

    @Basic
    @Column(name = "datanascita")
    public Date getDatanascita() {
        return datanascita;
    }

    public void setDatanascita(Date datanascita) {
        this.datanascita = datanascita;
    }

    @Basic
    @Column(name = "luogonascita")
    public String getLuogonascita() {
        return luogonascita;
    }

    public void setLuogonascita(String luogonascita) {
        this.luogonascita = luogonascita;
    }

    @Basic
    @Column(name = "nazionenascita")
    public String getNazionenascita() {
        return nazionenascita;
    }

    public void setNazionenascita(String nazionenascita) {
        this.nazionenascita = nazionenascita;
    }

    @Basic
    @Column(name = "peso")
    public Float getPeso() {
        return peso;
    }

    public void setPeso(Float peso) {
        this.peso = peso;
    }

    @Basic
    @Column(name = "altezza")
    public Float getAltezza() {
        return altezza;
    }

    public void setAltezza(Float altezza) {
        this.altezza = altezza;
    }

    @Basic
    @Column(name = "bmi")
    public Float getBmi() {
        return bmi;
    }

    public void setBmi(Float bmi) {
        this.bmi = bmi;
    }

    @Basic
    @Column(name = "fumo")
    public Boolean getFumo() {
        return fumo;
    }

    public void setFumo(Boolean fumo) {
        this.fumo = fumo;
    }

    @Basic
    @Column(name = "alcohol")
    public Boolean getAlcohol() {
        return alcohol;
    }

    public void setAlcohol(Boolean alcohol) {
        this.alcohol = alcohol;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AnagraficaEntity that = (AnagraficaEntity) o;

        if (id != that.id) return false;
        if (alcohol != null ? !alcohol.equals(that.alcohol) : that.alcohol != null) return false;
        if (altezza != null ? !altezza.equals(that.altezza) : that.altezza != null) return false;
        if (bmi != null ? !bmi.equals(that.bmi) : that.bmi != null) return false;
        if (cartella != null ? !cartella.equals(that.cartella) : that.cartella != null) return false;
        if (cognome != null ? !cognome.equals(that.cognome) : that.cognome != null) return false;
        if (datanascita != null ? !datanascita.equals(that.datanascita) : that.datanascita != null) return false;
        if (fumo != null ? !fumo.equals(that.fumo) : that.fumo != null) return false;
        if (iniziali != null ? !iniziali.equals(that.iniziali) : that.iniziali != null) return false;
        if (luogonascita != null ? !luogonascita.equals(that.luogonascita) : that.luogonascita != null) return false;
        if (nazionenascita != null ? !nazionenascita.equals(that.nazionenascita) : that.nazionenascita != null)
            return false;
        if (nome != null ? !nome.equals(that.nome) : that.nome != null) return false;
        if (peso != null ? !peso.equals(that.peso) : that.peso != null) return false;
        if (screening != null ? !screening.equals(that.screening) : that.screening != null) return false;
        if (sesso != null ? !sesso.equals(that.sesso) : that.sesso != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (screening != null ? screening.hashCode() : 0);
        result = 31 * result + (cartella != null ? cartella.hashCode() : 0);
        result = 31 * result + (nome != null ? nome.hashCode() : 0);
        result = 31 * result + (cognome != null ? cognome.hashCode() : 0);
        result = 31 * result + (iniziali != null ? iniziali.hashCode() : 0);
        result = 31 * result + (sesso != null ? sesso.hashCode() : 0);
        result = 31 * result + (datanascita != null ? datanascita.hashCode() : 0);
        result = 31 * result + (luogonascita != null ? luogonascita.hashCode() : 0);
        result = 31 * result + (nazionenascita != null ? nazionenascita.hashCode() : 0);
        result = 31 * result + (peso != null ? peso.hashCode() : 0);
        result = 31 * result + (altezza != null ? altezza.hashCode() : 0);
        result = 31 * result + (bmi != null ? bmi.hashCode() : 0);
        result = 31 * result + (fumo != null ? fumo.hashCode() : 0);
        result = 31 * result + (alcohol != null ? alcohol.hashCode() : 0);
        return result;
    }
}
