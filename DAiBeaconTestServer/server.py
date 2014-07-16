from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app
from google.appengine.ext import db

import beaconModel

class StarterClass(webapp.RequestHandler):
    def post(self):
        self.saveBeacon(self.request)

    def get(self):
        self.saveBeacon(self.request)

    def saveBeacon(self, request):
        new_item = beaconModel.BeaconModel()
        new_item.userId = request.get('userID')
        new_item.deviceId = request.get('deviceID')
        new_item.regionId = request.get('regionID')
        new_item.regionName = request.get('regionName')
        new_item.action = request.get('action')
        new_item.timestamp = request.get('timestamp')
 
        new_item.put()

app = webapp.WSGIApplication([('/.*', StarterClass)], debug=True)

def main():
    run_wsgi_app(app)

if __name__ == '__main__':
    main()
