package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Date;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "esami")
public class EsamiEntity {
    private int id;
    private Date dataesame;
    private String tipo;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "dataesame")
    public Date getDataesame() {
        return dataesame;
    }

    public void setDataesame(Date dataesame) {
        this.dataesame = dataesame;
    }

    @Basic
    @Column(name = "tipo")
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EsamiEntity that = (EsamiEntity) o;

        if (id != that.id) return false;
        if (dataesame != null ? !dataesame.equals(that.dataesame) : that.dataesame != null) return false;
        if (tipo != null ? !tipo.equals(that.tipo) : that.tipo != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (dataesame != null ? dataesame.hashCode() : 0);
        result = 31 * result + (tipo != null ? tipo.hashCode() : 0);
        return result;
    }
}
