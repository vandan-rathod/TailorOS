import sqlite3
import bcrypt

class DBManager:

    def __init__(self, db_path="tailor.db"):
        self.db_path=db_path
        print("db path saved")
        self.conn= sqlite3.connect(self.db_path)
        print("db connected successfully")
        self.curr=self.conn.cursor()

        self.create_users_table()

        self.seed_owner()

    def create_users_table(self):
        
        self.curr.execute(
            """
            CREATE TABLE IF NOT EXISTS users(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT UNIQUE NOT NULL,
                password_hash TEXT NOT NULL,
                role TEXT NOT NULL
            )
        """
        )
    
    def seed_owner(self):
        username="ANIL"
        password="6369"
        self.curr.execute(
            '''
            SELECT * FROM users
            WHERE username=?
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
                VALUES(?,?,?)
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
            WHERE username=?
            ''',
            (username,)
        )
        user=self.curr.fetchone()
        return user
