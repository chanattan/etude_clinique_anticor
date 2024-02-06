CREATE TABLE IF NOT EXISTS titulaire (
    id_titulaire INT PRIMARY KEY,
    denomination_sociale VARCHAR(128),
    type_identifiant VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS procedure (
    procedure_id INT PRIMARY KEY,
    procedure_name VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS nature {
    id_nature INT PRIMARY KEY,
    nature VARCHAR(32)
};

CREATE TABLE IF NOT EXISTS forme_Prix (
    id_forme INT PRIMARY KEY,
    forme VARCHAR(32)
);

CREATE TABLE IF NOT EXISTS acheteur (
    id_acheteur INT PRIMARY KEY,
    nom VARCHAR(256)
);

CREATE TABLE IF NOT EXISTS source {
    id_source INT PRIMARY KEY,
    source VARCHAR(32)
};

CREATE TABLE IF NOT EXISTS lieu (
    id_lieu INT PRIMARY KEY,
    code VARCHAR(128), -- unfortunately, it happens that the code is a string and not well defined. This will be hopefully taken care of in the pre/post processing of the data with llm
    nom VARCHAR(128),
    typeCode VARCHAR(64) -- could be a tuple, but we might have surprises later....
                         -- also, we might want to have a table for the typeCode, but it begins to be a bit too much
);

CREATE TABLE IF NOT EXISTS modalite_execution (
    id_modalite INT PRIMARY KEY,
    modalite VARCHAR(32) -- could be a tuple, but we might have surprises later....
);

CREATE TABLE IF NOT EXISTS type_prix (
    id_type_prix INT PRIMARY KEY,
    type VARCHAR(32) -- could be a tuple, but it seems that we don't have all the possible descriptions possible in the law from the tables 
);

CREATE TABLE IF NOT EXISTS considerations_sociales (
    id_considerations_sociales INT PRIMARY KEY,
    considerations_sociales VARCHAR(32) -- could be a tuple, but it seems that we don't have all the possible descriptions possible in the law from the tables
);

CREATE TABLE IF NOT EXISTS considerations_environnementales (
    id_considerations_env INT PRIMARY KEY,
    considerations_env VARCHAR(32) -- could be a tuple, but it seems that we don't have all the possible descriptions possible in the law from the tables
);

CREATE TABLE IF NOT EXISTS acte_sous_traitance {

    id_sous_traitant


    FOREIGN KEY (id_transaction) REFERENCES transactions(id),

};


CREATE TABLE IF NOT EXISTS transactions (
    id INT PRIMARY KEY,
    -- not null:
    FOREIGN KEY (id_titulaire_1) REFERENCES titulaire(id_titulaire),
    FOREIGN KEY (id_titulaire_2) REFERENCES titulaire(id_titulaire),
    FOREIGN KEY (id_titulaire_3) REFERENCES titulaire(id_titulaire),
    FOREIGN KEY (procedure_id) REFERENCES procedure(procedure_id),
    FOREIGN KEY (nature) REFERENCES nature(id_nature),
    codeCPV VARCHAR(20), -- 14 is the max length in the dataset but it's variable...
    duree_mois INT,
    montant FLOAT,
    FOREIGN KEY (forme_prix) REFERENCES Forme_Prix(id_forme),
    date_notif DATE,
    objet TEXT,
    FOREIGN KEY (acheteur) REFERENCES acheteur(id_acheteur),
    FOREIGN KEY (source) REFERENCES source(id_source),
    FOREIGN KEY (lieu_exec) REFERENCES lieu(id_lieu),
    date_publication_donnees DATE,
    date_creation DATE,
    FOREIGN KEY (id_modalite) REFERENCES modalite_execution(id_modalite),
    marche_inovant BOOLEAN,
    -- cahiers des clauses administratives générales
    ccag VARCHAR(128),
    offres_recues INT,
    attribution_avance BOOLEAN,
    type_groupement_operateurs ENUM('Conjoint','Solidaire'),
    FOREIGN KEY (type_prix) REFERENCES type_transaction(id_type_prix),
    FOREIGN KEY (considerations_sociales) REFERENCES considerations_sociales(id_considerations),
    FOREIGN KEY (considerations_env) REFERENCES considerations_environnementales(id_considerations_env),
    taux_avance FLOAT,
    origine_ue FLOAT, -- don't know what it is
    origine_france FLOAT, -- still
    update_at DATE, -- don't know what it is
    FOREIGN KEY (id_modif) REFERENCES modification(id_modif),
    technique BOOLEAN, -- Accord cadre or not. Peraps should rename
    id_accord_cadre VARCHAR(64), -- supposed to be an id but it's a string and sometimes with a sentence in it....
    
    



    sous_traitance_declaree BOOLEAN,
    -- HERE


    id_modif INT,
    lieu_exec INT,
    source VARCHAR(30),
    forme_prix INT,
    type INT,
    montant INT,
    FOREIGN KEY (type) REFERENCES Type_transaction(id) -- is there for later
);

CREATE TABLE IF NOT EXISTS modification (
    id_modif INT PRIMARY KEY,
    id_modification BOOLEAN, -- for some reason, it's a boolean in the dataset but not clear what it is and rarely used
    objet_modification TEXT,
    duree_mois INT,
    montant INT,
    date_modification DATE,
    date_notif DATE,

    -- problem with titulaire_modification, it's a json of titulaire objects but of variable length
);


-- This table will be extended when we will have the llm preprocessing about object, which is in natural language
CREATE TABLE IF NOT EXISTS type_transaction (
    id INT PRIMARY KEY
    -- Define your enum values here, e.g., ENUM('value1', 'value2', 'value3')
);

