from __future__ import print_function

import sys
import os

from liblo import *

try:
    input = raw_input
except NameError:
    pass

class MyServer(ServerThread):
    def __init__(self):
        ServerThread.__init__(self, 7777)

    @make_method('/foo', 'i')
    def heartbeat(self, path, args):
        if (args[0] == 1):
            print("received message")
            os.system("mpv beat.wav")

    @make_method(None, None)
    def fallback(self, path, args):
        print("unk %s" % path)

try:
    server = MyServer()
except ServerError as err:
    print(err)
    sys.exit()

server.start()
input("press enter to quit... \n")

