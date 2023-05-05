/* Populate database with sample data. */

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '02/03/20', 0,true,10.23);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '11/15/18', 2,true,8);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '01/7/21', 1,false,15.04);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Davimon', '05/12/17', 5,true,11);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (5, 'Chamandar', '02/08/20', 0, false, -11);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (6, 'Plantmon', '11/15/21', 2, true, -5.7);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (7, 'Squirtle', '04/02/93', 3, false, -12.13);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (8, 'Angemon', '06/12/05', 1, true, -45);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (9, 'Boarmon', '06/07/05', 7, true, 20.4);
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (10, 'Blossom', '10/13/98', 3, true, 17);\
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (11, 'Ditto', '05/14/22', 4, true, 22);

-- Insert data into the owners table
INSERT INTO owners (full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species (name)
VALUES 
    ('Pokemon'),
    ('Digimon');

-- Update the animals table to include species and owner information
update animals set species_id = 2 where name like '%mon';
update animals set species_id = 1 where name not like '%mon';

update animals set owners_id = 1 where name like 'Agumon';
update animals set owners_id = 2 where name in ('Gabumon', 'Pikachu');
update animals set owners_id = 3 where name in ('Davimon', 'Plantmon');
update animals set owners_id = 4 where name in ('Chamandar', 'Squirtle','Blossom');
update animals set owners_id = 5 where name in ('Angemon', 'Boarmon');


-- Add "join table" for visits

-- Insert data to vets table
insert into vet (name, age,date_of_graduation)
values 
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

   -- insert data to specialties
  insert into specialties(vet_id, species_id) 
  values
    (
      (select id from vet where name like 'William Tatcher'),
      (select id from species where name = 'Pokemon')
    ),
    (
      (select id from vet where name like 'Stephanie Mendez'),
      (select id from species where name = 'Digimon')
    ),
    (
      (select id from vet where name like 'Stephanie Mendez'),
      (select id from species where name = 'Pokemon')
    ),
    (
      (select id from vet where name like 'Jack Harkness'),
      (select id from species where name = 'Digimon')
    );
