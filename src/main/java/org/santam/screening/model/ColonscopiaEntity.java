package org.santam.screening.model;

import javax.persistence.*;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "colonscopia")
@DiscriminatorValue("csc")
@PrimaryKeyJoinColumn(name = "esami_id", referencedColumnName = "id")
public class ColonscopiaEntity extends Esame {

    @Column(name = "pulizia")
    private String pulizia;

    @Column(name = "completo")
    private Boolean completo;

    @Column(name = "tipopreparazione")
    private String tipopreparazione;

    @Column(name = "cancro")
    private Boolean cancro;

    @Column(name = "stadio")
    private String stadio;

    @Column(name = "tnm")
    private String tnm;

    @Column(name = "nlinfonodipositivi")
    private Integer nlinfonodipositivi;

    @Column(name = "intervento")
    private String intervento;

    @Column(name = "glicemia")
    private Float glicemia;

    @Column(name = "trigliceridi")
    private Float trigliceridi;

    @Column(name = "colesterolo")
    private Float colesterolo;

    @Column(name = "inr")
    private Float inr;

    @Column(name = "ihc")
    private String ihc;

    @Column(name = "mutazioni")
    private String mutazioni;

    @Column(name = "chemio")
    private String chemio;

    @Column(name = "radio")
    private Boolean radio;

    @Column(name = "sedecancro_cieco")
    private Boolean sedecancroCieco;

    @Column(name = "sedecancro_ascendente")
    private Boolean sedecancroAscendente;

    @Column(name = "sedecancro_flessuraepatica")
    private Boolean sedecancroFlessuraepatica;

    @Column(name = "sedecancro_trasverso")
    private Boolean sedecancroTrasverso;

    @Column(name = "sedecancro_flessurasplenica")
    private Boolean sedecancroFlessurasplenica;

    @Column(name = "sedecancro_sigma")
    private Boolean sedecancroSigma;

    @Column(name = "sedecancro_retto")
    private Boolean sedecancroRetto;

    @Column(name = "sedecancro_discendente")
    private Boolean sedecancroDiscendente;

    @Column(name = "altric")
    private String altric;

    @OneToMany(mappedBy = "colonscopia")
    private Collection<PolipiEntity> polipi;

    public String getPulizia() {
        return pulizia;
    }
    public void setPulizia(String pulizia) {
        this.pulizia = pulizia;
    }


    public Boolean getCompleto() {
        return completo;
    }

    public void setCompleto(Boolean completo) {
        this.completo = completo;
    }

    public String getTipopreparazione() {
        return tipopreparazione;
    }

    public void setTipopreparazione(String tipopreparazione) {
        this.tipopreparazione = tipopreparazione;
    }


    public Boolean getCancro() {
        return cancro;
    }

    public void setCancro(Boolean cancro) {
        this.cancro = cancro;
    }


    public String getStadio() {
        return stadio;
    }

    public void setStadio(String stadio) {
        this.stadio = stadio;
    }


    public String getTnm() {
        return tnm;
    }

    public void setTnm(String tnm) {
        this.tnm = tnm;
    }


    public Integer getNlinfonodipositivi() {
        return nlinfonodipositivi;
    }

    public void setNlinfonodipositivi(Integer nlinfonodipositivi) {
        this.nlinfonodipositivi = nlinfonodipositivi;
    }


    public String getIntervento() {
        return intervento;
    }

    public void setIntervento(String intervento) {
        this.intervento = intervento;
    }


    public Float getGlicemia() {
        return glicemia;
    }

    public void setGlicemia(Float glicemia) {
        this.glicemia = glicemia;
    }


    public Float getTrigliceridi() {
        return trigliceridi;
    }

    public void setTrigliceridi(Float trigliceridi) {
        this.trigliceridi = trigliceridi;
    }


    public Float getColesterolo() {
        return colesterolo;
    }

    public void setColesterolo(Float colesterolo) {
        this.colesterolo = colesterolo;
    }


    public Float getInr() {
        return inr;
    }

    public void setInr(Float inr) {
        this.inr = inr;
    }


    public String getIhc() {
        return ihc;
    }

    public void setIhc(String ihc) {
        this.ihc = ihc;
    }


    public String getMutazioni() {
        return mutazioni;
    }

    public void setMutazioni(String mutazioni) {
        this.mutazioni = mutazioni;
    }


    public String getChemio() {
        return chemio;
    }

    public void setChemio(String chemio) {
        this.chemio = chemio;
    }

    public Boolean getRadio() {
        return radio;
    }

    public void setRadio(Boolean radio) {
        this.radio = radio;
    }


    public Boolean getSedecancroCieco() {
        return sedecancroCieco;
    }

    public void setSedecancroCieco(Boolean sedecancroCieco) {
        this.sedecancroCieco = sedecancroCieco;
    }


    public Boolean getSedecancroAscendente() {
        return sedecancroAscendente;
    }

    public void setSedecancroAscendente(Boolean sedecancroAscendente) {
        this.sedecancroAscendente = sedecancroAscendente;
    }


    public Boolean getSedecancroFlessuraepatica() {
        return sedecancroFlessuraepatica;
    }

    public void setSedecancroFlessuraepatica(Boolean sedecancroFlessuraepatica) {
        this.sedecancroFlessuraepatica = sedecancroFlessuraepatica;
    }


    public Boolean getSedecancroTrasverso() {
        return sedecancroTrasverso;
    }

    public void setSedecancroTrasverso(Boolean sedecancroTrasverso) {
        this.sedecancroTrasverso = sedecancroTrasverso;
    }


    public Boolean getSedecancroFlessurasplenica() {
        return sedecancroFlessurasplenica;
    }

    public void setSedecancroFlessurasplenica(Boolean sedecancroFlessurasplenica) {
        this.sedecancroFlessurasplenica = sedecancroFlessurasplenica;
    }


    public Boolean getSedecancroSigma() {
        return sedecancroSigma;
    }

    public void setSedecancroSigma(Boolean sedecancroSigma) {
        this.sedecancroSigma = sedecancroSigma;
    }


    public Boolean getSedecancroRetto() {
        return sedecancroRetto;
    }

    public void setSedecancroRetto(Boolean sedecancroRetto) {
        this.sedecancroRetto = sedecancroRetto;
    }


    public Boolean getSedecancroDiscendente() {
        return sedecancroDiscendente;
    }

    public void setSedecancroDiscendente(Boolean sedecancroDiscendente) {
        this.sedecancroDiscendente = sedecancroDiscendente;
    }

    public String getAltric() {
        return altric;
    }

    public void setAltric(String altric) {
        this.altric = altric;
    }

    public Collection<PolipiEntity> getPolipi() {
        return polipi;
    }

    public void setPolipi(Collection<PolipiEntity> polipi) {
        this.polipi = polipi;
    }
}
