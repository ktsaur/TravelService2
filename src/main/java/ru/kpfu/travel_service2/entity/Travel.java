package ru.kpfu.travel_service2.entity;

import jakarta.persistence.*;
import lombok.Data;
import org.antlr.v4.runtime.misc.NotNull;

import java.util.Date;

@Entity
@Table(name = "travel")
public class Travel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer travelId;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "name_travel")
    private String nameTravel;

    @Column
    private String description;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @Column
    private String transport;

    @Column(name = "list_of_things")
    private String listOfThings;

    @Column
    private String notes;

    @Column(name = "travel_url")
    private String travelUrl;

    @Column
    private boolean isOver;

    public Travel() {}

    public Travel(User user, String nameTravel, String description, Date startDate, Date endDate, String transport, String listOfThings, String notes, String travelUrl) {
        this.user = user;
        this.nameTravel = nameTravel;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.transport = transport;
        this.listOfThings = listOfThings;
        this.notes = notes;
        this.travelUrl = travelUrl;
    }

    public Integer getTravelId() {
        return travelId;
    }

    public void setTravelId(Integer travelId) {
        this.travelId = travelId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getNameTravel() {
        return nameTravel;
    }

    public void setNameTravel(String nameTravel) {
        this.nameTravel = nameTravel;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    public String getListOfThings() {
        return listOfThings;
    }

    public void setListOfThings(String listOfThings) {
        this.listOfThings = listOfThings;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getTravelUrl() {
        return travelUrl;
    }

    public void setTravelUrl(String travelUrl) {
        this.travelUrl = travelUrl;
    }

    public boolean getIsOver() {
        return isOver;
    }

    public void setIsOver(boolean isOver) {
        this.isOver = isOver;
    }
}