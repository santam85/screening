package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "sof")
@DiscriminatorValue("sof")
@PrimaryKeyJoinColumn(name = "esami_id", referencedColumnName = "id")
public class SofEntity extends Esame {

    @Column(name = "positivo")
    private Boolean positivo;

    public Boolean getPositivo() {
        return positivo;
    }
    public void setPositivo(Boolean positivo) {
        this.positivo = positivo;
    }
}
