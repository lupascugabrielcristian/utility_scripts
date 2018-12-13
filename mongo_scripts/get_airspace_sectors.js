const airspaceName = "ASIM";

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
		wgs: sector.wgs84Geometry.points.length,
		cartesian: sector.cartesianGeometry.points.length
	}
}

function getPrettyAOI(aoi) {
	return {
		identity: aoi.identity,
		wgs: aoi.wgs84Geometry.points.length + " points",
		cartesian: aoi.cartesianGeometry.points.length + " points"
	}
}

const foundAirspace = airspacesCursor.toArray().find(airspace => airspace.name === airspaceName);
print (foundAirspace.sectors.length + " sectors in total");
const firSectorsFound = foundAirspace.sectors.filter(sector => sector.type === "FIR_SECTOR").map(sector => sector.name);
const AOISectorsFound = foundAirspace.AOISectors;
const aoiNames = AOISectorsFound.map(s => s.identity);
const aoiPretty = AOISectorsFound.map(s => getPrettyAOI(s));

print(firSectorsFound.length + " Fir sectors");
print("Fir sectors found: " + tojson(firSectorsFound));
print(AOISectorsFound.length + " AOI sectors");
print("AOI sectors: " + aoiNames);
print(tojson(aoiPretty)
