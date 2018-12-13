const selectedAirspaceId = "5bd7167ceb4c1f5e0ebf1eb5";


conn = new Mongo();
db = conn.getDB("skykit");
var representationsCursor = db.AirspaceRepresentations.find();
var representations = representationsCursor.toArray();
print(representations.length + " representations");

db.AirspaceRepresentations.remove( { airspaceId: selectedAirspaceId } );


const representationsCursorAfter = db.AirspaceRepresentations.find();
const representationsAfter = representationsCursorAfter.toArray();
print(representationsAfter.length + " representations");
