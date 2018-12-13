const airspaceName = "ASIM";

conn = new Mongo();
db = conn.getDB("skykit");
var airspacesCursor = db.airspace.find();
print(airspacesCursor.length() + " airspaces");

const selection = {
	byName: "",
	byRange: {
		from: 0,
		to: 5
	}
}


function getPretty(airspace) {
	return {
		id: airspace._id,
		name: airspace.name,
	}
}

function getPrettyAirway(airway) {
	return {
		name: airway.name,
		type: airway.type,
		wgsGeometry: airway.wgs84Geometry.points.length + " points",
		cartesianGeometry: ( function() {
			if (!!airway.cartesianGeometry) {
				return airway.cartesianGeometry.points.length + " points";
			}
			else {
				return "NO";
			}
		})()
	}
}

const foundAirspace = airspacesCursor.toArray().find(airspace => airspace.name === airspaceName);
print (foundAirspace.airways.length + " airways in total");

const selectedAirways = foundAirspace.airways.slice(selection.byRange.from, selection.byRange.to);
print(tojson(selectedAirways.map(getPrettyAirway)));
