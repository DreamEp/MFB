extends Node


var x_values = range(0, 1000)
#Those params create a multi function which take x values from 0 to 500 and return y = 1 to 2
#For exemple it permit to return 2 and double the base attack speed by multiplying by y given the % 
var init_params = [[200, 0.01, 0.5], [550, 0.005, 0.3], [850, 0.002, 0.2]]
var y_values = []

func _ready():
	for x in x_values:
		y_values.append(multi_logistic_function(x, init_params))
	var x_custom = 0  # Remplacez ceci par votre valeur de x
	var y_custom = multi_logistic_function(x_custom, init_params)
	print("La valeur de y pour x = " + str(x_custom) + " est " + str(y_custom))
		

func logistic_function(x, x0, k, L):
	return L / (1 + exp(-k * (x - x0)))

func multi_logistic_function(x, params):
	var y = 0.0
	for param in params:
		var x0 = param[0]
		var k = param[1]
		var L = param[2]
		y += logistic_function(x, x0, k, L)
	return y+0.9 #So it start at 1 when x value = 0
