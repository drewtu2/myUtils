from PIL import Image
from PIL.ExifTags import TAGS, GPSTAGS
import glob

def get_exif_data(image):
    """
    Returns a dictionary from the exif data of an PIL Image item. 
    Also converts the GPS Tags
    param image: A PIL Image Item
    """
    exif_data = {}
    info = image._getexif()
    if info:
        for tag, value in info.items():
            decoded = TAGS.get(tag, tag)
            if decoded == "GPSInfo":
                gps_data = {}
                for t in value:
                    sub_decoded = GPSTAGS.get(t, t)
                    gps_data[sub_decoded] = value[t]

                exif_data[decoded] = gps_data
            else:
                exif_data[decoded] = value

    return exif_data

def _get_if_exist(data, key):
    if key in data:
        return data[key]
		
    return None
	
def _convert_to_degress(value):
    """
    Helper function to convert the GPS coordinates stored in the EXIF to degress 
    in float format
    """

    d0 = value[0][0]
    d1 = value[0][1]
    d = float(d0) / float(d1)

    m0 = value[1][0]
    m1 = value[1][1]
    m = float(m0) / float(m1)

    s0 = value[2][0]
    s1 = value[2][1]
    s = float(s0) / float(s1)

    return d + (m / 60.0) + (s / 3600.0)

def get_lat_lon(exif_data):
    """
    Returns the latitude and longitude, if available, from the provided 
    exif_data (obtained through get_exif_data above)
    """
    lat = None
    lon = None

    if "GPSInfo" in exif_data:		
        gps_info = exif_data["GPSInfo"]

        gps_latitude = _get_if_exist(gps_info, "GPSLatitude")
        gps_latitude_ref = _get_if_exist(gps_info, 'GPSLatitudeRef')
        gps_longitude = _get_if_exist(gps_info, 'GPSLongitude')
        gps_longitude_ref = _get_if_exist(gps_info, 'GPSLongitudeRef')

        if gps_latitude and gps_latitude_ref and gps_longitude and gps_longitude_ref:
            lat = _convert_to_degress(gps_latitude)
            if gps_latitude_ref != "N":                     
                lat = 0 - lat

            lon = _convert_to_degress(gps_longitude)
            if gps_longitude_ref != "E":
                lon = 0 - lon

    return lat, lon

def append_to_url(base, imagePath, gps):
    """
    Concatenates the gps coordinates and image file to the base url for use with
    openstreetmap. 
    param base: the base url to be appended to. If not the first appended coordinates,
    base must be followed by a | symbol. 
    param imagePath: the path of the image these coordinates are from
    param gps: a tuple with (lat, lon)
    """
    entry = "%f,%f,lightblue%s|" % (gps[0], gps[1], imagePath)
    map_url = "%s%s" %(base, entry)
    return map_url

def process_file(baseUrl, fileName):
    """
    Handle the processing for a single file. 
    """
    hasExif = 0;
    hasGps = 0;

    image = Image.open(fileName)
    exif_data = get_exif_data(image)

    if exif_data:
        hasExif = 1;
        gps = get_lat_lon(exif_data)

    # Append GPS data if we found it
    if gps and all(gps):
        print("%s: %f, %f" % (fileName, gps[0], gps[1]))
        hasGps = 1;
        return (append_to_url(baseUrl, fileName, gps), hasExif, hasGps)
    else:
        return (baseUrl, hasExif, hasGps)


################
# Example ######
################
if __name__ == "__main__":
    
    zoom = 2
    map_url = "http://staticmap.openstreetmap.de/staticmap.php?&zoom=%d&size=865x512&maptype=mapnik&markers=" % (zoom)

    numFiles = 0;
    numExif = 0;
    numGps = 0;

    # Iterate through every fil in the current folder.
    for fileName in glob.glob("*.jpg"):
        print("Trying %s..." % fileName)
        response = process_file(map_url, fileName)
        map_url = response[0]

        numFiles += 1
        numExif += response[1]
        numGps += response[2]

    # Remove the last "|" from the url
    map_url = map_url[:-1]
    print("Total Files: %d | Num w/ Exif %d | Num w/ GPS %d" % (numFiles, numExif, numGps))
    print(map_url)
