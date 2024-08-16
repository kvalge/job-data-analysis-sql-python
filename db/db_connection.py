import psycopg2
from . import db_credentials

def create_connection():
    try:
        conn = psycopg2.connect(
            host=db_credentials.DB_HOST,
            database=db_credentials.DB_NAME,
            user=db_credentials.DB_USER,
            password=db_credentials.DB_PASSWORD
        )
        print("Connection to the database was successful.")
        return conn
    except psycopg2.Error as e:
        print(f"Error connecting to the database: {e}")
        return None
