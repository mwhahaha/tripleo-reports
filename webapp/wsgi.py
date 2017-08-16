from flask import Flask
application = Flask(__name__)


@application.route('/')
def hello():
    return b'Hello World from flask'

if __name__ == '__main__':
    application.run()
