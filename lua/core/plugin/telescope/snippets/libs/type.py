#EXAPMLE

from dataclasses import dataclass

@dataclass
class TypeEmail:
    label: str
    server: str
    user: str
    
    def __post_init__(self):
        #*Checks Your Types
        if not all(isinstance(v, str) for v in (self.label, self.server, self.user, self.pw)):
            raise TypeError("All fields in TypeEmail must be strings")   pw: str
