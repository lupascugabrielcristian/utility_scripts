conn = new Mongo();
db = conn.getDB("skykit");
var representationsCursor = db.AirspaceRepresentations.find();
const representations = representationsCursor.toArray();
print(representations.length + " representations");


function pretty(mapR) {
	return {
		airspaceId: mapR.airspaceId,
		countries: mapR.countries.length 
	}
}
const prettyOnes = representations.map(r => pretty(r));

print(tojson(prettyOnes));
