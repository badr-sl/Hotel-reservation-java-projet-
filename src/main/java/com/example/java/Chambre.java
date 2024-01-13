package com.example.java;

public class Chambre {
    private String idChambre;
    private boolean disponibilite;
    private int idType;

    private  String NomChambre;
    public String getNomChambre() {
        return NomChambre;
    }

    public void setNomChambre(String nomChambre) {
        this.NomChambre = nomChambre;
    }




    public Chambre() {
    }

    // Constructeur avec paramètres
    public Chambre(String idChambre, boolean disponibilite, int idType ,String NomChambre) {
        this.idChambre = idChambre;
        this.disponibilite = disponibilite;
        this.idType = idType;
        this.NomChambre=NomChambre;
        // Initialisez d'autres attributs selon votre modèle de données
    }

    // Ajoutez des getters et des setters pour chaque attribut
    public String getIdChambre() {
        return idChambre;
    }

    public void setIdChambre(String idChambre) {
        this.idChambre = idChambre;
    }

    public void setDisponibilite(boolean disponibilite) {
        this.disponibilite = disponibilite;
    }

    public int getIdType() {
        return idType;
    }

    public void setIdType(int idType) {
        this.idType = idType;
    }

    public void setPrixUnitaire(double prixUnitaire) {
    }

    public void setDescription(String description) {
    }

    public String getGetIdChambre() {
        return idChambre;
    }



    // Ajoutez d'autres getters et setters selon votre modèle de données
}
