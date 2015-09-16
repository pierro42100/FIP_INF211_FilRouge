-- Titre :             Création base cabinet recrutement version élèves.sql
-- Version :           1.0
-- Date création :     28 juin 2011
-- Date modification : 30 août 2011
-- Auteur :            Philippe Tanguy
-- Description :       Script de création de la base de données pour le SI "gestion de cabinet de
--                     recrutement"
--                     Note : script pour PostgreSQL 8.4
--                     Ebauche du script : ne contient pour le moment que la table "entreprise".

-- +----------------------------------------------------------------------------------------------+
-- | Suppression des tables                                                                       |
-- +----------------------------------------------------------------------------------------------+

drop table if exists "entreprise";
drop table if exists "offreEmploi";
drop table if exists "niveauQualif";
drop table if exists "secteurActivite";
drop table if exists "offre_secteur";
drop table if exists "candidature";
drop table if exists "candidature_secteur";


-- +----------------------------------------------------------------------------------------------+
-- | Création des tables                                                                          |
-- +----------------------------------------------------------------------------------------------+

create table "entreprise"
(
  id              serial primary key,
  nom             varchar(50) not null,
  descriptif      text,
  adresse_postale varchar(30) -- Pour simplifier, adresse_postale = ville.
);

create table "offreEmploi"
(
  id              serial primary key,
  titre             varchar(50) not null,
  descriptif_mission      text,
  profil_recherche varchar(150),
  date_depot date
  idEntreprise integer not null references entreprise,
  idQualification integer not null references niveauQualif
);

create table "niveauQualif"
(
  id              serial primary key,
  intitule             varchar(50) not null
);

create table "secteurActivite"
(
  id              serial primary key,
  intitule             varchar(50) not null
);

create table "candidature"
(
  id              serial primary key,
  nom             varchar(50) not null,
  prenom             varchar(50) not null,
  date_naissance date,
  descriptif      text,
  adresse_postale varchar(30),
  adresse_email varchar(50),
  cv text,
  date_depot date
  idQualification integer not null references niveauQualif
);


-- +----------------------------------------------------------------------------------------------+
-- | Création des tables intermédiaires                                                           |
-- +----------------------------------------------------------------------------------------------+


create table "offre_secteur"
(
  idOffre integer not null references offreEmploi,
  idSecteur integer not null references secteurActivite

);

create table "candidature_secteur"
(
  idCandidature integer not null references candidature,
  idSecteur integer not null references secteurActivite
);

-- +----------------------------------------------------------------------------------------------+
-- | Insertion de quelques données de pour les tests                                              |
-- +----------------------------------------------------------------------------------------------+

-- Insertion des secteurs d'activité

insert into "entreprise" values (nextval('entreprise_id_seq'),'Télécom Bretagne','Télécom Bretagne est une grande école pionnière en formation, en recherche et en entrepreneuriat.','Plouzané');
insert into "entreprise" values (nextval('entreprise_id_seq'),'ENIB','Une école d''ingénieur juste à côté...','Plouzané');

