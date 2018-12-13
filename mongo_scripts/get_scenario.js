conn = new Mongo();
db = conn.getDB("skykit");
const scenarioName = "ASIM";

var scenariosCursor = db.scenario.find();
print(scenariosCursor.length() + " scenarios");
const foundScenario = scenariosCursor.toArray().find(scenario => scenario.name === scenarioName);

if (!foundScenario) {
	print("Din not found scenario with the name " + scenarioName);
}

function prettyScenario(scenario) {
	return {
		uuid: scenario._id,
		name: scenario.name,
		statTime: scenario.startSimulationTime,
		callsigns: scenario.routes.map(r => r.aircraftIdentification).join(" ")
	}
}

print(tojson(prettyScenario(foundScenario)));
