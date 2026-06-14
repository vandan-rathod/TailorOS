import psycopg as pg
import bcrypt

class DBManager:

    def __init__(self):
        print("DBManager initialized")
        self.conn= pg.connect(
            host="localhost",
            port=5432,
            dbname="TailorOS",
            user="postgres",
            password="6369"
        )
        print("db connected successfully")
        self.curr=self.conn.cursor()

        self.create_users_table()

        self.seed_owner()

    def create_users_table(self):
        
        self.curr.execute(
            """
            CREATE TABLE IF NOT EXISTS users(
                id SERIAL PRIMARY KEY ,
                username VARCHAR(100) UNIQUE NOT NULL,
                password_hash TEXT NOT NULL,
                role VARCHAR(50) NOT NULL
            )
        """
        )
        self.conn.commit()
    
    def seed_owner(self):
        username="ANIL"
        password="6369"
        self.curr.execute(
            '''
            SELECT * FROM users
            WHERE username=%s
            ''',
            (username,)
        )
        user=self.curr.fetchone()

        if user is None:
            role="OWNER"
            hashed_password=bcrypt.hashpw(
                password.encode(),
                bcrypt.gensalt()
            )
            hashed_password=hashed_password.decode()

            self.curr.execute(
                '''
                INSERT INTO users(username, password_hash, role)
                VALUES(%s,%s,%s)
                ''',
                (username, hashed_password, role)
            )
            self.conn.commit()
    def create_user(self,username, password_hash, role):
        pass

    def get_user_by_username(self, username):
        
        self.curr.execute(
            '''
            SELECT * FROM users 
            WHERE username=%s
            ''',
            (username,)
        )
        user=self.curr.fetchone()
        return user
