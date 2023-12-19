-- Création du bâtiment B1 s'il n'existe pas
USE glpi;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
VALUES ('B1', 'B1', 0, 0, 'Bâtiment 1');

-- Création des étages du bâtiment B1
INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E0', 'B1 > E0', glpi_locations.id, 1, 'Bâtiment 1 - Étage 0'
FROM glpi_locations
WHERE glpi_locations.name = 'B1'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E1', 'B1 > E1', glpi_locations.id, 1, 'Bâtiment 1 - Étage 1'
FROM glpi_locations
WHERE glpi_locations.name = 'B1'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E2', 'B1 > E2', glpi_locations.id, 1, 'Bâtiment 1 - Étage 2'
FROM glpi_locations
WHERE glpi_locations.name = 'B1'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E3', 'B1 > E3', glpi_locations.id, 1, 'Bâtiment 1 - Étage 3'
FROM glpi_locations
WHERE glpi_locations.name = 'B1'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E4', 'B1 > E4', glpi_locations.id, 1, 'Bâtiment 1 - Étage 4'
FROM glpi_locations
WHERE glpi_locations.name = 'B1'
LIMIT 1;


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////

-- Création du bâtiment B2 s'il n'existe pas
INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
VALUES ('B2', 'B2', 0, 0, 'Bâtiment 2');

-- Création des étages du bâtiment B2
INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E0', 'B2 > E0', glpi_locations.id, 1, 'Bâtiment 2 - Étage 0'
FROM glpi_locations
WHERE glpi_locations.name = 'B2'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E1', 'B2 > E1', glpi_locations.id, 1, 'Bâtiment 2 - Étage 1'
FROM glpi_locations
WHERE glpi_locations.name = 'B2'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E2', 'B2 > E2', glpi_locations.id, 1, 'Bâtiment 2 - Étage 2'
FROM glpi_locations
WHERE glpi_locations.name = 'B2'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E3', 'B2 > E3', glpi_locations.id, 1, 'Bâtiment 2 - Étage 3'
FROM glpi_locations
WHERE glpi_locations.name = 'B2'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E4', 'B2 > E4', glpi_locations.id, 1, 'Bâtiment 2 - Étage 4'
FROM glpi_locations
WHERE glpi_locations.name = 'B2'
LIMIT 1;

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Création du bâtiment B3 s'il n'existe pas
INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
VALUES ('B3', 'B3', 0, 0, 'Bâtiment 3');

-- Création des étages du bâtiment B3
INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E0', 'B3 > E0', glpi_locations.id, 1, 'Bâtiment 3 - Étage 0'
FROM glpi_locations
WHERE glpi_locations.name = 'B3'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E1', 'B3 > E1', glpi_locations.id, 1, 'Bâtiment 3 - Étage 1'
FROM glpi_locations
WHERE glpi_locations.name = 'B3'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E2', 'B3 > E2', glpi_locations.id, 1, 'Bâtiment 3 - Étage 2'
FROM glpi_locations
WHERE glpi_locations.name = 'B3'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E3', 'B3 > E3', glpi_locations.id, 1, 'Bâtiment 3 - Étage 3'
FROM glpi_locations
WHERE glpi_locations.name = 'B3'
LIMIT 1;

INSERT IGNORE INTO glpi_locations (name, completename, locations_id, level, comment)
SELECT 'E4', 'B3 > E4', glpi_locations.id, 1, 'Bâtiment 3 - Étage 4'
FROM glpi_locations
WHERE glpi_locations.name = 'B3'
LIMIT 1;