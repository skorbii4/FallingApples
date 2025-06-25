extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


	
func _process(_delta: float) -> void:
	if Global.migaet_korz == 0:
		$AnimationPlayer.play("default")
	if Global.migaet_korz == 1:
		$AnimationPlayer.play("migaet")
	if Global.migaet_korz == 2:	
		queue_free()
		Global.migaet_korz = -1
		
	if is_on_floor():
		if Global.tree == 0:
			velocity.x = 0
		if Global.tree == 1 or Global.tree == 2 or Global.tree == 3:
			velocity.x = 100
		if Global.tree == -1 or Global.tree == -2 or Global.tree == -3:
			velocity.x = -100
			
	move_and_slide()


func _on_teleps_body_entered(body):
	if body.name == "tp_left":
		var spawn_korz = Vector2 (1175,570) #Телепорт
		position = spawn_korz
	if body.name == "tp_right":
		var spawn_korz = Vector2 (10,570) #Телепорт
		position = spawn_korz
	
	if body.name == "ёжик":
		Global.migaet_korz = 2
		if Global.polozhenie_ezhika == 0:
			if randf() < 0.2:
				Global.polozhenie_ezhika = 6
		
