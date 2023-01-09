import os
from flask import Flask, render_template, send_file, abort, send_from_directory, request
from sqlalchemy import MetaData
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import login_required

app = Flask(__name__)
application = app

app.config.from_pyfile('config.py')



convention = {
    "ix": 'ix_%(column_0_label)s',
    "uq": "uq_%(table_name)s_%(column_0_name)s",
    "ck": "ck_%(table_name)s_%(constraint_name)s",
    "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
    "pk": "pk_%(table_name)s"
}

metadata = MetaData(naming_convention=convention)
db = SQLAlchemy(app, metadata=metadata)
migrate = Migrate(app, db)

from auth import bp as auth_bp, init_login_manager
app.register_blueprint(auth_bp)


init_login_manager(app)

from models import *


class Cub:
    def __init__(self, length, width, height):
        self.length = length
        self.width  = width
        self.height = height

    @property
    def volume(self):
        return self.length * self.width * self.height

class Square:
    def __init__(self, length, width):
        self.length = length
        self.width  = width

    @property
    def area(self):
        return self.width * self.length

@app.route('/show_room/<int:room_id>')
# @login_required
def show_room(room_id):

    room_number = room_id
    height = Room.query.filter_by(room_id=room_id).first().height
    width = Room.query.filter_by(room_id=room_id).first().width
    length = Room.query.filter_by(room_id=room_id).first().length
    
    volume_room = Cub(height, width, length).volume
    area_room = Square(length, width).area

    return render_template('show_room.html', volume_room=volume_room, area_room=area_room,room_number=room_number)

@app.route('/show_building/<int:building_id>')
# @login_required
def show_building(building_id):
    building_number = building_id

    return render_template('show_building.html',building_number=building_number)



@app.route('/edit_buildings/<int:building_id>')
# @login_required
def edit_buildings(building_id):
    building = Building.query.get(building_id)
    return render_template('edit_buildings.html', building=building)

@app.route('/edit_room/<int:room_id>')
# @login_required
def edit_room(room_id):
    room = Room.query.get(room_id)
    return render_template('edit_room.html', room=room)


@app.route('/')
def index():
    rooms = Room.query.all()
    placements = Placements.query.all()
    return render_template('index.html', rooms=rooms, placements=placements)


# @app.route('/')
# def index():
#     name_buildings=Building.query.filter_by(building_id=1).first().name
#     number_of_faculties = 1

#     return render_template('index.html', name_buildings=name_buildings)



