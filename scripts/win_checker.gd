extends Area2D

func _on_body_entered(body):
	if body == GameManager.car:
		GameManager.win()
