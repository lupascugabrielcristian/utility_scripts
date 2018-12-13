const airspaceName = "ASIM";

conn = new Mongo();
db = conn.getDB("skykit");
var airspacesCursor = db.airspace.find();
print(airspacesCursor.length() + " airspaces");

function getPretty(airspace) {
	return "ID: " + airspace._id + ", NAME: " + airspace.name;
}


airspacesCursor.toArray().forEach(airspace => getPretty(airspace));

const foundAirspace = airspacesCursor.toArray().find(airspace => airspace.name === airspaceName);

if (!!foundAirspace) {
	print("Airspace found");
}


print(foundAirspace.significantPoints.length + " significantPoints");


const allNames = foundAirspace.significantPoints.map(sp => sp.id).join(" ");
print (allNames);
