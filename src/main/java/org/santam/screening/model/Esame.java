package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;

@Entity
@Table(name = "esami")
@DiscriminatorColumn(name = "tipo")
@Inheritance(strategy=InheritanceType.JOINED)
public class Esame {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;
    @Column(name = "dataesame")
    private Date dataesame;
    @Column(name = "tipo")
    private String tipo;

    @ManyToOne
    @JoinColumn(name = "anagrafica_id", referencedColumnName = "id", nullable = false)
    private Paziente paziente;

    @ManyToOne
    @JoinColumn(name = "completamento", referencedColumnName = "id")
    private Esame esameCompletato;

    @OneToMany(mappedBy = "esameCompletato")
    private Collection<Esame> completamenti;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public Date getDataesame() {
        return dataesame;
    }
    public void setDataesame(Date dataesame) {
        this.dataesame = dataesame;
    }

    
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Paziente getPaziente() {
        return paziente;
    }
    public void setPaziente(Paziente paziente) {
        this.paziente = paziente;
    }

    public Esame getEsameCompletato() {
        return esameCompletato;
    }

    public void setEsameCompletato(Esame esameCompletato) {
        this.esameCompletato = esameCompletato;
    }

    public Collection<Esame> getCompletamenti() {
        return completamenti;
    }

    public void setCompletamenti(Collection<Esame> completamenti) {
        this.completamenti = completamenti;
    }
}
