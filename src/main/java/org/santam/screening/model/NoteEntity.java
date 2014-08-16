package org.santam.screening.model;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by marco on 10/08/14.
 */
@Entity
@Table(name = "note")
public class NoteEntity {

    @Id
    @GeneratedValue
    @Column(name = "id")
    private int id;
    @Column(name = "date_added")
    private Timestamp dateAdded;
    @Column(name = "date_modified")
    private Timestamp dateModified;
    @Column(name = "subject")
    private String subject;
    @Column(name = "text")
    private String text;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Timestamp dateAdded) {
        this.dateAdded = dateAdded;
    }

    public Timestamp getDateModified() {
        return dateModified;
    }

    public void setDateModified(Timestamp dateModified) {
        this.dateModified = dateModified;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
