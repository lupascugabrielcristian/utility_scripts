const SCENARIO_NAME = "ASIM";

conn = new Mongo();
db = conn.getDB("skykit");
var scenarioCursor = db.scenario.find({}, {});
print("Cursorul are " + scenarioCursor.length());

const allScenarioNames = scenarioCursor.toArray().map(scenario => scenario.name).join(" | ");
print("Scenariile sunt: " + allScenarioNames);

var scenario = scenarioCursor.toArray()[0];
var scenario = scenarioCursor.toArray().find(scenario => scenario.name === SCENARIO_NAME);
print("Scenariul are " + scenario.routes.length + " rute")


function extractMappedRoute(route) {
	return {
		aircraftIdentification: route.aircraftIdentification
	}
}

var mappedRoutes = scenario.routes.map(extractMappedRoute);

print("Scenariul " + scenario.name + "/" + scenario._id + " contine rutele: ");
print(tojson(mappedRoutes));


