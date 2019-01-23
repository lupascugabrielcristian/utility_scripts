class Note:

    def __init__(self, name):
        self.name = name
        self.contents = []

    def toMap(self):
        databaseMap = { "name": self.name, "contents": self.contents }
        return databaseMap

    def toText(self):
        result = "Note name: " + self.name  + ", contents: "
        for c in self.contents:
            result = result + c + ", "
        return result
