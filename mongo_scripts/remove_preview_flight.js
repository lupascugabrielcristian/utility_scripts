conn = new Mongo();
db = conn.getDB("skykit");


const callsign = "";
const scenarioId = "unkonwn scenarion id";

var previewFligthsCursor = db.previewFlight.find();
db.previewFlight.deleteOne({scenarioId: scenarioId});
