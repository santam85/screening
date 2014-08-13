package org.santam.screening.model;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@javax.persistence.Table(name = "colonscopia")
public class ColonscopiaEntity {
    private int esamiId;

    @Id
    @javax.persistence.Column(name = "esami_id")
    public int getEsamiId() {
        return esamiId;
    }

    public void setEsamiId(int esamiId) {
        this.esamiId = esamiId;
    }

    private String pulizia;

    @Basic
    @javax.persistence.Column(name = "pulizia")
    public String getPulizia() {
        return pulizia;
    }

    public void setPulizia(String pulizia) {
        this.pulizia = pulizia;
    }

    private Boolean completo;

    @Basic
    @javax.persistence.Column(name = "completo")
    public Boolean getCompleto() {
        return completo;
    }

    public void setCompleto(Boolean completo) {
        this.completo = completo;
    }

    private String tipopreparazione;

    @Basic
    @javax.persistence.Column(name = "tipopreparazione")
    public String getTipopreparazione() {
        return tipopreparazione;
    }

    public void setTipopreparazione(String tipopreparazione) {
        this.tipopreparazione = tipopreparazione;
    }

    private Boolean cancro;

    @Basic
    @javax.persistence.Column(name = "cancro")
    public Boolean getCancro() {
        return cancro;
    }

    public void setCancro(Boolean cancro) {
        this.cancro = cancro;
    }

    private String stadio;

    @Basic
    @javax.persistence.Column(name = "stadio")
    public String getStadio() {
        return stadio;
    }

    public void setStadio(String stadio) {
        this.stadio = stadio;
    }

    private String tnm;

    @Basic
    @javax.persistence.Column(name = "tnm")
    public String getTnm() {
        return tnm;
    }

    public void setTnm(String tnm) {
        this.tnm = tnm;
    }

    private Integer nlinfonodipositivi;

    @Basic
    @javax.persistence.Column(name = "nlinfonodipositivi")
    public Integer getNlinfonodipositivi() {
        return nlinfonodipositivi;
    }

    public void setNlinfonodipositivi(Integer nlinfonodipositivi) {
        this.nlinfonodipositivi = nlinfonodipositivi;
    }

    private String intervento;

    @Basic
    @javax.persistence.Column(name = "intervento")
    public String getIntervento() {
        return intervento;
    }

    public void setIntervento(String intervento) {
        this.intervento = intervento;
    }

    private Float glicemia;

    @Basic
    @javax.persistence.Column(name = "glicemia")
    public Float getGlicemia() {
        return glicemia;
    }

    public void setGlicemia(Float glicemia) {
        this.glicemia = glicemia;
    }

    private Float trigliceridi;

    @Basic
    @javax.persistence.Column(name = "trigliceridi")
    public Float getTrigliceridi() {
        return trigliceridi;
    }

    public void setTrigliceridi(Float trigliceridi) {
        this.trigliceridi = trigliceridi;
    }

    private Float colesterolo;

    @Basic
    @javax.persistence.Column(name = "colesterolo")
    public Float getColesterolo() {
        return colesterolo;
    }

    public void setColesterolo(Float colesterolo) {
        this.colesterolo = colesterolo;
    }

    private Float inr;

    @Basic
    @javax.persistence.Column(name = "inr")
    public Float getInr() {
        return inr;
    }

    public void setInr(Float inr) {
        this.inr = inr;
    }

    private String ihc;

    @Basic
    @javax.persistence.Column(name = "ihc")
    public String getIhc() {
        return ihc;
    }

    public void setIhc(String ihc) {
        this.ihc = ihc;
    }

    private String mutazioni;

    @Basic
    @javax.persistence.Column(name = "mutazioni")
    public String getMutazioni() {
        return mutazioni;
    }

    public void setMutazioni(String mutazioni) {
        this.mutazioni = mutazioni;
    }

    private String chemio;

    @Basic
    @javax.persistence.Column(name = "chemio")
    public String getChemio() {
        return chemio;
    }

    public void setChemio(String chemio) {
        this.chemio = chemio;
    }

    private Boolean radio;

    @Basic
    @javax.persistence.Column(name = "radio")
    public Boolean getRadio() {
        return radio;
    }

    public void setRadio(Boolean radio) {
        this.radio = radio;
    }

    private Boolean sedecancroCieco;

    @Basic
    @javax.persistence.Column(name = "sedecancro_cieco")
    public Boolean getSedecancroCieco() {
        return sedecancroCieco;
    }

    public void setSedecancroCieco(Boolean sedecancroCieco) {
        this.sedecancroCieco = sedecancroCieco;
    }

    private Boolean sedecancroAscendente;

    @Basic
    @javax.persistence.Column(name = "sedecancro_ascendente")
    public Boolean getSedecancroAscendente() {
        return sedecancroAscendente;
    }

    public void setSedecancroAscendente(Boolean sedecancroAscendente) {
        this.sedecancroAscendente = sedecancroAscendente;
    }

    private Boolean sedecancroFlessuraepatica;

    @Basic
    @javax.persistence.Column(name = "sedecancro_flessuraepatica")
    public Boolean getSedecancroFlessuraepatica() {
        return sedecancroFlessuraepatica;
    }

    public void setSedecancroFlessuraepatica(Boolean sedecancroFlessuraepatica) {
        this.sedecancroFlessuraepatica = sedecancroFlessuraepatica;
    }

    private Boolean sedecancroTrasverso;

    @Basic
    @javax.persistence.Column(name = "sedecancro_trasverso")
    public Boolean getSedecancroTrasverso() {
        return sedecancroTrasverso;
    }

    public void setSedecancroTrasverso(Boolean sedecancroTrasverso) {
        this.sedecancroTrasverso = sedecancroTrasverso;
    }

    private Boolean sedecancroFlessurasplenica;

    @Basic
    @javax.persistence.Column(name = "sedecancro_flessurasplenica")
    public Boolean getSedecancroFlessurasplenica() {
        return sedecancroFlessurasplenica;
    }

    public void setSedecancroFlessurasplenica(Boolean sedecancroFlessurasplenica) {
        this.sedecancroFlessurasplenica = sedecancroFlessurasplenica;
    }

    private Boolean sedecancroSigma;

    @Basic
    @javax.persistence.Column(name = "sedecancro_sigma")
    public Boolean getSedecancroSigma() {
        return sedecancroSigma;
    }

    public void setSedecancroSigma(Boolean sedecancroSigma) {
        this.sedecancroSigma = sedecancroSigma;
    }

    private Boolean sedecancroRetto;

    @Basic
    @javax.persistence.Column(name = "sedecancro_retto")
    public Boolean getSedecancroRetto() {
        return sedecancroRetto;
    }

    public void setSedecancroRetto(Boolean sedecancroRetto) {
        this.sedecancroRetto = sedecancroRetto;
    }

    private Boolean sedecancroDiscendente;

    @Basic
    @javax.persistence.Column(name = "sedecancro_discendente")
    public Boolean getSedecancroDiscendente() {
        return sedecancroDiscendente;
    }

    public void setSedecancroDiscendente(Boolean sedecancroDiscendente) {
        this.sedecancroDiscendente = sedecancroDiscendente;
    }

    private String altric;

    @Basic
    @javax.persistence.Column(name = "altric")
    public String getAltric() {
        return altric;
    }

    public void setAltric(String altric) {
        this.altric = altric;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ColonscopiaEntity that = (ColonscopiaEntity) o;

        if (esamiId != that.esamiId) return false;
        if (altric != null ? !altric.equals(that.altric) : that.altric != null) return false;
        if (cancro != null ? !cancro.equals(that.cancro) : that.cancro != null) return false;
        if (chemio != null ? !chemio.equals(that.chemio) : that.chemio != null) return false;
        if (colesterolo != null ? !colesterolo.equals(that.colesterolo) : that.colesterolo != null) return false;
        if (completo != null ? !completo.equals(that.completo) : that.completo != null) return false;
        if (glicemia != null ? !glicemia.equals(that.glicemia) : that.glicemia != null) return false;
        if (ihc != null ? !ihc.equals(that.ihc) : that.ihc != null) return false;
        if (inr != null ? !inr.equals(that.inr) : that.inr != null) return false;
        if (intervento != null ? !intervento.equals(that.intervento) : that.intervento != null) return false;
        if (mutazioni != null ? !mutazioni.equals(that.mutazioni) : that.mutazioni != null) return false;
        if (nlinfonodipositivi != null ? !nlinfonodipositivi.equals(that.nlinfonodipositivi) : that.nlinfonodipositivi != null)
            return false;
        if (pulizia != null ? !pulizia.equals(that.pulizia) : that.pulizia != null) return false;
        if (radio != null ? !radio.equals(that.radio) : that.radio != null) return false;
        if (sedecancroAscendente != null ? !sedecancroAscendente.equals(that.sedecancroAscendente) : that.sedecancroAscendente != null)
            return false;
        if (sedecancroCieco != null ? !sedecancroCieco.equals(that.sedecancroCieco) : that.sedecancroCieco != null)
            return false;
        if (sedecancroDiscendente != null ? !sedecancroDiscendente.equals(that.sedecancroDiscendente) : that.sedecancroDiscendente != null)
            return false;
        if (sedecancroFlessuraepatica != null ? !sedecancroFlessuraepatica.equals(that.sedecancroFlessuraepatica) : that.sedecancroFlessuraepatica != null)
            return false;
        if (sedecancroFlessurasplenica != null ? !sedecancroFlessurasplenica.equals(that.sedecancroFlessurasplenica) : that.sedecancroFlessurasplenica != null)
            return false;
        if (sedecancroRetto != null ? !sedecancroRetto.equals(that.sedecancroRetto) : that.sedecancroRetto != null)
            return false;
        if (sedecancroSigma != null ? !sedecancroSigma.equals(that.sedecancroSigma) : that.sedecancroSigma != null)
            return false;
        if (sedecancroTrasverso != null ? !sedecancroTrasverso.equals(that.sedecancroTrasverso) : that.sedecancroTrasverso != null)
            return false;
        if (stadio != null ? !stadio.equals(that.stadio) : that.stadio != null) return false;
        if (tipopreparazione != null ? !tipopreparazione.equals(that.tipopreparazione) : that.tipopreparazione != null)
            return false;
        if (tnm != null ? !tnm.equals(that.tnm) : that.tnm != null) return false;
        if (trigliceridi != null ? !trigliceridi.equals(that.trigliceridi) : that.trigliceridi != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = esamiId;
        result = 31 * result + (pulizia != null ? pulizia.hashCode() : 0);
        result = 31 * result + (completo != null ? completo.hashCode() : 0);
        result = 31 * result + (tipopreparazione != null ? tipopreparazione.hashCode() : 0);
        result = 31 * result + (cancro != null ? cancro.hashCode() : 0);
        result = 31 * result + (stadio != null ? stadio.hashCode() : 0);
        result = 31 * result + (tnm != null ? tnm.hashCode() : 0);
        result = 31 * result + (nlinfonodipositivi != null ? nlinfonodipositivi.hashCode() : 0);
        result = 31 * result + (intervento != null ? intervento.hashCode() : 0);
        result = 31 * result + (glicemia != null ? glicemia.hashCode() : 0);
        result = 31 * result + (trigliceridi != null ? trigliceridi.hashCode() : 0);
        result = 31 * result + (colesterolo != null ? colesterolo.hashCode() : 0);
        result = 31 * result + (inr != null ? inr.hashCode() : 0);
        result = 31 * result + (ihc != null ? ihc.hashCode() : 0);
        result = 31 * result + (mutazioni != null ? mutazioni.hashCode() : 0);
        result = 31 * result + (chemio != null ? chemio.hashCode() : 0);
        result = 31 * result + (radio != null ? radio.hashCode() : 0);
        result = 31 * result + (sedecancroCieco != null ? sedecancroCieco.hashCode() : 0);
        result = 31 * result + (sedecancroAscendente != null ? sedecancroAscendente.hashCode() : 0);
        result = 31 * result + (sedecancroFlessuraepatica != null ? sedecancroFlessuraepatica.hashCode() : 0);
        result = 31 * result + (sedecancroTrasverso != null ? sedecancroTrasverso.hashCode() : 0);
        result = 31 * result + (sedecancroFlessurasplenica != null ? sedecancroFlessurasplenica.hashCode() : 0);
        result = 31 * result + (sedecancroSigma != null ? sedecancroSigma.hashCode() : 0);
        result = 31 * result + (sedecancroRetto != null ? sedecancroRetto.hashCode() : 0);
        result = 31 * result + (sedecancroDiscendente != null ? sedecancroDiscendente.hashCode() : 0);
        result = 31 * result + (altric != null ? altric.hashCode() : 0);
        return result;
    }
}
