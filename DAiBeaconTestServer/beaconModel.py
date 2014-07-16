from google.appengine.ext import db

class BeaconModel(db.Model):
    userId = db.StringProperty()
    deviceId = db.StringProperty()
    regionId = db.StringProperty()
    regionName = db.StringProperty(default='')
    action = db.StringProperty()
    timestamp = db.StringProperty()
