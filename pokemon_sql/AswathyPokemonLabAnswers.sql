#What are all the types of pokemon that a pokemon can have?
SELECT DISTINCT name FROM types;

#What is the name of the pokemon with id 45?
SELECT name FROM pokemons WHERE id = 45;

#How many pokemon are there?
SELECT count(*) as total_pokemon FROM pokemons;

#How many types are there?
#SELECT count(distinct name) from types;
SELECT count(*) as total_types FROM types;

#How many pokemon have a secondary type?
SELECT count(*) as total_pokemon_having_secondary_types FROM pokemons WHERE secondary_type  IS NOT NULL;

#What is each pokemon's primary type?
SELECT p.name, t.name FROM pokemons AS p JOIN types AS t ON p.primary_type = t.id;

#What is Rufflet's secondary type?
SELECT t.name FROM pokemons AS p JOIN types AS t ON p.secondary_type = t.id WHERE p.name = 'Rufflet';

#What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT p.name FROM trainers AS t JOIN pokemon_trainer AS pt ON t.trainerID = pt.trainerID
  JOIN pokemons AS p ON p.id = pt.pokemon_id WHERE pt.trainerID = 303;

#How many pokemon have a secondary type Poison
SELECT count(*) AS total_pokemon_secondary_poison FROM pokemons JOIN types ON pokemons.secondary_type = types.id
WHERE types.name = 'Poison';

#What are all the primary types and how many pokemon have that type?
SELECT types.name, count(*) AS total_pokemon FROM types JOIN pokemons ON pokemons.primary_type = types.id
GROUP BY pokemons.primary_type;

#How many pokemon at level 100 does each trainer with at least one level 100 pokemone have? (Hint: your query should not display a trainer
SELECT count(*) AS total_pokemon_with_level100, trainerID FROM (
  SELECT trainerID, pokelevel FROM pokemon_trainer WHERE pokelevel >= 100) AS temp_table
GROUP BY temp_table.trainerID;

#How many pokemon only belong to one trainer and no other?
SELECT count(*) AS total_pokemon_belong_one_trainer FROM (
  SELECT pokemon_id FROM pokemon.pokemon_trainer GROUP BY pokemon_id HAVING count(*) = 1)
  AS temp_table;


#==========================4. Final Report=====================================

#used sub-query and join
Select distinct inner_table.pokemon_name AS "Pokemon Name", inner_table.trainer_name AS	"Trainer Name", inner_table.level AS	Level,
       inner_table.primary_type AS "Primary Type",secondary.name AS "Secondary Type" FROM
(Select P.name as pokemon_name, PT.pokelevel as level, T.trainername as trainer_name, primary_type.name as primary_type,
        P.secondary_type as secondary_type FROM
       pokemons AS P JOIN pokemon_trainer AS PT ON P.id = PT.pokemon_id
       JOIN trainers AS T ON T.trainerID = PT.trainerID
JOIN types AS primary_type ON primary_type.id = P.primary_type) AS inner_table
left outer JOIN types AS secondary ON secondary.id = inner_table.secondary_type;

# used join on 3 tables
Select distinct P.name AS "Pokemon Name", T.trainername AS	"Trainer Name", PT.pokelevel AS	Level,
       primary_type.name AS "Primary Type",secondary.name AS "Secondary Type" FROM
       pokemons AS P JOIN pokemon_trainer AS PT ON P.id = PT.pokemon_id
       JOIN trainers AS T ON T.trainerID = PT.trainerID
JOIN types AS primary_type ON primary_type.id = P.primary_type
LEFT OUTER JOIN types AS secondary ON secondary.id = P.secondary_type;

# used select as sub-query in selecting the primary type and secondary type
Select distinct P.name AS "Pokemon Name", T.trainername AS	"Trainer Name", PT.pokelevel AS	Level,
       (select name from types where id = P.primary_type) as "Primary Type " ,
       (select name from types where id = P.secondary_type) as "Secondary Type " FROM
       pokemons P INNER JOIN pokemon_trainer PT ON P.id = PT.pokemon_id
       INNER JOIN trainers T ON T.trainerID = PT.trainerID;

#=================================Final selection ==========================================
#ordered the strongest trainer based on level of pokemon, and its attack, hp, defence and speed data
Select P.name AS "Pokemon Name", T.trainername AS	"Trainer Name", PT.pokelevel AS	Level,
       (select name from types where id = P.primary_type) as "Primary Type " ,
       (select name from types where id = P.secondary_type) as "Secondary Type " FROM
       pokemons P INNER JOIN pokemon_trainer PT ON P.id = PT.pokemon_id
       INNER JOIN trainers T ON T.trainerID = PT.trainerID
ORDER BY pokelevel desc , attack desc, hp desc, defense desc,  speed desc, spatk desc, spdef desc ;


