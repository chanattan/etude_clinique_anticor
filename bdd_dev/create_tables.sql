CREATE TABLE IF NOT EXISTS acheteur (
    id_acheteur INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS nature (
    id_nature INT PRIMARY KEY,
    nature VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS forme_Prix (
    id_forme INT PRIMARY KEY,
    forme VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS procedure (
    procedure_id INT PRIMARY KEY,
    procedure_name VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS transactions (
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
    FOREIGN KEY (type) REFERENCES Type_transaction(id) -- is there for later
);

CREATE TABLE IF NOT EXISTS titulaire (
    id_titulaire INT PRIMARY KEY,
    denomination_sociale VARCHAR(128),
    type_denomination VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS lieu (
    type_code INT,
    nom VARCHAR(128),
    code_postal INT,
    code_commune INT,
    code_pays INT,
    code_dpt INT,
    code_region INT
);

-- This table will be extended when we will have the llm preprocessing about object, which is in natural language
CREATE TABLE IF NOT EXISTS type_transaction (
    id INT PRIMARY KEY
    -- Define your enum values here, e.g., ENUM('value1', 'value2', 'value3')
);

CREATE TABLE IF NOT EXISTS modification (
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
