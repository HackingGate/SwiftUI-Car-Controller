import RPi.GPIO as gpio
import time
from aiohttp import web
import socketio

left_r = 7
left_d = 11
right_d = 13
right_r = 15


def init():
    gpio.setmode(gpio.BOARD)
    gpio.setup(7, gpio.OUT)
    gpio.setup(11, gpio.OUT)
    gpio.setup(13, gpio.OUT)
    gpio.setup(15, gpio.OUT)


sio = socketio.AsyncServer()
app = web.Application()
sio.attach(app)


async def index(request):
    return web.Response(text="Hello World", content_type='text/html')


@sio.on('move')
def print_message(sid, lr, ld, rd, rr):
    print(("Socket ID: ", sid))
    print(lr, ld, rd, rr)
    init()
    gpio.output(left_r, lr)
    gpio.output(left_d, ld)
    gpio.output(right_d, rd)
    gpio.output(right_r, rr)


app.router.add_get('/', index)

if __name__ == '__main__':
    web.run_app(app)
