/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int primary key not null,
    name varchar(100) not null,
    date_of_birth date not null,
    escape_attempts int not null,
    neutered boolean not null,
    weight_kg decimal not null,
    species varchar(100)
);

-- Create the owners table
CREATE TABLE owners (
    id int generated always as identity primary key  not null,
    full_name VARCHAR(255) not null,
    age int not null
);

-- Create the species table
CREATE TABLE species (
    id int generated always as identity primary key  not null,
    name VARCHAR(255)
);

-- Modify the animals table
alter  table animals alter column id set not null;
alter  table animals alter column id add generated always as identity;

alter table animals drop column species;

alter table animals add column species_id int;
alter table animals add constraint fk_species foreign key (species_id) references species(id);

alter table animals add column owners_id int;
alter table animals add constraint fk_owners foreign key ( owners_id) references owners(id);

create table vets (
    id int generated always as identity primary key not null,
    name varchar(255) not null,
    age int not null,
    date_of_graduation date not null
);

-- many-to-many relationship between the tables species and vets
drop table if exists;
create table specializations (
    vets_id int,
    species_id int,
    constraint vets_specializes_in foreign key(vets_id) references vets(id),
    constraint species_specialized_vets foreign key (species_id) references species (id)
);

-- many-to-many relationship between the tables animals and vets
drop table if exists visits;
create table visits (
    animal_id int,
    vets_id int,
    visits_date date,
    constraint fk_animal_visit foreign key (animal_id) references animals(id),
    constraint fk_vets_visited
        foreign key (vets_id) references vets(id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

CREATE INDEX visits_animal_id_index ON visits (animal_id);
CREATE INDEX visits_vets_id_index ON visits (vets_id);
CREATE INDEX email_index ON owners(email);