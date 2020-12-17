conn = new Mongo();
db = conn.getDB("avocati");


function getDosareMonitorizate() {
	var dosareCursor = db.dosare_collection.find();
	dosare_monitorizate = dosareCursor.toArray()
	return dosare_monitorizate
}

print( getDosareMonitorizate().map( dm => dm.last_time_checked ) )
print("Parti " + getDosareMonitorizate().map( dm => dm.parti.length ) )
print("Sedinte " + getDosareMonitorizate().map( dm => dm.sedinte.length ) )
