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

        self.data = self.lua_text.split("{")[2].split("}")[0].split(",")
        self.properties = dict()

        # get text
        self.properties["wall"] = self.lua_text.split("walls")[1].split("floors")[0]
        self.properties["floor"] = self.lua_text.split("floors")[1].split("doors")[0]
        self.properties["door"] = self.lua_text.split("doors")[1].split("npc")[0]
        self.properties["npc"] = self.lua_text.split("npc")[1].split("decor")[0]
        self.properties["decor"] = self.lua_text.split("decor")[1].split("torch")[0]
        self.properties["torch"] = self.lua_text.split("torch")[1].split("cartel")[0]
        self.properties["cartel"] = self.lua_text.split("cartel")[1]

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

    def show(self):
        for k,vv in self.properties.items():
            print(k)
            for v in vv: print(v)

    def update(self):
        for k,v in self.properties.items():
            l = list()
            for element in v:
                if not element in l:
                    l.append(element)
            self.properties[k] = l
