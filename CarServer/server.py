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
    gpio.setup(left_r, gpio.OUT)
    gpio.setup(left_d, gpio.OUT)
    gpio.setup(right_d, gpio.OUT)
    gpio.setup(right_r, gpio.OUT)


def cleanup():
    init()
    gpio.output(left_r, 0)
    gpio.output(left_d, 0)
    gpio.output(right_d, 0)
    gpio.output(right_r, 0)
    gpio.cleanup()


sio = socketio.AsyncServer()
app = web.Application()
sio.attach(app)


async def index(request):
    return web.Response(text="Hello World", content_type='text/html')


@sio.event
def connect(sid, environ):
    print('connect ', sid)
    cleanup()


@sio.on('move')
def print_message(sid, lr, ld, rd, rr):
    print(("Socket ID: ", sid))
    print(lr, ld, rd, rr)
    init()
    gpio.output(left_r, lr)
    gpio.output(left_d, ld)
    gpio.output(right_d, rd)
    gpio.output(right_r, rr)


@sio.event
def disconnect(sid):
    print('disconnect ', sid)
    cleanup()


app.router.add_get('/', index)

if __name__ == '__main__':
    cleanup()
    web.run_app(app)
