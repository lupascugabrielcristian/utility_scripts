const airspaceName = "ASIM";
const pointName = "AR941";

conn = new Mongo();
db = conn.getDB("skykit");
var airspacesCursor = db.airspace.find();
print(airspacesCursor.length() + " airspaces");

function getPretty(airspace) {
	return {
		id: airspace._id,
		name: airspace.name,
	}
}

function getPrettyPoint(point) {
	return {
		name: ( function() { return point.name; } )(),
		WGScoordinates: "Lat: " +  point.wgs84Geometry.latitude + 
			", Long: " + point.wgs84Geometry.longitude,
		cartesianCoordinates:( function() { 
			if (!!point.cartesianGeometry) {
				return "X: " +  point.cartesianGeometry.longitude + ", Y: " + point.cartesianGeometry.latitude;
			}
			else {
				return "No cartesian geometry"
			}
		} )(),
		cop: point.COP
	}
}

const prettyViews = airspacesCursor.toArray().map(airspace => getPretty(airspace));
print(tojson(prettyViews))



const foundAirspace = airspacesCursor.toArray().find(airspace => airspace.name === airspaceName);
print(tojson(getPretty(foundAirspace)))



const foundPoint = foundAirspace.significantPoints.find(point => point.name === pointName);
if (!!foundPoint) {
	print("\nPOINT");
	// print(tojson(getPrettyPoint(foundPoint)));
	print(tojson(foundPoint));
} else {
	print("Cannot find point " + pointName);
}

