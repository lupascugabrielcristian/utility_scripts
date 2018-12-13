conn = new Mongo();
db = conn.getDB("skykit");

//const callsign = "TMA515";
const callsign = "MML802";
const from = 2600;
const batchSize = 5;

var previewFligthsCursor = db.previewFlight.find();

function makePretty(pP) {
	return {
		lat: pP.lat,
		lng: pP.long,
		x: pP.x,
		y: pP.y,
		level: pP.level,
		heading: pP.heading,
		time: pP.time
	}
}

const foundFlight = previewFligthsCursor.toArray().find(previewFlight => previewFlight.callsign === callsign);
if(!foundFlight) {
	print("Callsign not found");
	exit(1);
}

print("Punctele de la " + from + ", la " + (from + batchSize) + " pentru callsign " + callsign);
print(tojson(foundFlight.points.slice(from, from + batchSize).map(previewPoint => makePretty(previewPoint))));
print("In total sunt " + foundFlight.points.length + " preview points");
