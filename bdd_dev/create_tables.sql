CREATE TABLE Acheteur (
    id_acheteur INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE Nature (
    id_nature INT PRIMARY KEY,
    nature VARCHAR(30)
);

CREATE TABLE Forme_Prix (
    id_forme INT PRIMARY KEY,
    forme VARCHAR(30)
);

CREATE TABLE Procedure (
    procedure_id INT PRIMARY KEY,
    procedure_name VARCHAR(40)
);

CREATE TABLE Transaction (
    id INT PRIMARY KEY,
    objet TEXT,
    id_modif INT,
    lieu_exec INT,
    source VARCHAR(30),
    nature INT,
    forme_prix INT,
    date_notif DATE,
    date_public_donnee DATE,
    duree_mois INT,
    type INT,
    procedure_id INT,
    montant INT,
    FOREIGN KEY (nature) REFERENCES Nature(id_nature),
    FOREIGN KEY (forme_prix) REFERENCES Forme_Prix(id_forme),
    FOREIGN KEY (type) REFERENCES Type_transaction(id)
);

CREATE TABLE Titulaire (
    id_titulaire INT PRIMARY KEY,
    denomination_sociale VARCHAR(128),
    type_denomination VARCHAR(128)
);

CREATE TABLE Lieu (
    type_code INT,
    nom VARCHAR(128),
    code_postal INT,
    code_commune INT,
    code_pays INT,
    code_dpt INT,
    code_region INT
);

CREATE TABLE Type_transaction (
    id INT PRIMARY KEY,
    -- Define your enum values here, e.g., ENUM('value1', 'value2', 'value3')
);

CREATE TABLE Modification (
    id_modification INT PRIMARY KEY,
    montant INT,
    date DATE,
    objet VARCHAR(256),
    type INT,
    duree_mois INT,
    titulaire INT,
    date_modification DATE,
    FOREIGN KEY (type) REFERENCES Type_transaction(id),
    FOREIGN KEY (titulaire) REFERENCES Titulaire(id_titulaire)
);

CREATE TABLE Quoi (
    quoi_id INT PRIMARY KEY,
    tas_les_cramptes BOOLEAN,
    koube INT,
    FOREIGN KEY (koube) REFERENCES Feur(feur_id)
);

CREATE TABLE Feur (
    ratio INT,
    apagnan INT,
    FOREIGN KEY (ratio) REFERENCES Quoi(quoi_id),
    FOREIGN KEY (apagnan) REFERENCES Feur(feur_id)
);
