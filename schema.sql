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