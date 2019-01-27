class Note:

    def __init__(self, name):
        self.name = name
        self.contents = []
        self.id = ""

    def toMap(self):
        databaseMap = { "name": self.name, "contents": self.contents }
        return databaseMap

    def toText(self):
        result = f'{self.name.upper()} ({self.id}) = \n'
        for c in self.contents:
            result = result + f'\t{c}\n'
        return result
