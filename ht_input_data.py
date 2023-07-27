import sqlite3
from datetime import date, timedelta
from random import randint, choice
from typing import Iterable

from faker import Faker

from ht_create_tables import connection


subjects: list[str] = [
    'Maths',
    'Discrete maths',
    'Drawing',
    'Programing',
    'Probability theory',
    'DB theory',
    'English',
    'History of Ukraine'
]

groups: list[str] = ['MTO-08-2', 'IT-12-1', 'PTM-10-2']
NUMBER_LECTORS: int = 5
NUMBER_STUDENTS: int = 50

fake = Faker()


def cursor(sql: str, values: Iterable, connection_):
    try:
        cur = connection_.cursor()
        cur.executemany(sql, values)
        cur.close()
    except sqlite3.Error as error:
        print(error)


def seed_lectors(conn):
    lectors: list[str] = [fake.name() for _ in range(NUMBER_LECTORS)]
    sql_script: str = "INSERT INTO lectors(full_name) VALUES(?);"
    cursor(sql_script, zip(lectors, ), conn)


def seed_subjects(conn):
    sql_script: str = "INSERT INTO subjects(name, lector_id) VALUES(?, ?);"
    cursor(sql_script, zip(subjects, iter(randint(1, NUMBER_LECTORS) for _ in range(len(subjects)))), conn)


def seed_groups(conn):
    sql_script: str = "INSERT INTO groups(name) VALUES(?);"
    cursor(sql_script, zip(groups, ), conn)


def seed_students(conn):
    students: list[str] = [fake.name() for _ in range(NUMBER_STUDENTS)]
    sql_script: str = "INSERT INTO students(full_name, group_id) VALUES(?, ?);"
    cursor(sql_script, zip(students, iter(randint(1, len(groups)) for _ in range(NUMBER_STUDENTS))), conn)


def get_dates_list(start: date, end: date) -> list[date]:
    result: list = []
    current_date: date = start
    while current_date <= end:
        if current_date.weekday() < 6:
            result.append(current_date)
        current_date += timedelta(1)
    return result


def create_grades(dates_list: list[date]) -> list[int]:
    grades_list: list = []
    for day in dates_list:
        subjects_per_day: str = choice(subjects)
        students_per_day: list = [randint(1, NUMBER_STUDENTS) for _ in range(5)]
        for student in students_per_day:
            grades_list.append((randint(1, 100), day, student, subjects_per_day))
    return grades_list


def seed_marks(conn):
    sql_script: str = "INSERT INTO marks(grade, date_getting, student_id, subject_name) VALUES(?, ?, ?, ?);"
    start_date: date = date(year=2022, month=9, day=1)
    end_date: date = date(year=2023, month=6, day=15)
    date_list: list[date] = get_dates_list(start_date, end_date)
    grades: list[int] = create_grades(date_list)
    cursor(sql_script, grades, conn)


if __name__ == '__main__':
    with connection as conn_:
        seed_subjects(conn_)
        seed_lectors(conn_)
        seed_groups(conn_)
        seed_students(conn_)
        seed_marks(conn_)
