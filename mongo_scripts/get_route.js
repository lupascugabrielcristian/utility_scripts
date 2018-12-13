conn = new Mongo();
db = conn.getDB("skykit");
const scenarioName = "ASIM";
const aircraftIdentification = "CARLOS2";

var scenariosCursor = db.scenario.find();
print(scenariosCursor.length() + " scenarios");

function getPretty(route) {
	return {
		aircraftIdentification: route.aircraftIdentification,
		ecl: route.ECL,
		startTime: route.startTime,
		departureTime: route.departureTime,
	}
}

const foundScenario = scenariosCursor.toArray().find(scenario => scenario.name === scenarioName);

if (!!foundScenario) {
	print("scenario found");
}

const foundRoute = foundScenario.routes.find(route => route.aircraftIdentification === aircraftIdentification);

if(!!foundRoute) {
	print("Route found " + foundRoute.aircraftIdentification);
	print(foundRoute.route.map(fixP => fixP.name).join(" "));
	print(tojson(getPretty(foundRoute)));
}

