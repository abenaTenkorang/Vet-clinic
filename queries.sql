/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';

SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

SELECT name from animals WHERE neutered = true AND escape_attempts < 3;


SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg < 10.5;

SELECT * from animals WHERE name <> 'Gabumon';

SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- query and update animals tables
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species = '';

COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT before_weight_update;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO before_weight_update;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;
select neutered,sum(escape_attempts) as sum from animals GROUP BY neutered;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- What animals belong to Melody Pond?
SELECT name 
FROM animals 
WHERE owner_id = (
    SELECT id 
    FROM owners 
    WHERE full_name = 'Melody Pond'
);

-- List of all animals that are pokemon (their type is Pokemon).
SELECT name 
FROM animals 
WHERE species_id = (
    SELECT id 
    FROM species 
    WHERE name = 'Pokemon'
);

-- List all owners and their animals, including those that don't own any animal
SELECT full_name, name 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id 
ORDER BY full_name;

-- How many animals are there per species?
SELECT species.name, COUNT(*) 
FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
JOIN species ON animals.species_id = species.id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name 
FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND escaped_attempts = false;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id 
GROUP BY owners.full_name 
ORDER BY COUNT(animals.name) DESC 
LIMIT 1;

