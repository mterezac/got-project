person = raw_input ("Enter character name: ")
full_name = person.split()
gender = raw_input ("gender: ")
stg = "INSERT INTO characters (first_name, last_name, nickname, character_gender) VALUES ('" + full_name[0] + "', '" + full_name[1] + "', NULL, '"+  gender + "');"
print(stg)

str2 = "INSERT INTO deaths (character_id, episode_id, war_id) VALUES (12, 15, NULL);"
print(str2)
