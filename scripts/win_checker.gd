extends Area2D

func _on_body_entered(body):
	if body == GameManager.car:
		print("win")
		GameManager.win()
	else:
		print("something else won (?)")
