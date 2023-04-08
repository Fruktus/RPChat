extends Button

func on_click():
	get_tree().get_root().get_node("Main/LoadFromDirDialog").popup_centered()
