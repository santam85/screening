package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "sof")
public class SofEntity {
    private int esamiId;
    private Boolean positivo;

    @Id
    @Column(name = "esami_id")
    public int getEsamiId() {
        return esamiId;
    }

    public void setEsamiId(int esamiId) {
        this.esamiId = esamiId;
    }

    @Basic
    @Column(name = "positivo")
    public Boolean getPositivo() {
        return positivo;
    }

    public void setPositivo(Boolean positivo) {
        this.positivo = positivo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SofEntity sofEntity = (SofEntity) o;

        if (esamiId != sofEntity.esamiId) return false;
        if (positivo != null ? !positivo.equals(sofEntity.positivo) : sofEntity.positivo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = esamiId;
        result = 31 * result + (positivo != null ? positivo.hashCode() : 0);
        return result;
    }
}
