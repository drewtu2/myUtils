#!/usr/bin/python

class StaticMapBuilder:
    """
    A builder class that allows you to build a static map with small amounts of 
    information. Map points are defined by lat, lon, and a descriptor. 
    """
    
    DEFAULT_ZOOM = 2
    DEFAULT_WIDTH = 865
    DEFAULT_HEIGHT = 512
    DEFAULT_MAPTYPE= "mapnik"

    BASE_URL = "http://staticmap.openstreetmap.de/staticmap.php?"
    ZOOM_TAG = "&zoom="
    SIZE_TAG = "&size="
    MAP_TYPE_TAG = "&maptype="
    MARKER_TAG = "&markers="

    def __init__(self):
        """
        Initializes the StaticMapBuilder with default values. 
        """
        self.zoom       = StaticMapBuilder.DEFAULT_ZOOM
        self.width      = StaticMapBuilder.DEFAULT_WIDTH
        self.height     = StaticMapBuilder.DEFAULT_HEIGHT
        self.map_type   = StaticMapBuilder.DEFAULT_MAPTYPE
        self.points     = []

    def setZoom(self, zoom: int):
        """
        Set the zoom.
        """
        self.zoom = zoom
    
    def setWidth(self, width: int):
        """
        Set the zoom.
        """
        self.width = width 
    
    def setHeight(self, height: int):
        """
        Set the height.
        """
        self.height = height 
    
    def setMapType(self, map_type: str):
        """
        Set the map type.
        """
        #TODO: validate input
        self.map_type = map_type 

    def  addPoint(self, lat: float, lon: float, label: str):
        """
        Add a point with a given label to the map.
        """
        self.points.append((lat, lon, label))

    def _getMarkers(self) -> str:

        markerString = ""

        for entry in self.points:
            markerString += "%f,%f,lightblue%s|" % (entry[0], entry[1], entry[2])

        markerString = markerString[:-1] # Remove the last separator

        return markerString


    def build(self) -> str:
        """
        Produces a link to the static map. 
        """
        markers = self._getMarkers()

        url = StaticMapBuilder.BASE_URL \
                + StaticMapBuilder.ZOOM_TAG + ("%d" % (self.zoom)) \
                + StaticMapBuilder.SIZE_TAG + "%dx%d" % (self.width, self.height) \
                + StaticMapBuilder.MAP_TYPE_TAG + self.map_type \
                + StaticMapBuilder.MARKER_TAG + markers

        return url


