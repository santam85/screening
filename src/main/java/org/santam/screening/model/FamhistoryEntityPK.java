package org.santam.screening.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by marco on 10/08/14.
 */
public class FamhistoryEntityPK implements Serializable {
    private int id;
    private int anagraficaId;

    @Column(name = "id")
    @Id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "anagrafica_id")
    @Id
    public int getAnagraficaId() {
        return anagraficaId;
    }

    public void setAnagraficaId(int anagraficaId) {
        this.anagraficaId = anagraficaId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FamhistoryEntityPK that = (FamhistoryEntityPK) o;

        if (anagraficaId != that.anagraficaId) return false;
        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + anagraficaId;
        return result;
    }
}
