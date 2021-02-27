with open("db_init.sql", "w",  encoding="utf-8") as f:
    # ======================================#
    f.write("DROP TABLE IF EXISTS movies;\n")
    f.write("DROP TABLE IF EXISTS ratings;\n")
    f.write("DROP TABLE IF EXISTS tags;\n")
    f.write("DROP TABLE IF EXISTS users;\n")

    # ======================================#
    f.write("\nCREATE TABLE movies (\
	    \n  id INTEGER RRIMARY KEY,\
   	    \n  title VARCHAR,\
	    \n  year INTEGER,\
	    \n  genres VARCHAR);\n")

    f.write("\nCREATE TABLE ratings (\
        \n  id INTEGER RRIMARY KEY,\
        \n  user_id INTEGER,\
        \n  movie_id INTEGER,\
        \n  rating FLOAT,\
        \n  timestamp INTEGER);\n")

    f.write("\nCREATE TABLE tags (\
        \n  id INTEGER RRIMARY KEY,\
        \n  user_id INTEGER,\
        \n  movie_id INTEGER,\
        \n  tag VARCHAR,\
        \n  timestamp INTEGER);\n", )

    f.write("\nCREATE TABLE users (\
        \n  id INTEGER RRIMARY KEY,\
        \n  name VARCHAR,\
        \n  email VARCHAR,\
        \n  gender VARCHAR,\
        \n  register_date DATE,\
        \n  occupation VARCHAR);\n", )

    # ======================================#
    f.write("\nINSERT INTO movies (id, title, year, genres)\n")
    f.write("VALUES")
    with open("movies.csv", "r", encoding="utf-8") as fr:
        file = fr.readlines()[1:]
        for i in range(len(file)):
            date = (file[i][:-1].split(','))
            year = "NULL"
            title = date[1]
            genres = "NULL"
            if len(date) > 3:
                # print(date)
                for j in range(2, len(date) - 1):
                    title = title + ", " + date[j]

            index = title.rfind('(')
            if index != -1:
                tmp = title[index + 1:index + 5]
                if tmp.isdigit():
                    title = title.replace('(' + tmp + ')', '')
                    year = tmp
            title = title.lstrip('"')
            title = title.rstrip('"')
            title = title.rstrip(' ')
            title = title.replace("'", "‘")
            if date[-1].find("no genres listed") == -1:
                genres = "'" + date[-1] + "'"

            if i == len(file)-1:
                f.write("\n ({0}, '{1}', {2}, {3});\n".format(date[0], title, year, genres))
            else:
                f.write("\n ({0}, '{1}', {2}, {3}),".format(date[0], title, year, genres))

    f.write("\nINSERT INTO ratings (id, user_id, movie_id, rating, timestamp)\n")
    f.write("VALUES")
    with open("ratings.csv", "r") as fr:
        file = fr.readlines()[1:]
        for i in range(len(file)):
            date = (file[i][:-1].split(','))
            f.write("\n ({0}, {1}, {2}, {3}, {4}),".format(i + 1, date[0], date[1], date[2], date[3]))
        date = (file[-1][:-1].split(','))
        f.write("\n ({0}, {1}, {2}, {3}, {4});\n".format(i + 2, date[0], date[1], date[2], date[3]))

    f.write("\nINSERT INTO tags (id, user_id, movie_id, tag, timestamp)\n")
    f.write("VALUES")
    with open("tags.csv", "r") as fr:
        file = fr.readlines()[1:]
        for i in range(len(file)):
            date = (file[i][:-1].split(','))
            tag = date[2].replace("'", "‘")
            if i == len(file) - 1:
                f.write("\n ({0}, {1}, {2}, '{3}', {4});\n".format(i+1, date[0], date[1], tag, date[3]))
            else:
                f.write("\n ({0}, {1}, {2}, '{3}', {4}),".format(i+1, date[0], date[1], tag, date[3]))

    f.write("\nINSERT INTO users (id, name, email, gender, register_date, occupation)\n")
    f.write("VALUES")
    with open("users.txt", "r") as fr:
        file = fr.readlines()
        for i in range(len(file)):
            date = file[i][:-1].replace("'", "‘")
            date = date.split('|')
            if i == len(file) - 1:
                f.write("\n ({0}, '{1}', '{2}', '{3}', {4}, '{5}');\n".format(date[0], date[1], date[2], date[3], date[4], date[5]))
            else:
                f.write("\n ({0}, '{1}', '{2}', '{3}', {4}, '{5}'),".format(date[0], date[1], date[2], date[3], date[4], date[5]))