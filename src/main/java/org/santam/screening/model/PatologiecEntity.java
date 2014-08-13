package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "patologiec")
public class PatologiecEntity {
    private int id;
    private String tipo;
    private String descrizione;
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
    @Column(name = "tipo")
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Basic
    @Column(name = "descrizione")
    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
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

        PatologiecEntity that = (PatologiecEntity) o;

        if (id != that.id) return false;
        if (descrizione != null ? !descrizione.equals(that.descrizione) : that.descrizione != null) return false;
        if (mutazioni != null ? !mutazioni.equals(that.mutazioni) : that.mutazioni != null) return false;
        if (sindrome != null ? !sindrome.equals(that.sindrome) : that.sindrome != null) return false;
        if (tipo != null ? !tipo.equals(that.tipo) : that.tipo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (tipo != null ? tipo.hashCode() : 0);
        result = 31 * result + (descrizione != null ? descrizione.hashCode() : 0);
        result = 31 * result + (sindrome != null ? sindrome.hashCode() : 0);
        result = 31 * result + (mutazioni != null ? mutazioni.hashCode() : 0);
        return result;
    }
}
