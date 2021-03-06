from sprites import TYPES_NAME, newSprite

class Converter:
    def __init__(self, program):
        self.program = program
        self.file_exist = True
        try: self.lua_file = open(self.program.path_maps,"r")
        except: self.file_exist = False; return
        self.lua_text = str()

        # remove cumments
        for row in self.lua_file:
            row = row.strip()
            if "--" in row: row = row.split("--")[0]
            self.lua_text += row

        # remove \t and \n
        try: self.lua_text = self.lua_text.translate(None, '\t\n ')
        except: self.lua_text = self.lua_text.translate('\t\n ')


        # get text
        prop = dict()
        text = self.lua_text
        prop["wall"] = text.split("wall")[1].split("floor")[0]
        prop["floor"] = text.split("floor")[1].split("door")[0]
        prop["door"] = text.split("door")[1].split("npc")[0]
        prop["npc"] = text.split("npc")[1].split("decor")[0]
        prop["decor"] = text.split("decor")[1].split("torch")[0]
        prop["torch"] = text.split("torch")[1].split("cartel")[0]
        prop["cartel"] = text.split("cartel")[1].split("water")[0]
        prop["water"] = text.split("water")[1].split("lever")[0]
        prop["lever"] = text.split("lever")[1].split("chest")[0]
        prop["chest"] = text.split("chest")[1]
        self.properties = prop

        # split text
        for property in self.properties:
            p = list()
            for a in self.properties[property].split("}"):
                properties = a.split("{")[-1].split(",")
                if len(properties) >= 3 or properties[0].split("=")[0] == "id":
                    p.append(properties)
            self.properties[property] = p

        #split dict
        for type_name in TYPES_NAME:
            for pos, param in enumerate(self.properties[type_name]):
                self.properties[type_name][pos] = newSprite(type_name, param)

    def update(self):
        layers = list()
        for k,v in self.properties.items():
            elements = list()
            for element in v:
                if not element.LAYER in layers:
                    elements.append(element)
                    layers.append(element.LAYER)
            self.properties[k] = elements
