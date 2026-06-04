from backend.database.db import DBManager

import bcrypt

class AuthManager:
    def __init__(self):
        self.db=DBManager()

    def login(self, username, password):
        user = self.db.get_user_by_username(username)

        if user is None:
            return False
        else:
            stored_hash=user[2]
            return bcrypt.checkpw(hashed_password=stored_hash.encode(), password=password.encode())
        
if __name__ == "__main__":
    auth = AuthManager()

    print(auth.login("ANIL", "6369"))
    print(auth.login("ANIL", "wrong"))
    print(auth.login("Random", "6369"))