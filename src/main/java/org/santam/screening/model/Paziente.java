package org.santam.screening.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;

@Entity
@Table(name = "anagrafica")
public class Paziente {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private int id;

    @Column(name = "screening")
    private Boolean screening;

    @Column(name = "cartella")
    private String cartella;

    @Column(name = "nome")
    private String nome;

    @Column(name = "cognome")
    private String cognome;

    @Column(name = "iniziali")
    private String iniziali;


    @Column(name = "sesso")
    private String sesso;

    @Column(name = "datanascita")
    @Temporal(value = TemporalType.DATE)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date datanascita;

    @Column(name = "luogonascita")
    private String luogonascita;

    @Column(name = "nazionenascita")
    private String nazionenascita;

    @Column(name = "peso")
    private Float peso;

    @Column(name = "altezza")
    private Float altezza;

    @Column(name = "bmi")
    private Float bmi;

    @Column(name = "fumo")
    private Boolean fumo;

    @Column(name = "alcohol")
    private Boolean alcohol;

    @OneToMany(mappedBy = "paziente")
    private Collection<Esame> esami;

    @OneToMany(mappedBy = "anagraficaByAnagraficaId")
    private Collection<TerapieEntity> terapie;

    @OneToMany(mappedBy = "anagraficaByAnagraficaId")
    private Collection<PatologiecEntity> patologiec;

    @OneToMany(mappedBy = "anagraficaByAnagraficaId")
    private Collection<FamiliariEntity> familiari;

    public int getId() {
        return id;
    }

    public Boolean getScreening() {
        return screening;
    }

    public void setScreening(Boolean screening) {
        this.screening = screening;
    }

    public String getCartella() {
        return cartella;
    }

    public void setCartella(String cartella) {
        this.cartella = cartella;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getIniziali() {
        return iniziali;
    }

    public void setIniziali(String iniziali) {
        this.iniziali = iniziali;
    }

    public String getSesso() {
        return sesso;
    }

    public void setSesso(String sesso) {
        this.sesso = sesso;
    }

    public Date getDatanascita() {
        return datanascita;
    }

    public void setDatanascita(Date datanascita) {
        this.datanascita = datanascita;
    }

    public String getLuogonascita() {
        return luogonascita;
    }

    public void setLuogonascita(String luogonascita) {
        this.luogonascita = luogonascita;
    }

    public String getNazionenascita() {
        return nazionenascita;
    }

    public void setNazionenascita(String nazionenascita) {
        this.nazionenascita = nazionenascita;
    }

    public Float getPeso() {
        return peso;
    }

    public void setPeso(Float peso) {
        this.peso = peso;
    }

    public Float getAltezza() {
        return altezza;
    }

    public void setAltezza(Float altezza) {
        this.altezza = altezza;
    }

    public Float getBmi() {
        return bmi;
    }

    public void setBmi(Float bmi) {
        this.bmi = bmi;
    }

    public Boolean getFumo() {
        return fumo;
    }

    public void setFumo(Boolean fumo) {
        this.fumo = fumo;
    }

    public Boolean getAlcohol() {
        return alcohol;
    }

    public void setAlcohol(Boolean alcohol) {
        this.alcohol = alcohol;
    }

    public Collection<Esame> getEsami() {
        return esami;
    }

    public void setEsami(Collection<Esame> esami) {
        this.esami = esami;
    }

    public Collection<TerapieEntity> getTerapie() {
        return terapie;
    }

    public void setTerapie(Collection<TerapieEntity> terapie) {
        this.terapie = terapie;
    }

    public Collection<PatologiecEntity> getPatologiec() {
        return patologiec;
    }

    public void setPatologiec(Collection<PatologiecEntity> patologiec) {
        this.patologiec = patologiec;
    }

    public Collection<FamiliariEntity> getFamiliari() {
        return familiari;
    }

    public void setFamiliari(Collection<FamiliariEntity> familiari) {
        this.familiari = familiari;
    }
}
