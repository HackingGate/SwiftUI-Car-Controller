from aiohttp import web
import socketio

sio = socketio.AsyncServer()
app = web.Application()
sio.attach(app)


async def index(request):
    return web.Response(text="Hello World", content_type='text/html')


@sio.on('move')
def print_message(sid, l_move, r_move):
    print(("Socket ID: ", sid))
    print(l_move, r_move)


app.router.add_get('/', index)

if __name__ == '__main__':
    web.run_app(app)
