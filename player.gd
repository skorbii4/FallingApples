extends CharacterBody2D


var SPEED = 175.0
var JUMP_VELOCITY = -325
var g = 0 #сопротивление ветра
var kosanie_nogoi_left = false
var kosanie_nogoi_right = false
var jump_bats = false #прыжок на батуте

var tolat_mozno_left = false
var tolat_mozno_right = false

var one_raz_shild = false

var i

var rivok_process #сразу же после рывка нужно включить анимацию полета

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var anim = $AnimatedSprite2D
@onready var timer = $left_noga/Timer
@onready var head2 = $head2/head2
@onready var head = $head/head
@onready var head_hitbox = $head_hitbox/head_hitbox
@onready var left_noga = $left_noga/left_noga
@onready var vremen_korz = $isceznet_vremen_korz

func _ready() -> void:
	Global.HP = Global.HP_MAX
	Global.tree = 0
	$chettext.modulate.a = 0
	if Global.GG == 0:
		anim.play("idle2")
	if Global.GG == 1:
		anim.play("2_idle2")
	if Global.GG == 2:
		anim.play("3_idle2")
	if Global.GG == 3:
		anim.play("4_idle2")
	#нужно для корректного спавна временной корзинки
	Global.smotru = "left"
	
			
func _process(delta: float) -> void:
	if Global.avto_modes == true and Global.tree == 0:
		Global.mozno_nazat_na_knopku_tolk = false #во время автомода нельзя нажимать на кнопку
		if Global.smotru == "right":
			velocity.x = 125
		if Global.smotru == "left":
			velocity.x = -125
		if Global.GG == 0: # Скины вступают в игру
			anim.play("run2")
		if Global.GG == 1:
			anim.play("2_run2")
		if Global.GG == 2:
			anim.play("3_run2")
		if Global.GG == 3:
			anim.play("4_run2")
			
	else:
		rivok() #анимация рывка и её функция
		smena_korz() #Корзинка в руки во время ветра. После ветра обратно на голову (пока везде отключил хитбокс)
		ochki_sboku() #получаю очки или теряю и это выводится рядом с персонажем
		shield() #анимация щита и её функция
		migaet() #анимация, чтоб мигал ГГ
		dmg_neuaz() #неуязвимость ГГ
		jump(delta)#прыжок
		
	
		# Ходьба влево и вправо
		var direction
		direction = Input.get_axis("ui_left", "ui_right")
		if direction: #если я нажимаю кнопки для перемещения
			peredvizh_ot_vetra() #сопротивление персонажа от ветра
			if Global.sam_process_tolkania_bat == false and Global.korz_na_golove == 0: #не толкаю ящик
				
					if is_on_floor(): #если на земле
						#рывок отсутсвует
						if Global.rivok == false:	
							velocity.x = direction * (SPEED + Global.baf_skor_apple + Global.speed_prokac) + g # direction -1 если нажал влево 1 если вправо, SPEED - изначальная скорость, g - сопротивление ветра, Global.baf_skor_apple - баф скорости от яблока скорости
							$head/head2.disabled = true
						#рывок присутствует 
						else:
							velocity.x = direction * 1000
							$head/head2.disabled = false
					if not is_on_floor(): #если в воздухе
						#рывок отсутсвует
						if Global.rivok == false:	
							velocity.x = (direction * (SPEED + Global.baf_skor_apple + Global.speed_prokac) + g) / 1.5 # direction -1 если нажал влево 1 если вправо, SPEED - изначальная скорость, g - сопротивление ветра, Global.baf_skor_apple - баф скорости от яблока скорости
							$head/head2.disabled = true
						#рывок присутствует 
						else:
							velocity.x = direction * 1000
							$head/head2.disabled = false
				
				#если положение корзинки на голове, я двигаюсь и ветер пока не дует или утихает	
					if Global.tolkay == true:
						if Global.tree == 0:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("tolk_bat")
							if Global.GG == 1:
								anim.play("2_tolk_bat")
							if Global.GG == 2:
								anim.play("3_tolk_bat")
							if Global.GG == 3:
								anim.play("4_tolk_bat")
					if Global.tolkay == false:
						if Global.tree == 0:
							if Global.rivok == true:
								if Global.GG == 0: # Скины вступают в игру
									anim.play("rivok")
								if Global.GG == 1:
									anim.play("2_rivok")
								if Global.GG == 2:
									anim.play("3_rivok")
								if Global.GG == 3:
									anim.play("4_rivok")
								rivok_process = true
							else:
								if rivok_process == true and not is_on_floor():
									if Global.korz_na_golove == 0:
										if Global.GG == 0: # Скины вступают в игру
											anim.play("polet")
										if Global.GG == 1:
											anim.play("2_polet")
										if Global.GG == 2 :
											anim.play("3_polet")
										if Global.GG == 3:
											anim.play("4_polet")
								if rivok_process == true and is_on_floor():
									rivok_process = false
								if velocity.y == 0 and is_on_floor():
									if Global.GG == 0: # Скины вступают в игру
										anim.play("run2")
									if Global.GG == 1:
										anim.play("2_run2")
									if Global.GG == 2:
										anim.play("3_run2")
									if Global.GG == 3:
										anim.play("4_run2")
								if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and (Global.jump_prokac == 1 or Global.jump_prokac == 2 or Global.jump_prokac == 3): #прыжок в воздухе:
									if Global.korz_na_golove == 0:
										if Global.GG == 0: # Скины вступают в игру
											anim.play("polet")
										if Global.GG == 1:
											anim.play("2_polet")
										if Global.GG == 2 :
											anim.play("3_polet")
										if Global.GG == 3:
											anim.play("4_polet")
										await anim.animation_finished
								
					#если положение корзинки на голове, я двигаюсь и ветер дует или утихает
					if Global.tree == 2 or Global.tree == -2 or Global.tree == 1 or Global.tree == -1:
						if Global.rivok == true:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("rivok")
							if Global.GG == 1:
								anim.play("2_rivok")
							if Global.GG == 2:
								anim.play("3_rivok")
							if Global.GG == 3:
								anim.play("4_rivok")
							rivok_process = true
						else:
							if rivok_process == true and not is_on_floor():
								if Global.korz_na_golove == 0:
									if Global.GG == 0: # Скины вступают в игру
										anim.play("polet_veter")
									if Global.GG == 1:
										anim.play("2_polet_veter")
									if Global.GG == 2 :
										anim.play("3_polet_veter")
									if Global.GG == 3:
										anim.play("4_polet_veter")
							if rivok_process == true and is_on_floor():
								rivok_process = false
							if velocity.y == 0 and is_on_floor() and Global.korz_na_golove == 0:
								if Global.GG == 0: # Скины вступают в игру
									anim.play("run_veter")
								if Global.GG == 1:
									anim.play("2_run_veter")
								if Global.GG == 2:
									anim.play("3_run_veter")
								if Global.GG == 3:
									anim.play("4_run_veter")
							if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and (Global.jump_prokac == 1 or Global.jump_prokac == 2 or Global.jump_prokac == 3): #прыжок в воздухе:
								if Global.korz_na_golove == 0:
									if Global.GG == 0: # Скины вступают в игру
										anim.play("polet_veter")
									if Global.GG == 1:
										anim.play("2_polet_veter")
									if Global.GG == 2 :
										anim.play("3_polet_veter")
									if Global.GG == 3:
										anim.play("4_polet_veter")
									await anim.animation_finished
			
			if Global.sam_process_tolkania_bat == true and Global.korz_na_golove == 0: #если толкаю ящик
				
				if is_on_floor(): #если на земле
					#рывок отсутсвует
					if Global.rivok == false:	
						velocity.x = direction * (150) + g # direction -1 если нажал влево 1 если вправо, 150 - изначальная скорость,
					#рывок присутствует 
					if Global.rivok == true: 
						velocity.x = direction * 1000
				
				
				#если положение корзинки на голове, я двигаюсь и ветер пока не дует или утихает	
				if Global.korz_na_golove == 0: 
						if Global.tree == 0:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("tolk_bat")
							if Global.GG == 1:
								anim.play("2_tolk_bat")
							if Global.GG == 2:
								anim.play("3_tolk_bat")
							if Global.GG == 3:
								anim.play("4_tolk_bat")
						if Global.tree == 2 or Global.tree == -2 or Global.tree == 1 or Global.tree == -1:
							if velocity.y == 0 and is_on_floor():
								if Global.GG == 0: # Скины вступают в игру
									anim.play("idle_veter")
								if Global.GG == 1:
									anim.play("2_idle_veter")
								if Global.GG == 2:
									anim.play("3_idle_veter")
								if Global.GG == 3:
									anim.play("4_idle_veter")
					
						
		else: #если не нажимаю влево и вправо
			if Global.smotru == "right":
				if is_on_floor():
					$head/head.position = Vector2 (2, -66)
				if not is_on_floor():
					$head/head.position = Vector2 (2, -88)
			if Global.smotru == "left":
				if is_on_floor():
					$head/head.position = Vector2 (22, -66)
				if not is_on_floor():
					$head/head.position = Vector2 (22, -88)
					
					
			if Global.rivok == true: #функция рывка при положении idle
				$head/head2.disabled = false
				if $AnimatedSprite2D.flip_h == true:
					velocity.x = 1 * 1000
				if $AnimatedSprite2D.flip_h == false:
					velocity.x = -1 * 1000
			else:
				$head/head2.disabled = true
				if Global.tree == 0:
					velocity.x = move_toward(velocity.x, 0, SPEED) #!!!ПОЛЕЗНО, нажал на кнопку ходьбы, отпустил и персонаж остановился
					
					
			# Дует ветер и персонаж сам по себе передвигается от ветра
				if Global.rivok == false:
					if Global.tree == 1 or Global.tree == 3: 
						velocity.x = 50
					if Global.tree == 2:
						velocity.x = 100
					if Global.tree == -1 or Global.tree == -3:
						velocity.x = -50
					if Global.tree == -2:
						velocity.x = -100
		
			if Global.korz_na_golove == 0: #если положение корзинки на голове, я не двигаюсь и ветер пока не дует или утихает
				if Global.tree == 0:
					if Global.rivok == true:
						if Global.GG == 0: # Скины вступают в игру
							anim.play("rivok")
						if Global.GG == 1:
							anim.play("2_rivok")
						if Global.GG == 2:
							anim.play("3_rivok")
						if Global.GG == 3:
							anim.play("4_rivok")
						rivok_process = true
					else:
						if rivok_process == true and not is_on_floor():
							if Global.korz_na_golove == 0:
								if Global.GG == 0: # Скины вступают в игру
									anim.play("polet")
								if Global.GG == 1:
									anim.play("2_polet")
								if Global.GG == 2 :
									anim.play("3_polet")
								if Global.GG == 3:
									anim.play("4_polet")
						if rivok_process == true and is_on_floor():
							rivok_process = false
						if velocity.y == 0 and is_on_floor():
							if Global.sam_process_tolkania_bat == false: #если не толкаю ящик
								if Global.GG == 0: # Скины вступают в игру
									anim.play("idle2")
								if Global.GG == 1:
									anim.play("2_idle2")
								if Global.GG == 2:
									anim.play("3_idle2")
								if Global.GG == 3:
									anim.play("4_idle2")
							else: #если толкаю ящик на месте
								if Global.GG == 0: # Скины вступают в игру
									anim.play("idle_tolk")
								if Global.GG == 1:
									anim.play("2_idle_tolk")
								if Global.GG == 2:
									anim.play("3_idle_tolk")
								if Global.GG == 3:
									anim.play("4_idle_tolk")
						if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and (Global.jump_prokac == 1 or Global.jump_prokac == 2 or Global.jump_prokac == 3): #прыжок в воздухе
							if Global.korz_na_golove == 0:
								if Global.GG == 0: # Скины вступают в игру
									anim.play("polet")
								if Global.GG == 1:
									anim.play("2_polet")
								if Global.GG == 2 :
									anim.play("3_polet")
								if Global.GG == 3:
									anim.play("4_polet")
								await anim.animation_finished
				
				#если положение корзинки на голове, я не двигаюсь и ветер подул					
				if Global.tree == 2 or Global.tree == -2 or Global.tree == 1 or Global.tree == -1:
					if Global.tree == 2 or Global.tree == -2 or Global.tree == 1 or Global.tree == -1:
						if Global.rivok == true:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("rivok")
							if Global.GG == 1:
								anim.play("2_rivok")
							if Global.GG == 2:
								anim.play("3_rivok")
							if Global.GG == 3:
								anim.play("4_rivok")
							rivok_process = true
						else:
							if rivok_process == true and not is_on_floor():
								if Global.korz_na_golove == 0:
									if Global.GG == 0: # Скины вступают в игру
										anim.play("polet_veter")
									if Global.GG == 1:
										anim.play("2_polet_veter")
									if Global.GG == 2 :
										anim.play("3_polet_veter")
									if Global.GG == 3:
										anim.play("4_polet_veter")
							if rivok_process == true and is_on_floor():
								rivok_process = false
							if velocity.y == 0 and is_on_floor():
								if Global.GG == 0: # Скины вступают в игру
									anim.play("idle_veter")
								if Global.GG == 1:
									anim.play("2_idle_veter")
								if Global.GG == 2:
									anim.play("3_idle_veter")
								if Global.GG == 3:
									anim.play("4_idle_veter")
							if Input.is_action_just_pressed("ui_accept") and not is_on_floor() and (Global.jump_prokac == 1 or Global.jump_prokac == 2 or Global.jump_prokac == 3): #прыжок в воздухе:
								if Global.korz_na_golove == 0:
									if Global.GG == 0: # Скины вступают в игру
										anim.play("polet_veter")
									if Global.GG == 1:
										anim.play("2_polet_veter")
									if Global.GG == 2 :
										anim.play("3_polet_veter")
									if Global.GG == 3:
										anim.play("4_polet_veter")
									await anim.animation_finished
					
		if direction == 1:
			$AnimatedSprite2D.flip_h = true #Разворот модельки персонажа вправо
			Global.smotru = "right"
			#Хитбоксы смещаются в зависимости от поворота персонажа
			$Shield.position = Vector2 (-72, -122)
			if is_on_floor():
				$head/head.position = Vector2 (2, -66)
			if not is_on_floor():
				$head/head.position = Vector2 (2, -88)
			$tp/body.position = Vector2 (19, 814)
			$head2/head2.position = Vector2 (18, 2)
			$"hodit po lvly".position = Vector2 (-5, 25)
			$tolk_bat/CollisionShape2D.position = Vector2 (25, 26)
			$sbor_golovoi/CollisionShape2D.position = Vector2 (-3, -11)
			$HitBox/CollisionShape2D.position = Vector2 (16, 841)
			
		elif direction == -1:
			$AnimatedSprite2D.flip_h = false #Разворот модельки персонажа влево
			Global.smotru = "left"
			#Хитбоксы смещаются в зависимости от поворота персонажа
			$Shield.position = Vector2 (-52, -122)
			if is_on_floor():
				$head/head.position = Vector2 (22, -66)
			if not is_on_floor():
				$head/head.position = Vector2 (22, -88)
			$tp/body.position = Vector2 (39, 814)
			$head2/head2.position = Vector2 (18, 2)
			$"hodit po lvly".position = Vector2 (19, 25)
			$tolk_bat/CollisionShape2D.position = Vector2 (-10, 26)
			$sbor_golovoi/CollisionShape2D.position = Vector2 (18, -11)
			$HitBox/CollisionShape2D.position = Vector2 (42, 841)
		
	move_and_slide()

	

func _on_tp_body_entered(body): #Телепорт из левого края вправы и наоборот
	if body.name == "tp_left":
		var spawn_player = Vector2 (1200,position.y) #Телепорт
		position = spawn_player
	if body.name == "tp_right":
		var spawn_player = Vector2 (6,position.y) #Телепорт
		position = spawn_player


	if body.name == "TileMap":
		jump_bats = false
	
	#толкание батута при прикосновении
	if body.name == "left_bat" or body.name == "right_bat":	
		Global.tolkay = true
	if body.name == "left_bat":	
		tolat_mozno_left = true
	elif body.name == "right_bat":	
		tolat_mozno_right = true
		
func _on_left_noga_body_exited(body):
	# когда не соприкосаюсь с батутом - батут не двигается
	if body.name == "left_bat" or body.name == "right_bat":	
		Global.tolkay = false
		tolat_mozno_left = false
		tolat_mozno_right = false
		Global.skor_bat = 0

#снятие и надевание корзинки	
func smena_korz():
	if Global.tree == 0: # Корзинка в руки во время ветра. После ветра обратно на голову (пока везде отключил хитбокс)
		head2.disabled = true
		head.disabled = false
	if Global.tree == 3 or Global.tree == -3:
		if Global.korz_na_golove == 1:
			Global.kol_vo_nazati_korz = 0 #сбрасывает количество нажатий корзинки
			head.disabled = false
			head2.disabled = true
			$head/head2.disabled = false
			if Global.GG == 0: # Скины вступают в игру
				anim.play("naden_korz")
			if Global.GG == 1:
				anim.play("2_naden_korz")
			if Global.GG == 2:
				anim.play("3_naden_korz")
			if Global.GG == 3:
				anim.play("4_naden_korz")
			await anim.animation_finished
			Global.korz_na_golove = 0
			$head/head2.disabled = true
			$head/head.disabled = false
			if not is_on_floor():
				if Global.GG == 0: # Скины вступают в игру
					anim.play("polet")
				if Global.GG == 1:
					anim.play("2_polet")
				if Global.GG == 2 :
					anim.play("3_polet")
				if Global.GG == 3:
					anim.play("4_polet")
				await anim.animation_finished
	if Global.tree == 1 or Global.tree == -1:
		Global.avto_modes = false #отключает автомод когда подул ветер
		if Global.korz_na_golove == -1:
			Global.kol_vo_nazati_korz = 0 #сбрасывает количество нажатий корзинки
			$head/head2.disabled = false
			$head/head.disabled = true
			if Global.GG == 0: # Скины вступают в игру
				anim.play("snatie_korz")
			if Global.GG == 1: 
				anim.play("2_snatie_korz")
			if Global.GG == 2: 
				anim.play("3_snatie_korz")
			if Global.GG == 3: 
				anim.play("4_snatie_korz")
			await anim.animation_finished
			Global.korz_na_golove = 0
			head.disabled = true
			head2.disabled = false
		
#рывок			
func rivok():
	if Input.is_action_just_pressed("рывок") and Global.rivok_prokac == 1 and Global.rivok_mozno == true and Global.korz_na_golove == 0 and Global.korz_na_golove == 0:
		Global.rivok_dla_int = true
		Global.rivok_mozno = false
		Global.rivok = true
		if Global.musek_efect == true:
			$rivok2.play()
		$rivok.set_wait_time(0.25)
		$rivok.start()
		$perez_rivok.set_wait_time(20)
		$perez_rivok.start()
	if Input.is_action_just_pressed("рывок") and Global.rivok_prokac == 2 and Global.rivok_mozno == true and Global.korz_na_golove == 0 and Global.korz_na_golove == 0:
		Global.rivok_dla_int = true
		Global.rivok_mozno = false
		Global.rivok = true
		if Global.musek_efect == true:
			$rivok2.play()
		$rivok.set_wait_time(0.25)
		$rivok.start()
		$perez_rivok.set_wait_time(15)
		$perez_rivok.start()
	if Input.is_action_just_pressed("рывок") and Global.rivok_prokac == 3 and Global.rivok_mozno == true and Global.korz_na_golove == 0 and Global.korz_na_golove == 0:
		Global.rivok_dla_int = true
		Global.rivok_mozno = false
		Global.rivok = true
		if Global.musek_efect == true:
			$rivok2.play()
		$rivok.set_wait_time(0.25)
		$rivok.start()
		$perez_rivok.set_wait_time(10)
		$perez_rivok.start()

func _on_rivok_timeout():
	Global.rivok = false


func _on_perez_rivok_timeout():
	Global.rivok_mozno = true
	
	
func ochki_sboku():
	if Global.score > Global.razn:
		var diferance = Global.score - Global.razn
		$chettext.text = str(diferance)
		$chetanim.play("+очки")
		Global.razn = Global.score
	if Global.score < Global.razn:
		var diferance = Global.razn - Global.score
		$chettext.text = str(diferance)
		$chetanim.play("-очки")
		Global.razn = Global.score

func peredvizh_ot_vetra(): #сопротивление персонажа от ветра
		if Global.tree == 0: #Если нет ветра то скорость обычная
			g = 0
		if Global.tree == 1 and g < 50: #Ветер начинается и скорость увеличивается в сторону ветра, а в противоположную уменьшается
			if g == 0:
				Global.korz_na_golove = -1
			g += 1
		if Global.tree == 2 and g < 100: #Ветер начался и скорость увеличилась в сторону ветра, а в противоположную уменьшилась
			g += 1
		if Global.tree == 3 and g > 0: #Ветер уменьшается и скорость уменьшается
			g -= 4
		if Global.tree == -1 and g > -50: #Ветер начинается и скорость увеличивается в сторону ветра, а в противоположную уменьшается
			if g == 0:
				Global.korz_na_golove = -1
			g -= 1
		if Global.tree == -2 and g > -100: #Ветер начался и скорость увеличилась в сторону ветра, а в противоположную уменьшилась
			g -= 1
		if Global.tree == -3 and g < 0:  #Ветер уменьшается и скорость уменьшается
			g += 4


func dmg_neuaz(): # неуязвимость ГГ
	if Global.poluch_dmg == true:
		Global.poluch_dmg = false
		if Global.HP > 0:
			Global.block_dmg = true # урон не наносится пока включен блок на получение урона
			Global.neuaz_one_raz = true #чтоб можно было иконку повесить 1 раз под ХП
		
func shield():
	if Global.deaf == 1:
		if one_raz_shild == false:
			one_raz_shild = true
			$shield.play("+щит")
	if Global.deaf == 0:
		if one_raz_shild == true:
			one_raz_shild = false
			$shield.play("-щит")
			
func migaet():
	if Global.block_dmg == true and Global.migaet_gg == true:
		$playerss.play("migaet")
	else:
		$playerss.play("default")


func _on_hit_box_body_entered(body):
	if body.name == "Птица":
		if Global.HP > 0:
			if Global.block_dmg == false:
				Global.poluch_dmg = true
				if Global.deaf == 1:
					Global.migaet_gg = false
					Global.deaf = 0
					if Global.musek_efect == true:
						$"-def".play()
				else:
					Global.migaet_gg = true
					Global.HP -= 1
					Global.damage = true
					if Global.musek_efect == true:
						$"урон от ёжика".play()


func _on_блокирование_урона_timeout() -> void:
	Global.block_dmg = false

func jump(delta):#прыжок
	#цифры насколько я прыгаю
	if not is_on_floor() and Global.rivok == false and velocity.y < 400:
		velocity.y += gravity * delta
	if not is_on_floor() and Global.rivok == true:
		velocity.y = 0
	if Global.jump_pl == true:
		velocity.y = -750
	#проверка для птицы, сделал я прыжок или нет
	if is_on_floor_only():
		Global.sdelal_jump = false
	if not is_on_floor_only():
		Global.sdelal_jump = true
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and ((Global.jump_prokac >= 1 and Global.JUMP_mozno == true) or (Global.jump_prokac == 0 and Global.JUMP_mozno == false)): #прыжок с земли
			velocity.y = JUMP_VELOCITY + Global.baf_jump_apple + Global.jump_prokach #Прыжок + баф за яблоко + прокачка на прыжки
			if Global.baf_jump == true:
				if Global.musek_efect == true:
					$jump_pod_apple.play()
			if Global.korz_na_golove == 0:
					if Global.tree == 0 or Global.tree == 3 or Global.tree == -3:
						if Global.GG == 0: # Скины вступают в игру
							anim.play("jump")
						if Global.GG == 1:
							anim.play("2_jump")
						if Global.GG == 2:
							anim.play("3_jump")
						if Global.GG == 3:
							anim.play("4_jump")
						await anim.animation_finished
					if Global.tree == 1 or Global.tree == 2 or Global.tree == -1 or Global.tree == -2:
						if Global.GG == 0: # Скины вступают в игру
							anim.play("jump_veter")
						if Global.GG == 1:
							anim.play("2_jump_veter")
						if Global.GG == 2:
							anim.play("3_jump_veter")
						if Global.GG == 3:
							anim.play("4_jump_veter")
						await anim.animation_finished
					
	if Input.is_action_just_pressed("ui_accept") and not is_on_floor(): #прыжок в воздухе
			if Global.jump_prokac == 1 or Global.jump_prokac == 2 or Global.jump_prokac == 3:
				if Global.JUMP_mozno == true:
					Global.JUMP_mozno = false
					Global.jumpx2_dla_int = true
					velocity.y = -550 #Прыжок + баф за яблоко + прокачка на прыжки
					if Global.musek_efect == true:
						$"двойной прыжок".play()
					if Global.korz_na_golove == 0:
						if Global.tree == 0 or Global.tree == 3 or Global.tree == -3:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("polet")
							if Global.GG == 1:
								anim.play("2_polet")
							if Global.GG == 2 :
								anim.play("3_polet")
							if Global.GG == 3:
								anim.play("4_polet")
							await anim.animation_finished

						if Global.tree == 1 or Global.tree == 2 or Global.tree == -1 or Global.tree == -2:
							if Global.GG == 0: # Скины вступают в игру
								anim.play("polet_veter")
							if Global.GG == 1:
								anim.play("2_polet_veter")
							if Global.GG == 2:
								anim.play("3_polet_veter")
							if Global.GG == 3:
								anim.play("4_polet_veter")
							await anim.animation_finished
