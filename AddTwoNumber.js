function add(number1, number2) {
	return (number1 + number2);
}
const promt = require("promt-sync")();
number1 = promt("Enter a number: ");
number2 = promt("Enter another number: ");
console.log("Addition of " + number1 + " and " + number2 + " is: " + add(12, 45));