package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;

@Entity
@Table(name = "terapie")
public class TerapieEntity {
    @Id
    @Column(name = "id")
    private int id;

    @Column(name = "tipo", length = 45)
    private String tipo;

    @Column(name = "descrizione", length = 45)
    private String descrizione;

    @Column(name = "inizio")
    private Date inizio;

    @Column(name = "fine")
    private Date fine;

    @Column(name = "durata")
    private Integer durata;

    @ManyToMany
    @JoinTable(name="a2p2t")
    private Collection<PatologiecEntity> patologiec;

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

    
    public Date getInizio() {
        return inizio;
    }
    public void setInizio(Date inizio) {
        this.inizio = inizio;
    }

    
    public Date getFine() {
        return fine;
    }
    public void setFine(Date fine) {
        this.fine = fine;
    }


    public Integer getDurata() {
        return durata;
    }
    public void setDurata(Integer durata) {
        this.durata = durata;
    }

    public Paziente getAnagraficaByAnagraficaId() {
        return anagraficaByAnagraficaId;
    }
    public void setAnagraficaByAnagraficaId(Paziente anagraficaByAnagraficaId) {
        this.anagraficaByAnagraficaId = anagraficaByAnagraficaId;
    }

    public Collection<PatologiecEntity> getPatologiec() { return patologiec;  }
    public void setPatologiec(Collection<PatologiecEntity> patologiec) {
        this.patologiec = patologiec;
    }
}
