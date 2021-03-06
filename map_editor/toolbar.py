import pygame
from sprites import TYPES_NAME

class Toolbar:
    def __init__(self, program):
        self.program = program
        self.opt = program.opt
        self.prop = dict()
        self.screen = pygame.Surface((self.opt.TOOLBAR_X,self.opt.TOOLBAR_Y))
        self.reset_screen()

    def reset_screen(self):
        self.screen.fill((30, 30, 30))
        prop = self.program.converter.properties
        images = self.program.images

        px = 0
        for x,type_name in enumerate(TYPES_NAME):
            self.prop[x+px] = list()
            ay = 0
            for y,(code,image) in enumerate(images[type_name].items()):
                if y-ay > self.opt.TILE_Y+4:
                    ay += self.opt.TILE_Y+5
                    px += 1
                    self.prop[x+px] = list()
                self.screen.blit(image, ((x+px)*self.opt.TILE_SIZE,(y-ay)*self.opt.TILE_SIZE))
                self.prop[x+px].append(code)
            pygame.draw.line(self.screen, self.opt.Colors.BLACK, (self.opt.TILE_SIZE*(x+px+1),0),
                            (self.opt.TILE_SIZE*(x+px+1),self.opt.TOOLBAR_Y), 4)


    def draw(self, screen):
        screen.blit(self.screen,(self.opt.WIDTH+self.opt.TILE_SIZE,0))
