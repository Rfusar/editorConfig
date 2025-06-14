import imaplib, os
from email.parser import BytesParser
from email import policy
from . import parse_eml

same_email = lambda msg, last_email: msg["from"] == last_email["sender"] and msg["subject"] == last_email["subject"] and msg["date"]==last_email["date"]

class MyEmail:
    def __init__(self, server_imap, email, pw):
        self.email = email 
        self.pw = pw 
        self.server_imap = server_imap
        self.EMAIL = []

    @staticmethod
    def same_email(msg1, msg2):
        for k in ["sender", "subject", "date"]:
            if msg1[k]==msg2[k]: return True
        return False

    @staticmethod
    def Parser(path_file_eml): return parse_eml(path_file_eml)


    def download(self, label, save="", max_email=10):
        try:
            with imaplib.IMAP4_SSL(host=self.server_imap) as email:
                email.login(self.email, self.pw)
                email.select('INBOX')
                _, data = email.search(None, "ALL")

                last_one = len(data[0].split())
                for i in range(last_one, 0, -1):
                    if i > last_one-max_email:
                        num = str(i).encode()


                        _, data = email.fetch(num, '(RFC822)')
                        emailBytes = data[0][1]
                        msg = BytesParser(policy=policy.default).parsebytes(emailBytes)

                        #Save a copy on local storage
                        ID = f"{label}_{i}"
                        if save != "":
                            os.makedirs(f"{save}/{label}", exist_ok=True)
                            with open(f"{save}/{label}/{ID}.eml", "wb") as f:
                                f.write(emailBytes)

                        data = {
                            "id_local": ID,
                            "sender": msg["from"],
                            "subject": msg["subject"],
                            "date": msg["date"],
                            "provider": label
                        }
                        self.EMAIL.append(data)
                    else: break
                        
            return True, self.EMAIL

        except Exception as e:
            return (False, e)

