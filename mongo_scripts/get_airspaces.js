conn = new Mongo();
db = conn.getDB("skykit");
var airspacesCursor = db.airspace.find();
print(airspacesCursor.length() + " airspaces");


function prettyAirways(airways) {
	return {
		size: airways.length,
		wgs: ( function() {
			if(airways[0].wgs84Geometry && airways[0].wgs84Geometry.points.length > 0) {
				return "YES";
			}
			else {
				return "NO";
			}
		} )(),
		cartesian: ( function() {
			if(airways[0].cartesianGeometry && airways[0].cartesianGeometry.points.length > 0) {
				return "YES";
			}
			else {
				return "NO";
			}
		} )()
	}
}

function prettySectors(sectors) {
	return {
		size: sectors.length,
		wgs: ( function() {
			if(sectors[0].wgs84Geometry && sectors[0].wgs84Geometry.points.length > 0) {
				return "YES";
			}
			else {
				return "NO";
			}
		} )(),
		cartesian: ( function() {
			if(sectors[0].cartesianGeometry && sectors[0].cartesianGeometry.points.length > 0) {
				return "YES";
			}
			else {
				return "NO";
			}
		} )()
	}
}

function getPretty(airspace) {
	return {
		id: airspace._id,
		name: airspace.name,
		center: ( function() {
			if (airspace.centerPoint) {
				return airspace.centerPoint.wgs84.latitude + "/"+ airspace.centerPoint.wgs84.longitude;
			}
			else {
				return "NU are centerPoint";
			}
		} () ),
		sectors: prettySectors(airspace.sectors),
		aoi: ( function() {
				if (airspace.AOISectors) {
					return airspace.AOISectors.length;
				}
				else {
					return "NU are AOISectors";
				}
			} )(),
		airways: prettyAirways(airspace.airways)
	}
}


airspacesCursor.toArray().forEach(a => print(tojson(getPretty(a))));
