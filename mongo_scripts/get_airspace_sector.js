const airspaceName = "ASIM";
const sectorName = "APPBUCLA";

conn = new Mongo();
db = conn.getDB("skykit");
var airspacesCursor = db.airspace.find();
print(airspacesCursor.length() + " airspaces");


function getPretty(airspace) {
	return {
		id: airspace._id,
		name: airspace.name,
		center: airspace.centerPoint.wgs84.latitude + "/"+ airspace.centerPoint.wgs84.longitude
	}
}

function getPrettySector(sector) {
	return {
		name: sector.name,
		type: sector.type,
		wgs84: sector.wgs84Geometry.points.length,
		cartesian: sector.cartesianGeometry.points.length
	}
}

const foundAirspace = airspacesCursor.toArray().find(airspace => airspace.name === airspaceName);
const sectorFound = foundAirspace.sectors.find(sector => sector.name === sectorName);
if (!sectorFound) {
	print("Sector not found");
} else {
	print(tojson(getPrettySector(sectorFound)));
}
