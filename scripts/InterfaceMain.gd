extends VFlowContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_funds : float = 0
var current_paper : float = 0
var current_ink : float = 0
var current_books : float = 0
var current_wood : float = 0

var funds_to_paper_ratio : float = 1
var funds_to_ink_ratio : float = 1

var ink_to_books_ratio : float = 1
var paper_to_books_ratio : float = 1

var books_to_funds_ratio : float = 5

var funds_to_wood_ratio : float = 2
# var funds_to_wood_ratio : float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	current_funds = 500
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	pass
	
#	$Data.text = \
#		( \
#			"DATA: \n" + \
#			"Avail. Paper: %05.1f" % [current_paper] + "\n" + \
#			"Avail. Ink: %05.1f" % [current_ink] + "\n" \
#		)

func _on_Buy_Paper_button_down(): 
	if(current_funds >= 0):
		current_funds -= $OptionsPaper/QtyPaper.value * funds_to_paper_ratio
		current_paper += $OptionsPaper/QtyPaper.value
	else:
		return
	$OptionsPaper/QtyPaper.value = 0

func _on_Buy_Ink_button_down():
	if(current_funds >= 0):
		current_funds -= $OptionsInk/QtyInk.value * funds_to_ink_ratio
		current_ink += $OptionsInk/QtyInk.value
	else: 
		return
	$OptionsInk/QtyInk.value = 0


func _on_Make_Books_button_down():
	if(current_ink && current_paper >= 0):
		current_ink -= $OptionsBooks/QtyBooks.value * ink_to_books_ratio
		current_paper -= $OptionsBooks/QtyBooks.value * paper_to_books_ratio
		current_books += $OptionsBooks/QtyBooks.value
	else: 
		return
	$OptionsBooks/QtyBooks.value = 0

func _on_Sell_Books_button_down():
	current_books -= $OptionsBooks/QtyBooks.value
	current_funds += $OptionsBooks/QtyBooks.value * books_to_funds_ratio

func _on_Buy_Wood_button_down(): 
	if(current_funds >= 0):
		current_funds -= $OptionsWood/QtyWood.value * funds_to_wood_ratio
		current_wood += $OptionsWood/QtyWood.value
	else:
		return
	$OptionsWood/QtyWood.value = 0

func _on_Timer_timeout():
	$CurrentFunds.text = "Funds: %0.2f" % [current_funds]
	$CurrentInk.text = "Ink: %0.2f" % [current_ink]
	$CurrentPaper.text = "Paper: %0.2f" % [current_paper]
	$CurrentBooks.text = "Books: %0.2f" % [current_books]
