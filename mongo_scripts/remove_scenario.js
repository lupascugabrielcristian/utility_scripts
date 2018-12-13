conn = new Mongo();
db = conn.getDB("skykit");

const scenarioId = new ObjectId("5bbb6516eb4c1f559806fce1");
const scenarioName = undefined;

var scenariosCursor = db.scenario.find();
const before = scenariosCursor.length();
// db.scenario.deleteOne({_id: scenarioId});
db.scenario.deleteOne({name: "ASIM"});

var scenariosCursor = db.scenario.find();
const after = scenariosCursor.length();

print("Before: "  + before + " after " + after);
