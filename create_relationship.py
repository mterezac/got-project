character = { "Tyrion" : 1, "Jaime" : 2, "Cersei" : 3, "Daenerys" : 4, "Eddard" : 5,
                      "Catelyn": 6, "Petyr" : 7, "Jon" : 8, "Davos" : 9, "Robert" : 10,
                                    "Joffrey" : 11, "Margaery" : 12, "Loras" : 13, "Renly" : 14, "Stannis" : 15, "Robb" : 16, "Talisa" : 17 }

c1 = raw_input("character name: ")
c2 = raw_input("character name 2: ")
id1 = character[c1]
id2 = character[c2]
type = raw_input("type of relationship: ")

string = "INSERT INTO primary_relationship(first_character_id, second_character_id, type) VALUES (" + str(id1) + ", "+ str(id2) + ", "+ type + ");"
print(string);
