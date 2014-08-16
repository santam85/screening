package org.santam.screening.model;

import org.springframework.data.rest.core.annotation.RestResource;

import javax.persistence.*;
import java.util.Collection;

@Entity
@Table(name = "patologiec")
public class PatologiecEntity {
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "tipo", length = 45)
    private String tipo;
    @Column(name = "descrizione", length = 450)
    private String descrizione;
    @Column(name = "sindrome", length = 45)
    private String sindrome;
    @Column(name = "mutazioni", length = 45)
    private String mutazioni;

    @ManyToMany
    @JoinTable(name="a2p2t")
    private Collection<TerapieEntity> terapie;

    @ManyToOne
    @JoinColumn(name = "anagrafica_id", referencedColumnName = "id", nullable = false)
    private Paziente anagraficaByAnagraficaId;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescrizione() {
        return descrizione;
    }
    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
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

    public Collection<TerapieEntity> getTerapie() {
        return terapie;
    }
    public void setTerapie(Collection<TerapieEntity> terapie) {
        this.terapie = terapie;
    }

    public Paziente getAnagraficaByAnagraficaId() {
        return anagraficaByAnagraficaId;
    }
    public void setAnagraficaByAnagraficaId(Paziente anagraficaByAnagraficaId) {
        this.anagraficaByAnagraficaId = anagraficaByAnagraficaId;
    }
}
