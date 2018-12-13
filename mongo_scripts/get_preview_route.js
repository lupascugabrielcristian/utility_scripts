conn = new Mongo();
db = conn.getDB("skykit");

const callsign = "CARLOS1";
const from = 0;
const batchSize = 5;

var previewFligthsCursor = db.previewFlight.find();

function pretty(previewFlight) {
	return {
		trackNb: previewFlight.trackNb,
		acty: previewFlight.acty
	}
}

const foundFlight = previewFligthsCursor.toArray().find(previewFlight => previewFlight.callsign === callsign);
if(!foundFlight) {
	print("Callsign not found");
	exit(1);
}

print("In total sunt " + foundFlight.route.length + " preview route");


print(tojson(foundFlight.route.slice(from, from + batchSize)));
print(tojson(pretty(foundFlight)));
