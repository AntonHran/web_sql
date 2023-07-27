import sqlite3
from contextlib import contextmanager


database = './ht.db'


@contextmanager
def create_connection(db_file):
    connect = None
    try:
        connect = sqlite3.connect(db_file)
        yield connect
        connect.commit()
    except sqlite3.Error as error:
        print(error)
        connect.rollback()
    finally:
        if connect is not None:
            connect.close()


connection = create_connection(database)
tables = []

create_table_groups = """
    DROP TABLE IF EXISTS [groups];
    CREATE TABLE [groups] (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name STRING UNIQUE
    );
"""
tables.append(create_table_groups)

create_table_lectors = """
    DROP TABLE IF EXISTS lectors;
    CREATE TABLE lectors (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    full_name VARCHAR(30)
    );
"""
tables.append(create_table_lectors)

create_table_students = """
    DROP TABLE IF EXISTS students;
    CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    full_name VARCHAR(30),
    group_id REFERENCES [groups] (id)
    );
"""
tables.append(create_table_students)

create_table_subjects = """
    DROP TABLE IF EXISTS subjects;
    CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name STRING,
    lector_id REFERENCES lectors (id)
    );
"""
tables.append(create_table_subjects)

create_table_marks = """
    DROP TABLE IF EXISTS marks;
    CREATE TABLE marks (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    grade INTEGER,
    date_getting DATE,
    student_id REFERENCES students (id),
    subject_name REFERENCES subjects (name)
    );
"""
tables.append(create_table_marks)


def create_table(connect, sql_script):
    try:
        curs = connect.cursor()
        curs.executescript(sql_script)
        curs.close()
    except sqlite3.Error as error:
        print(error)


if __name__ == '__main__':
    with connection as conn:
        if conn is not None:
            [create_table(conn, table) for table in tables]
