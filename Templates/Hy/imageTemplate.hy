(import pygame)
(import pygame.draw)
(def size [500 500])
(def orangered [255 69 0])
(def black [0 0 0])
(def draw pygame.draw)
(pygame.init)
(def screen (pygame.display.set_mode size))
(pygame.display.set_caption "Template")

(setv notDone 1)
(def clock (pygame.time.Clock))

(while notDone 
    (screen.fill orangered)
    (draw.line screen black [0 0] size 10)
    (pygame.display.flip)
    (clock.tick 60))
(pygame.quit)
        
