import sqlalchemy as sa
import os
from app import db, app
from users_policy import UserPolicy
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin 
from flask import url_for


class Departament_Type(db.Model):
    __tablename__ = 'departament_types'

    departament_type_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return '<Departament_Type %r>' % self.departament_type_id


class Departament(db.Model):
    __tablename__ = 'departaments'

    departament_id = db.Column(db.Integer, primary_key=True)
    departament_type_id = db.Column(db.Integer, db.ForeignKey('departament_types.departament_type_id'))
    name = db.Column(db.String(100), nullable=False)



    def __repr__(self):
        return '<Departament %r>' % self.departament_id



class Building(db.Model):
    __tablename__ = 'buildings'

    building_id = db.Column(db.Integer, primary_key=True)
    departament_id = db.Column(db.Integer, db.ForeignKey('departaments.departament_id'))
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return '<Building %r>' % self.building_id

class Room_Height_type(db.Model):
    __tablename__ = 'room_height_type'

    room_height_type_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return '<Room_Height_type %r>' % self.room_height_type_id

class Placements(db.Model):
    __tablename__ = 'placements'

    placement_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    floor = db.Column(db.Integer, nullable=False)
    number = db.Column(db.Integer, nullable=False)

    def __repr__(self):
        return '<Placements %r>' % self.placement_id

class Room_Type(db.Model):
    __tablename__ = 'room_type'

    room_type_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)

    def __repr__(self):
        return '<Room_Type %r>' % self.room_type_id






class Room(db.Model):
    __tablename__ = 'rooms'

    room_id = db.Column(db.Integer, primary_key=True)
    building_id = db.Column(db.Integer, db.ForeignKey('buildings.building_id'))
    room_type_id = db.Column(db.Integer, db.ForeignKey('room_type.room_type_id'))
    room_height_type_id =  db.Column(db.Integer, db.ForeignKey('room_height_type.room_height_type_id'))
    placement_id = db.Column(db.Integer, db.ForeignKey('placements.placement_id'))
    width = db.Column(db.Integer, nullable=False)
    length = db.Column(db.Integer, nullable=False)
    height = db.Column(db.Integer, nullable=False)


    def __repr__(self):
        return '<Room %r>' % self.room_id





class User(db.Model, UserMixin):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    login = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)
    last_name = db.Column(db.String(100), nullable=False)
    first_name = db.Column(db.String(100), nullable=False)
    middle_name = db.Column(db.String(100))
    role_id = db.Column(db.Integer, db.ForeignKey('roles.id', ondelete='CASCADE'))
    
    role = db.relationship('Role')


    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    @property
    def is_admin(self):
        return app.config.get('ADMIN_ROLE_ID') == self.role_id

    @property
    def is_moder(self):
        return app.config.get('MODER_ROLE_ID') == self.role_id

    @property
    def is_user(self):
        return app.config.get('USER_ROLE_ID') == self.role_id

    def can(self, action):
        user_policy = UserPolicy()
        method = getattr(user_policy, action) 
        if method is not None:
            return method()
        return False


    def __repr__(self):
        return '<Users  %r>' % self.login

class Role(db.Model):
    __tablename__ = 'roles'
    
    id = db.Column(db.Integer, primary_key=True)
    role_name = db.Column(db.String(100), nullable=False)
    role_description = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return '<Role %r>' % self.role_name

class Books(db.Model):
    __tablename__ = 'books'
    
    id = db.Column(db.Integer, primary_key=True)
    book_name = db.Column(db.String(100), nullable=False)
    book_description = db.Column(db.Text, nullable=False)

    def __repr__(self):
        return '<Book %r>' % self.book_name