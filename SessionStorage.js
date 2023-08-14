var nameCounter = 1;
var coutOfNames = 0;
function saveNames() {
	coutOfNames++;
	var key = "name" + coutOfNames;
	sessionStorage.setItem(key, document.getElementById('name').value);
	// alert(sessionStorage.getItem(key) + " -" + coutOfNames);
}
function showNames() {
	while (nameCounter <= coutOfNames) {
		var key = "name" + nameCounter;
		document.getElementById('data').value += sessionStorage.getItem(key);
		document.getElementById('data').value += '\n';
		// document.write(sessionStorage.getItem(key));
		nameCounter++;
	}
}