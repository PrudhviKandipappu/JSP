nameCounter = 1;
countOfNames = 1;
function saveNames() {
	var key = "name" + countOfNames;
	localStorage.setItem(key, document.getElementById('name').value);
	document.getElementById('name').value="";
	countOfNames++;
}

function showNames() {
	var key;
	while (nameCounter <= countOfNames) {
		key = "name" + nameCounter;
		document.getElementById('data').value += localStorage.getItem(key);
		document.getElementById('data').value += '\n';
		nameCounter++;
	}
}