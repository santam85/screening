package org.santam.screening.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by marco on 10/08/14.
 */
public class A2P2TEntityPK implements Serializable {
    private int patologiecId;
    private int terapieId;

    @Column(name = "patologiec_id")
    @Id
    public int getPatologiecId() {
        return patologiecId;
    }

    public void setPatologiecId(int patologiecId) {
        this.patologiecId = patologiecId;
    }

    @Column(name = "terapie_id")
    @Id
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

        A2P2TEntityPK that = (A2P2TEntityPK) o;

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
