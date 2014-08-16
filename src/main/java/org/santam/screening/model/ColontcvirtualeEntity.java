package org.santam.screening.model;

import javax.persistence.*;

@Entity
@Table(name = "colontcvirtuale")
@DiscriminatorValue("ctv")
@PrimaryKeyJoinColumn(name = "esami_id", referencedColumnName = "id")
public class ColontcvirtualeEntity extends Esame{

    @Column(name = "pulizia")
    private String pulizia;

    @Column(name = "lesioni")
    private Boolean lesioni;

    @Column(name = "tipolesioni")
    private String tipolesioni;

    @Column(name = "dimensioni")
    private Float dimensioni;

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

    public String getPulizia() { return pulizia; }
    public void setPulizia(String pulizia) { this.pulizia = pulizia; }

    public Boolean getLesioni() { return lesioni; }
    public void setLesioni(Boolean lesioni) { this.lesioni = lesioni; }

    public String getTipolesioni() { return tipolesioni; }
    public void setTipolesioni(String tipolesioni) { this.tipolesioni = tipolesioni; }

    public Float getDimensioni() { return dimensioni; }
    public void setDimensioni(Float dimensioni) { this.dimensioni = dimensioni; }

    public Boolean getSedecancroCieco() { return sedecancroCieco; }
    public void setSedecancroCieco(Boolean sedecancroCieco) { this.sedecancroCieco = sedecancroCieco; }

    public Boolean getSedecancroAscendente() { return sedecancroAscendente; }
    public void setSedecancroAscendente(Boolean sedecancroAscendente) { this.sedecancroAscendente = sedecancroAscendente; }

    public Boolean getSedecancroFlessuraepatica() { return sedecancroFlessuraepatica; }
    public void setSedecancroFlessuraepatica(Boolean sedecancroFlessuraepatica) { this.sedecancroFlessuraepatica = sedecancroFlessuraepatica; }

    public Boolean getSedecancroTrasverso() { return sedecancroTrasverso; }
    public void setSedecancroTrasverso(Boolean sedecancroTrasverso) { this.sedecancroTrasverso = sedecancroTrasverso; }

    public Boolean getSedecancroFlessurasplenica() { return sedecancroFlessurasplenica; }
    public void setSedecancroFlessurasplenica(Boolean sedecancroFlessurasplenica) { this.sedecancroFlessurasplenica = sedecancroFlessurasplenica; }

    public Boolean getSedecancroSigma() { return sedecancroSigma; }
    public void setSedecancroSigma(Boolean sedecancroSigma) { this.sedecancroSigma = sedecancroSigma; }

    public Boolean getSedecancroRetto() { return sedecancroRetto; }
    public void setSedecancroRetto(Boolean sedecancroRetto) { this.sedecancroRetto = sedecancroRetto; }
}
