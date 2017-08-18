from flask import Flask
from models import db
from models import Bugs
import datetime

app = Flask(__name__)

app.config.from_object('config')
db.init_app(app)

@app.route("/")
def main():
    #return 'Hello World !'
    bugs = Bugs.query.all()
    res = []
    for b in bugs:
        res = res + [b.title]
    return "\n".join(res)

@app.route("/add")
def add():
    foo = 'woo! {}'.format(str(datetime.datetime.now()))
    b = Bugs(title=foo)
    db.session.add(b)
    db.session.commit()
    return 'Added {}!'.format(foo)


if __name__ == '__main__':
    app.run()
