package org.santam.screening.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "keyvaluedomains")
public class KeyvaluedomainsEntity {
    @EmbeddedId
    private KeyvaluedomainsEntityPK id;

    public KeyvaluedomainsEntityPK getId() {
        return id;
    }

    public void setId(KeyvaluedomainsEntityPK id) {
        this.id = id;
    }

    @Embeddable
    public class KeyvaluedomainsEntityPK implements Serializable {
        @Column(name = "domain")
        private String domain;
        @Column(name = "key")
        private String key;
        @Column(name = "value")
        private String value;

        public String getDomain() {
            return domain;
        }
        public void setDomain(String domain) {
            this.domain = domain;
        }

        public String getKey() {
            return key;
        }
        public void setKey(String key) {
            this.key = key;
        }

        public String getValue() {
            return value;
        }
        public void setValue(String value) {
            this.value = value;
        }
    }
}
