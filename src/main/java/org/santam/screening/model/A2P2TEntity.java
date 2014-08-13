package org.santam.screening.model;

import javax.persistence.*;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "a2p2t")
@IdClass(A2P2TEntityPK.class)
public class A2P2TEntity {
    private int patologiecId;
    private int terapieId;

    @Id
    @Column(name = "patologiec_id")
    public int getPatologiecId() {
        return patologiecId;
    }

    public void setPatologiecId(int patologiecId) {
        this.patologiecId = patologiecId;
    }

    @Id
    @Column(name = "terapie_id")
    public int getTerapieId() {
        return terapieId;
    }

    public void setTerapieId(int terapieId) {
        this.terapieId = terapieId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        A2P2TEntity that = (A2P2TEntity) o;

        if (patologiecId != that.patologiecId) return false;
        if (terapieId != that.terapieId) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = patologiecId;
        result = 31 * result + terapieId;
        return result;
    }
}
