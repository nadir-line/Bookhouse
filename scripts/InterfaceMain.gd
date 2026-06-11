extends GridContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_funds : float = 0
var current_paper : float = 0
var current_ink : float = 0
var current_books : float = 0
var current_wood : float = 0
var current_metal : float = 0
var current_tools : float = 0
var current_science : float = 0

var funds_to_paper_ratio : float = 1
var funds_to_ink_ratio : float = 1

var ink_to_books_ratio : float = 1
var paper_to_books_ratio : float = 1

var books_to_funds_ratio : float = 5

var funds_to_wood_ratio : float = 2
var funds_to_metal_ratio : float = 2

var metal_to_tools_ratio : float = 1
var wood_to_tools_ratio : float = 1

var tools_to_funds_ratio : float = 10


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
		current_funds -= $BooksNode/OptionsPaper/QtyPaper.value * funds_to_paper_ratio
		current_paper += $BooksNode/OptionsPaper/QtyPaper.value
	else:
		return
	$BooksNode/OptionsPaper/QtyPaper.value = 0

func _on_Buy_Ink_button_down():
	if(current_funds >= 0):
		current_funds -= $BooksNode/OptionsInk/QtyInk.value * funds_to_ink_ratio
		current_ink += $BooksNode/OptionsInk/QtyInk.value
	else: 
		return
	$BooksNode/OptionsInk/QtyInk.value = 0

func _on_Make_Books_button_down():
	if(current_ink && current_paper >= 0):
		current_ink -= $BooksNode/OptionsBooks/QtyBooks.value * ink_to_books_ratio
		current_paper -= $BooksNode/OptionsBooks/QtyBooks.value * paper_to_books_ratio
		current_books += $BooksNode/OptionsBooks/QtyBooks.value
	else: 
		return
	$BooksNode/OptionsBooks/QtyBooks.value = 0

func _on_Sell_Books_button_down():
	if(current_books >= 0):
		current_books -= $BooksNode/OptionsBooks/QtyBooks.value
		current_funds += $BooksNode/OptionsBooks/QtyBooks.value * books_to_funds_ratio
	else: 
		return

func _on_unlock_tools_button_down():
	if (current_funds >= 1000):
		$ToolsNode.visible = true
		current_funds -= 1000
		$BooksNode/UnlockTools.visible = false
		$BlankSpace2.visible = true
	else:	
		$ToolsNode.visible = false
		$BlankSpace2.visible = false
func _on_buy_wood_button_down(): 
	if(current_funds >= 0):
		current_funds -= $ToolsNode/OptionsWood/QtyWood.value * funds_to_wood_ratio
		current_wood += $ToolsNode/OptionsWood/QtyWood.value
	else:
		return
	$ToolsNode/OptionsWood/QtyWood.value = 0
	
func _on_buy_metal_button_down(): 
	if(current_funds >= 0):
		current_funds -= $ToolsNode/OptionsMetal/QtyMetal.value * funds_to_metal_ratio
		current_metal += $ToolsNode/OptionsMetal/QtyMetal.value
	else:
		return
	$ToolsNode/OptionsMetal/QtyMetal.value = 0

func _on_make_tools_button_down():
	if(current_metal && current_wood >= 0):
		current_metal -= $ToolsNode/OptionsTools/QtyTools.value * metal_to_tools_ratio
		current_wood -= $ToolsNode/OptionsTools/QtyTools.value * wood_to_tools_ratio
		current_tools += $ToolsNode/OptionsTools/QtyTools.value
	else: 
		return
	$ToolsNode/OptionsTools/QtyTools.value = 0

func _on_sell_tools_button_down():
	if(current_tools >= 0):
		current_tools -= $ToolsNode/OptionsTools/QtyTools.value
		current_funds += $ToolsNode/OptionsTools/QtyTools.value * tools_to_funds_ratio
	else: 
		return

func _on_unlock_buildings_button_down():
	if (current_funds >= 10000):
		$BuildingsNode.visible = true
		current_funds -= 10000
		$ToolsNode/UnlockBuildings.visible = false
		$BlankSpace3.visible = true
	else:	
		$BuildingsNode.visible = false
		$BlankSpace3.visible = false
		
func _on_Timer_timeout():
	$BooksNode/CurrentFunds.text = "Funds: %0.2f" % [current_funds]
	$ToolsNode/CurrentFunds2.text = "Funds: %0.2f" % [current_funds]
	$BuildingsNode/CurrentFunds3.text = "Funds: %0.2f" % [current_funds]
	
	$BooksNode/CurrentInk.text = "Ink: %0.2f" % [current_ink]
	$BooksNode/CurrentPaper.text = "Paper: %0.2f" % [current_paper]
	$BooksNode/CurrentBooks.text = "Books: %0.2f" % [current_books]
	
	$ToolsNode/CurrentWood.text = "Wood: %0.2f" % [current_wood]
	$ToolsNode/CurrentMetal.text = "Metal: %0.2f" % [current_metal]
	$ToolsNode/CurrentTools.text = "Tools: %0.2f" % [current_tools]
	
	#$BuildingsNode/CurrentInk.text = "Ink: %0.2f" % [current_ink]
	#$BuildingsNode/CurrentPaper.text = "Paper: %0.2f" % [current_paper]
	#$BuildingsNode/CurrentBooks.text = "Books: %0.2f" % [current_books]
	#$BuildingsNode/CurrentWood.text = "Wood: %0.2f" % [current_wood]
	#$BuildingsNode/CurrentMetal.text = "Metal: %0.2f" % [current_metal]
	#$BuildingsNode/CurrentTools.text = "Tools: %0.2f" % [current_tools]
	$BuildingsNode/CurrentScience.text = "Science: %0.2f" % [current_science]
