conn = new Mongo();
db = conn.getDB("skykit");

var previewFligthsCursor = db.previewFlight.find();
print("Cursorul are " + previewFligthsCursor.length());

const callsigns = previewFligthsCursor.toArray().map(previewFlight => previewFlight.callsign);
const ids = previewFligthsCursor.toArray().map(previewFlight => previewFlight.scenarioId);
print(callsigns)
print(ids)


function getPretty(pf) {
	return {
		callsign: pf.callsign,
		scenarioId: pf.scenarioId,
		adep: pf.adep
	}
}

const prettyViews = previewFligthsCursor.toArray().map(previewFlight => getPretty(previewFlight));
print(tojson(prettyViews))

