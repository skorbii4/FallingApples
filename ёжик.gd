extends CharacterBody2D


var SPEED = 150

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

var one_raz_shildss = false
var One_raz_ocki = true

var damage_igolki = false # проверка на получение урона

		
func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity * delta #Гравитация ёжика
	
	anim_ezhik() #анимация ёжика
	apple_box() #хитбокс для ловли яблок
	polozhenie_ezh() #Поведения ёжика в разных положениях
	if damage_igolki == true:
		damage_ezh() #урон от ёжика

func _on_tp_body_entered(body):
	if body.name == "tp_left":
		var spawn_ezhik = Vector2 (1230,position.y) #Телепорт
		position = spawn_ezhik
	if body.name == "tp_right":
		var spawn_ezhik = Vector2 (-20,position.y) #Телепорт
		position = spawn_ezhik
		
func anim_ezhik():
	if not Global.tree == 0: #Если ветер есть
		#выключить ёжика
		if Global.polozhenie_ezhika == 0: 
			if Global.speed_ezh == 1:
				anim.play("deas_prosto_R")
			else:
				anim.play("deas_prosto_L")
			await anim.animation_finished
			queue_free()
		if Global.polozhenie_ezhika == 1: 
			if Global.speed_ezh == 1:
				anim.play("deas_apple_R")
			else:
				anim.play("deas_apple_L")
			await anim.animation_finished
			queue_free()
		if Global.polozhenie_ezhika == 2:
			if Global.speed_ezh == 1:
				anim.play("deas_speed_R")
			else:
				anim.play("deas_speed_L")
			await anim.animation_finished
			queue_free()
		if Global.polozhenie_ezhika == 3 and is_on_floor(): 
			if Global.speed_ezh == 1:
				anim.play("deas_jump_R")
			else:
				anim.play("deas_jump_L")
			await anim.animation_finished
			queue_free()
		# с яблоком защиты ёжик не убегает, т.к. во время ветра ёжик получает иммунитет.
		if Global.polozhenie_ezhika == 5:
			if Global.speed_ezh == 1: 
				anim.play("deas_gold_R")
			else:
				anim.play("deas_gold_L")
			await anim.animation_finished
			queue_free()
		if Global.polozhenie_ezhika == 6: 
			if Global.speed_ezh == 1:
				anim.play("deas_korz_R")
			else:
				anim.play("deas_korz_L")
			await anim.animation_finished
			queue_free()
		
	else:	#Если ветра нет
		if Global.polozhenie_ezhika == -1: #ёжик с гнилым яблоком
			if One_raz_ocki == true: #один раз дает + очки
				One_raz_ocki = false
				#получил за это очки
				Global.score += 1
				Global.very_score += 1
				Global.chet += 1
				Global.gold += 1
				#Увеличивает рекордные очки
				if (Global.score > Global.hi_score):
					Global.hi_score = Global.score
				if Global.musek_efect == true: #звук + очков
					Global.plus_ochki = true
			#анимация скрытия ёжика
			if Global.speed_ezh == 1:
				anim.play("deas_zlo_R")
			else:
				anim.play("deas_zlo_L")
			await anim.animation_finished
			queue_free()
			One_raz_ocki = true
		if Global.polozhenie_ezhika == 0: #просто бежит ёжик
			if Global.speed_ezh == 1:
				anim.play("run_prosto_R")
			else:
				anim.play("run_prosto_L")
		if Global.polozhenie_ezhika == 1: #Ёжик с простым яблочком
			if Global.speed_ezh == 1:
				anim.play("run_apple_R")
			else:
				anim.play("run_apple_L")
		if Global.polozhenie_ezhika == 2: #Ёжик с яблоком скорости
			if Global.speed_ezh == 1:
				anim.play("run_speed_R")
			else:
				anim.play("run_speed_L")
		if Global.polozhenie_ezhika == 3: #Ёжик с яблоком прыгучести
			if Global.speed_ezh == 1:
				anim.play("run_jump_R")
			else:
				anim.play("run_jump_L")
			
		if Global.polozhenie_ezhika == 4 and Global.deaf_live_ezhik == 1: #Ёжик с яблоком защиты
			if Global.speed_ezh == 1:
				anim.play("run_def_R")
			else:
				anim.play("run_def_L")
			shield()
			
		if Global.polozhenie_ezhika == 4 and Global.deaf_live_ezhik == -1: #в последнюю стадию ветра щит ломается, а ёжик остается с голой спиной
			if Global.speed_ezh == 1:
				anim.play("deas_def_R")
			else:
				anim.play("deas_def_L")
			await anim.animation_finished
			shield()
			if Global.musek_efect == true:
				$"-def".play()
			Global.deaf_live_ezhik = 0
			Global.polozhenie_ezhika = 0
			
		if Global.polozhenie_ezhika == 5: #Ёжик с золотым яблоком
			if Global.speed_ezh == 1:
				anim.play("run_gold_R")
			else:
				anim.play("run_gold_L")
		if Global.polozhenie_ezhika == 6: #Ёжик с корзинкой
			if Global.speed_ezh == 1:
				anim.play("run_korz_R")
			else:
				anim.play("run_korz_L")
			

func shield():
	if Global.deaf_live_ezhik == 1:
		if one_raz_shildss == false:
			one_raz_shildss = true
			$Shield/shieldss.play("+щит")
	if Global.deaf_live_ezhik == -1:
		if one_raz_shildss == true:
			one_raz_shildss = false
			$Shield/shieldss.play("-щит")
			
func apple_box():
	if Global.polozhenie_ezhika == 6 or Global.polozhenie_ezhika == 0:
		$apple_lov_ezh/CollisionShape2D.disabled = false
	else:
		$apple_lov_ezh/CollisionShape2D.disabled = true
		

func polozhenie_ezh(): #Поведения ёжика в разных положениях
	if Global.polozhenie_ezhika	== 2: # Если ёжик с яблоком скорости
		if 	Global.speed_ezh == 1: # Если скорость положительная
			velocity.x = (Global.speed_ezh * SPEED) + 200 + Global.speeds_sonikx
		else: # Иначе скорость отрицательная
			velocity.x = (Global.speed_ezh * SPEED) - 200 + Global.speeds_sonikx
	else: # Если ёжик с любым другим яблоком
		velocity.x = Global.speed_ezh * SPEED + Global.speeds_sonikx 
	move_and_slide()
	
	if Global.polozhenie_ezhika == 3 and Global.tree == 0:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor(): #прыжок с земли
			velocity.y = -400 #прыжок ёжика
	
	
func damage_ezh(): #урон от ёжика
	if Global.HP > 0:
		if Global.block_dmg == false:
			Global.poluch_dmg = true
			if Global.deaf == 1:
				Global.migaet_gg = false
				Global.deaf = 0
				print ("Потерял 1 деф")
				if Global.musek_efect == true:
					Global.def_brok = true
			else:
				Global.migaet_gg = true
				Global.HP -= 1
				Global.damage = true
				if Global.musek_efect == true:
					Global.ochki_minus = true
				print ("- 1 хп")

#проверка на получает и не получает урон от иголок
func _on_igolki_body_entered(body):
	if body.name == "sbor_golovoi":
		damage_igolki = true
	
func _on_igolki_body_exited(body):
	if body.name == "sbor_golovoi":
		damage_igolki = false
