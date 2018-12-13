conn = new Mongo();
db = conn.getDB("skykit");

var scenariosCursor = db.scenario.find();
print(scenariosCursor.length() + " scenarios");

function getAircrafts(scenario) {
	return scenario.routes.map(r => r.aircraftIdentification ).join(" ");
}

function getPretty(scenario) {
	return {
		id: scenario._id,
		name: scenario.name,
		airspace: scenario.airspaceName,
		airspaceId: scenario.airspaceId,
		routes: scenario.routes.length,
		aircrafts: getAircrafts(scenario)
	}
}

const prettyViews = scenariosCursor.toArray().map(scenario => getPretty(scenario));
print(tojson(prettyViews))
