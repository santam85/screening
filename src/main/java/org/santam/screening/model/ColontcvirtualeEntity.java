package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "colontcvirtuale")
public class ColontcvirtualeEntity {
    private int esamiId;
    private String pulizia;
    private Boolean lesioni;
    private String tipolesioni;
    private Float dimensioni;
    private Boolean sedecancroCieco;
    private Boolean sedecancroAscendente;

    private Boolean sedecancroDiscendente;

    private Boolean sedecancroFlessuraepatica;
    private Boolean sedecancroTrasverso;
    private Boolean sedecancroFlessurasplenica;
    private Boolean sedecancroSigma;
    private Boolean sedecancroRetto;
    @Id
    @Column(name = "esami_id")
    public int getEsamiId() {
        return esamiId;
    }

    public void setEsamiId(int esamiId) {
        this.esamiId = esamiId;
    }

    @Basic
    @Column(name = "pulizia")
    public String getPulizia() {
        return pulizia;
    }

    public void setPulizia(String pulizia) {
        this.pulizia = pulizia;
    }

    @Basic
    @Column(name = "lesioni")
    public Boolean getLesioni() {
        return lesioni;
    }

    public void setLesioni(Boolean lesioni) {
        this.lesioni = lesioni;
    }

    @Basic
    @Column(name = "tipolesioni")
    public String getTipolesioni() {
        return tipolesioni;
    }

    public void setTipolesioni(String tipolesioni) {
        this.tipolesioni = tipolesioni;
    }

    @Basic
    @Column(name = "dimensioni")
    public Float getDimensioni() {
        return dimensioni;
    }

    public void setDimensioni(Float dimensioni) {
        this.dimensioni = dimensioni;
    }

    @Basic
    @Column(name = "sedecancro_cieco")
    public Boolean getSedecancroCieco() {
        return sedecancroCieco;
    }

    public void setSedecancroCieco(Boolean sedecancroCieco) {
        this.sedecancroCieco = sedecancroCieco;
    }

    @Basic
    @Column(name = "sedecancro_discendente")
    public Boolean getSedecancroDiscendente() {
        return sedecancroDiscendente;
    }

    public void setSedecancroDiscendente(Boolean sedecancroDiscendente) {
        this.sedecancroDiscendente = sedecancroDiscendente;
    }

    @Basic
    @Column(name = "sedecancro_ascendente")
    public Boolean getSedecancroAscendente() {
        return sedecancroAscendente;
    }

    public void setSedecancroAscendente(Boolean sedecancroAscendente) {
        this.sedecancroAscendente = sedecancroAscendente;
    }

    @Basic
    @Column(name = "sedecancro_flessuraepatica")
    public Boolean getSedecancroFlessuraepatica() {
        return sedecancroFlessuraepatica;
    }

    public void setSedecancroFlessuraepatica(Boolean sedecancroFlessuraepatica) {
        this.sedecancroFlessuraepatica = sedecancroFlessuraepatica;
    }

    @Basic
    @Column(name = "sedecancro_trasverso")
    public Boolean getSedecancroTrasverso() {
        return sedecancroTrasverso;
    }

    public void setSedecancroTrasverso(Boolean sedecancroTrasverso) {
        this.sedecancroTrasverso = sedecancroTrasverso;
    }

    @Basic
    @Column(name = "sedecancro_flessurasplenica")
    public Boolean getSedecancroFlessurasplenica() {
        return sedecancroFlessurasplenica;
    }

    public void setSedecancroFlessurasplenica(Boolean sedecancroFlessurasplenica) {
        this.sedecancroFlessurasplenica = sedecancroFlessurasplenica;
    }

    @Basic
    @Column(name = "sedecancro_sigma")
    public Boolean getSedecancroSigma() {
        return sedecancroSigma;
    }

    public void setSedecancroSigma(Boolean sedecancroSigma) {
        this.sedecancroSigma = sedecancroSigma;
    }

    @Basic
    @Column(name = "sedecancro_retto")
    public Boolean getSedecancroRetto() {
        return sedecancroRetto;
    }

    public void setSedecancroRetto(Boolean sedecancroRetto) {
        this.sedecancroRetto = sedecancroRetto;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ColontcvirtualeEntity that = (ColontcvirtualeEntity) o;

        if (esamiId != that.esamiId) return false;
        if (dimensioni != null ? !dimensioni.equals(that.dimensioni) : that.dimensioni != null) return false;
        if (lesioni != null ? !lesioni.equals(that.lesioni) : that.lesioni != null) return false;
        if (pulizia != null ? !pulizia.equals(that.pulizia) : that.pulizia != null) return false;
        if (sedecancroAscendente != null ? !sedecancroAscendente.equals(that.sedecancroAscendente) : that.sedecancroAscendente != null)
            return false;
        if (sedecancroCieco != null ? !sedecancroCieco.equals(that.sedecancroCieco) : that.sedecancroCieco != null)
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
        if (tipolesioni != null ? !tipolesioni.equals(that.tipolesioni) : that.tipolesioni != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = esamiId;
        result = 31 * result + (pulizia != null ? pulizia.hashCode() : 0);
        result = 31 * result + (lesioni != null ? lesioni.hashCode() : 0);
        result = 31 * result + (tipolesioni != null ? tipolesioni.hashCode() : 0);
        result = 31 * result + (dimensioni != null ? dimensioni.hashCode() : 0);
        result = 31 * result + (sedecancroCieco != null ? sedecancroCieco.hashCode() : 0);
        result = 31 * result + (sedecancroAscendente != null ? sedecancroAscendente.hashCode() : 0);
        result = 31 * result + (sedecancroFlessuraepatica != null ? sedecancroFlessuraepatica.hashCode() : 0);
        result = 31 * result + (sedecancroTrasverso != null ? sedecancroTrasverso.hashCode() : 0);
        result = 31 * result + (sedecancroFlessurasplenica != null ? sedecancroFlessurasplenica.hashCode() : 0);
        result = 31 * result + (sedecancroSigma != null ? sedecancroSigma.hashCode() : 0);
        result = 31 * result + (sedecancroRetto != null ? sedecancroRetto.hashCode() : 0);
        return result;
    }
}
