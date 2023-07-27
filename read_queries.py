from pprint import pprint

from ht_create_tables import connection

sql_query = './1.sql'


def create_db(sql: str):
    with open(sql, 'r') as f:
        sql = f.read()

    with connection as con:
        cur = con.cursor()
        cur.execute(sql)
        pprint(cur.fetchall())
        cur.close()


if __name__ == "__main__":
    create_db(sql_query)
