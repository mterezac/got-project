actors = { "Peter" : 1, "Nikolaj" : 2, "Lena" : 3, "Emilia" : 4, "Aidan" : 5, "Kit" : 6, "Liam" : 7, "Sean" : 8, "Mark" : 9, "Michelle" : 10 }

episodes = { "The Dragon and the Wolf" : 1, "The Pointy End" : 2, "Garden of Bones" : 3, "Mhysa" : 4,
             "First of His Name" : 5, "The Wars to Come" : 6, "Battle of the Bastards" : 7, "The Spoils of War" : 8,
             "A Golden Crown" : 9, "Unbowed, Unbent, Unbroken" : 10, "Baelor" : 11, "The Rains of Castamere" : 12,
             "You Win or You Die" : 13, "The Lion and the Rose" : 14, "The Winds of Winter" : 15, "The Ghost of Harrenhal" : 16, "Mother's Mercy" : 17 }

for key in episodes:
    for x in range (0, 4):
        print(key)
        actor = raw_input("Actor name: ")
        a_id = actors[actor]
        string = "INSERT INTO performed_by (episode_id, actor_id) VALUES (" + str(episodes[key]) + ", " + str(a_id) + ");"
        print(string)

