extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
var napravlenie_bird_solo #соло выбор направления для каждой птицы
var speed_bird_solo = randi_range(0,75) #скорость для каждой птицы
var apple_u_bird = true #изначально яблоко вместе с птицей
var povishenie_visoty = 0 #птица летит изначально на 1 высоте
var rand #случайное число
var kakoe_apple_spawn = Global.polozhenie_bird #определяет, какое яблоко заспвнится
var Deas_bird = false #птица исчезает с карты
var One_raz_ocki = true #для прибавления очков 1 раз, за то, что птица поймает гнилое яблоко
var Timers = false #таймер для того, чтобы сработало поимка яблока,а потом уничтожение
var deaf_life_birds = false #заспавниться с щитом или без
var one_raz_shield = true #чтобы 1 раз сработал щит
var mozno_vzat_apple_u_berd = false #нужно, чтобы после таймера в 3 сек игрок смог взять яблоко защиты у птицы
var Bird_v_straxe = false #нужно, чтобы понимать, когда птица улетает в обратном направалении

var vzletaet = false #нужно для яблока прыгучести, чтобы пройти барьер сверху.

var posi #позиция для того, чтобы птица остановилась, когда вщлетает
var posi2 #позиция для яблока, 1 раз определяется

var nemozet_lovit_posle_sbrosa = false #птица после сброса не может ловить 2 секунды яблоки другие
var nomer_bird_solo #нумерует птиц

var vse_eshe_lovit1 #если птица всё ещё ловит обычное яблоко (нужно для того, чтобы яблоко не пропадало, когда оно уже соприкоснулось с птицей, но она не может ловить яблоко)
var vse_eshe_lovit2 #если птица всё ещё ловит яблоко скорости (нужно для того, чтобы яблоко не пропадало, когда оно уже соприкоснулось с птицей, но она не может ловить яблоко)
var vse_eshe_lovit3 #если птица всё ещё ловит яблоко прыгучести (нужно для того, чтобы яблоко не пропадало, когда оно уже соприкоснулось с птицей, но она не может ловить яблоко)
var vse_eshe_lovit4 #если птица всё ещё ловит яблоко защиты (нужно для того, чтобы яблоко не пропадало, когда оно уже соприкоснулось с птицей, но она не может ловить яблоко)
var vse_eshe_lovit5 #если птица всё ещё ловит золотое яблоко (нужно для того, чтобы яблоко не пропадало, когда оно уже соприкоснулось с птицей, но она не может ловить яблоко)

func _ready() -> void:
	napravlenie_bird_solo = Global.napravlenie_bird #соло выбор направления для каждой птицы
	# запускает таймер на повышение или понижение высоты
	rand = randi_range(1,3)
	$"на повышение или понижение высоты".set_wait_time(rand)
	$"на повышение или понижение высоты".start()
	#пронумеровал птицу
	Global.nomer_bird += 1
	nomer_bird_solo = Global.nomer_bird
	
	
	if kakoe_apple_spawn == 4: #если птица заспавнилась с яблоком защиты, то ей нужно дать анимацию получения щита и включить активацию щита.
		$Shield/shieldss.play("+щит")
		deaf_life_birds = true
		
	
func _process(_delta: float) -> void:
	
	if nemozet_lovit_posle_sbrosa == false and apple_u_bird == false: #3секунды после сброса яблока и если я отобрал у птицы яблоко
		$"Удаление яблока/CollisionShape2D".set_deferred("disabled", false)
	if nemozet_lovit_posle_sbrosa == true and apple_u_bird == false: #первые 3 секунды после сброса яблока
		$"Удаление яблока/CollisionShape2D".set_deferred("disabled", true)
	if apple_u_bird == true: #у птицы яблоко
		$"Удаление яблока/CollisionShape2D".set_deferred("disabled", true)
		
	
	
	anim_bird() #анимация птицы
	
	posi = $".".get_position()
	
	peremeshenie_vozdux()#перемещение птицы по воздуху
		
	
	move_and_slide()
	
func peremeshenie_vozdux():#перемещение птицы по воздуху	
	#перемещение птицы влево и врпаво без яблока Скорости и если птица не в страхе
	if napravlenie_bird_solo == 1:
		$TP_bird/CollisionShape2D.position = Vector2 (-47,-2)
		$CollisionShape2D.position = Vector2 (44,1)
		if not kakoe_apple_spawn == 2: #если птица не с яблоком скорости
			velocity.x = 150 + speed_bird_solo + Global.speeds_birds_dop
		if kakoe_apple_spawn == 2 or (Bird_v_straxe == true and kakoe_apple_spawn == 5): #если птица с яблоком скорости или в страхе
			velocity.x = 300 + speed_bird_solo + Global.speeds_birds_dop
	else:
		$TP_bird/CollisionShape2D.position = Vector2 (-99,-2)
		$CollisionShape2D.position = Vector2 (-21,-1)
		if not kakoe_apple_spawn == 2: #если птица не с яблоком скорости
			velocity.x = (150 + speed_bird_solo + Global.speeds_birds_dop) * (-1)
		if kakoe_apple_spawn == 2 or (Bird_v_straxe == true and kakoe_apple_spawn == 5): #если птица с яблоком скорости
			velocity.x = (300 + speed_bird_solo + Global.speeds_birds_dop) * (-1)
		
	#Перемещение птицы вверх и вниз
	if Deas_bird == false: #если птица ещё жива
		if not kakoe_apple_spawn == 3 and Bird_v_straxe == false: #Если нет яблока прыгучести и птица не в страхе
			if povishenie_visoty == 1: #птица летит выше
				velocity.y = - 80
			if povishenie_visoty == -1: #птица летит ниже
				velocity.y = 80
		if kakoe_apple_spawn == 3 and $".".position <= Vector2(posi.x,80):
			povishenie_visoty = 0
			velocity.y = 0
			vzletaet = false
			$"на повышение или понижение высоты".stop()
	
	# если начался ветер и птица без защиты (но может быть с яблоком защиты)
	if not Global.tree == 0 and deaf_life_birds == false: #если дует ветер и нет щита у птицы, то они взлетают высоко
		Deas_bird = true #заставляет улететь птицу
		$"на повышение или понижение высоты".stop()	#останавливается таймер полета вверх и вниз
		velocity.y = - 200 # скорость птицы на повышение
	
	if Global.tree == 0 and deaf_life_birds == false and Deas_bird == true: #если птиц поймала яблоко гнилое
		$"на повышение или понижение высоты".stop()	#останавливается таймер полета вверх и вниз
		velocity.y = - 200 # скорость птицы на повышение
		
	 
func anim_bird(): #анимация птицы
			if kakoe_apple_spawn == -1: #с гнилым яблоком
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_-1R")
				else:
					anim.play("polet_bird_-1L")
			if kakoe_apple_spawn == 0: #без яблока
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_0R")
				else:
					anim.play("polet_bird_0L")
			if kakoe_apple_spawn == 1: #с обычным яблоком
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_1R")
				else:
					anim.play("polet_bird_1L")
			if kakoe_apple_spawn == 2: #с яблоком скорости
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_2R")
				else:
					anim.play("polet_bird_2L")
			if kakoe_apple_spawn == 3: #с яблоком прыгучести
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_3R")
				else:
					anim.play("polet_bird_3L")
			if kakoe_apple_spawn == 4: #с яблоком защиты
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_4R")
				else:
					anim.play("polet_bird_4L")
			if kakoe_apple_spawn == 5: #с золотым яблоком
				if napravlenie_bird_solo == 1:
					anim.play("polet_bird_5R")
				else:
					anim.play("polet_bird_5L")
	

#перемещение из одного края в другой
func _on_tp_bird_body_entered(body):
	if body.name == "tp_left":
		var spawn_bird = Vector2 (1200,position.y) #Телепорт
		position = spawn_bird
	if body.name == "tp_right":
		var spawn_bird = Vector2 (20,position.y) #Телепорт
		position = spawn_bird



#таймер чтобы птица летала то вниз то вверх
func _on_на_повышение_или_понижение_высоты_timeout() -> void:
	if povishenie_visoty == 1: #сменяет положение полета на противоположное
		povishenie_visoty = -1
	else:
		povishenie_visoty = 1
	rand = randi_range(1,3)
	$"на повышение или понижение высоты".set_wait_time(rand)
	$"на повышение или понижение высоты".start()

#птицы летают в зоне
func _on_повышение_и_понижение_тригер_body_entered(body) -> void:
	if body.name == "Зона полета_вниз" and Deas_bird == false and vzletaet == false:
		$"на повышение или понижение высоты".stop()	
		povishenie_visoty = -1
		rand = randi_range(2,4)
		$"на повышение или понижение высоты".set_wait_time(rand)
		$"на повышение или понижение высоты".start()
	if body.name == "Зона полета_вверх" and Deas_bird == false and vzletaet == false:
		$"на повышение или понижение высоты".stop()	
		povishenie_visoty = 1
		rand = randi_range(2,4)
		$"на повышение или понижение высоты".set_wait_time(rand)
		$"на повышение или понижение высоты".start()
	if body.name == "Зона уничтожения птиц":
		Global.nomer_bird -= 1
		queue_free()

func _on_area_2d_body_entered(body):
	#Если у птицы есть яблоко и игрок пытается его забрать у неё.
	if body.name == "head" and apple_u_bird == true:
		if kakoe_apple_spawn == 1:
			#бонусы от обычного яблока
			Global.common_apple += 1
			Global.score += 1
			Global.very_score += 1
			Global.chet += 1
			Global.gold += 1
			if Global.musek_efect == true:
				Global.plus_ochki = true
			#убирает у птицы яблоко
			apple_u_bird = false
			kakoe_apple_spawn = 0
		if kakoe_apple_spawn == 2:
			#бонусы от обычного яблока
			Global.speed_stats += 1
			Global.baf_skor_apple = 200 # скорость героя увеличивается на 200
				
			Global.baf_SPEED = true #получил баф
				
			Global.score += 1
			Global.very_score += 1
			Global.chet += 1
			Global.gold += 1
			if Global.musek_efect == true:
				Global.plus_speed = true
			#убирает у птицы яблоко
			apple_u_bird = false
			kakoe_apple_spawn = 0
		if kakoe_apple_spawn == 3:
			$"на повышение или понижение высоты".stop()
			if napravlenie_bird_solo == 1:
				if $".".position > Vector2(posi.x,280):
					povishenie_visoty = -1
					vzletaet = false
				if $".".position < Vector2(posi.x,280):
					povishenie_visoty = 1
					vzletaet = true
			if napravlenie_bird_solo == -1:	
				if $".".position > Vector2(posi.x,280):
					povishenie_visoty = 1
					vzletaet = true
				if $".".position < Vector2(posi.x,280):
					povishenie_visoty = -1
					vzletaet = false
			#бонусы от обычного яблока
			Global.jump_stats += 1
			Global.baf_jump_apple = -200
				
			Global.baf_JUMP = true #получил баф
				
			Global.score += 1
			Global.very_score += 1
			Global.chet += 1
			Global.gold += 1
			if Global.musek_efect == true:
				Global.plus_jump = true
			#убирает у птицы яблоко
			apple_u_bird = false
			kakoe_apple_spawn = 0
			
		if kakoe_apple_spawn == 4:
			if deaf_life_birds == true:
				deaf_life_birds = false #у птицы нет щита
				$"3 сек яблоко нельзя брать".start()
				print ("таймер 3 сек")
				$Shield/shieldss.play("-щит")
				mozno_vzat_apple_u_berd = false
				if Global.musek_efect == true:
					Global.def_brok = true
			if mozno_vzat_apple_u_berd == true: #гг приземлился на землю и теперь ему можно забрать яблоко дефа
				mozno_vzat_apple_u_berd = false
				#бонусы от обычного яблока
				Global.def_stats += 1
				Global.deaf +=1
				if Global.deaf == 1:
					if Global.musek_efect == true:
						Global.plus_def1 = true
					Global.score += 1
					Global.very_score += 1
					Global.chet += 1
					Global.gold += 1
				if Global.deaf == 2:
						print ("собрал 2 дефа")
						if Global.musek_efect == true:
							if Global.HP == Global.HP_MAX:
								Global.plus_def2 = true
						if Global.HP == Global.HP_MAX:
							Global.score += 3
							Global.very_score += 3
							Global.chet += 3
							Global.gold += 3
						if Global.HP < Global.HP_MAX:
							Global.heal = true
							Global.HP += 1
							Global.score += 1
							Global.very_score += 1
							Global.chet += 1
							Global.gold += 1
						Global.deaf = 0
				#убирает у птицы яблоко
				apple_u_bird = false
				kakoe_apple_spawn = 0
		if kakoe_apple_spawn == 5:
			#бонусы от обычного яблока
			Global.gold_stats += 1
			if Global.HP != Global.HP_MAX:
				Global.score += 4
				Global.very_score += 4
				Global.chet += 4
				Global.gold += 4
			if Global.HP == Global.HP_MAX:
				Global.score += 8
				Global.very_score += 8
				Global.chet += 8
				Global.gold += 8
				if Global.musek_efect == true:
					Global.plus_gold = true
			#Функция яблока жизни
			if Global.HP < Global.HP_MAX:
				Global.heal = true
				Global.HP += 1
			#убирает у птицы яблоко
			apple_u_bird = false
			kakoe_apple_spawn = 0
				
		#Увеличивает рекордные очки		
		if (Global.score > Global.hi_score):
			Global.hi_score = Global.score			
			
	if body.name == "зона, от которой птица улетает" and kakoe_apple_spawn == 5:
		$"на повышение или понижение высоты".stop()	
		Bird_v_straxe = true
		if Global.smotru == "left":
			napravlenie_bird_solo = -1
		if Global.smotru == "right":
			napravlenie_bird_solo = 1
		velocity.y = - 60
					
func _on_area_2d_body_exited(body):
	if body.name == "зона, от которой птица улетает":
		Bird_v_straxe = false
		$"на повышение или понижение высоты".start()	
			

#по истечению времени позводляет гг взять яблоко защиты у птицы
func _on__сек_яблоко_нельзя_брать_timeout() -> void:
	mozno_vzat_apple_u_berd = true




func _on_полет_вниз_после_потери_яблока_прыгучести_timeout() -> void:
	vzletaet = false
	rand = randi_range(1,3)
	$"на повышение или понижение высоты".set_wait_time(rand)
	$"на повышение или понижение высоты".start()
	


func _on_area_2d_area_entered(area):
	# Если у птицы нет яблока, то она только тогда может словить новое	
	if area.name == "death1" and kakoe_apple_spawn == 0: #птица поймала простое яблоко
			if nemozet_lovit_posle_sbrosa == false:
				kakoe_apple_spawn = 1
				apple_u_bird = true
			else:
				kakoe_apple_spawn = 0
				vse_eshe_lovit1 = true #если птица не может ловить яблоко, но оно всё с ней рядом
	if area.name == "death2" and kakoe_apple_spawn == 0: #птица поймала яблоко скорости
			if nemozet_lovit_posle_sbrosa == false:
				kakoe_apple_spawn = 2
				apple_u_bird = true
			else:
				kakoe_apple_spawn = 0
				vse_eshe_lovit2 = true #если птица не может ловить яблоко, но оно всё с ней рядом
	if area.name == "death3" and kakoe_apple_spawn == 0: #птица поймала яблоко прыгучести
			if nemozet_lovit_posle_sbrosa == false:
				kakoe_apple_spawn = 3
				apple_u_bird = true
				vzletaet = true #взлетает птица вверх
				$"на повышение или понижение высоты".stop()
				velocity.y = - 100
			else:
				kakoe_apple_spawn = 0
				vse_eshe_lovit3 = true #если птица не может ловить яблоко, но оно всё с ней рядом
	if area.name == "death4" and kakoe_apple_spawn == 0: #птица поймала яблоко защиты
			if nemozet_lovit_posle_sbrosa == false:
				kakoe_apple_spawn = 4
				apple_u_bird = true
				deaf_life_birds = true #щит включен
				mozno_vzat_apple_u_berd = false
				$Shield/shieldss.play("+щит")
			else:
				kakoe_apple_spawn = 0
				vse_eshe_lovit4 = true #если птица не может ловить яблоко, но оно всё с ней рядом
	if area.name == "death5" and kakoe_apple_spawn == 0: #птица поймала золотое яблоко
			if nemozet_lovit_posle_sbrosa == false:
				kakoe_apple_spawn = 5
				apple_u_bird = true
			else:
				kakoe_apple_spawn = 0
				vse_eshe_lovit5 = true #если птица не может ловить яблоко, но оно всё с ней рядом
	if area.name == "death00" and kakoe_apple_spawn == 0 and nemozet_lovit_posle_sbrosa == false: #птица поймала плохое яблоко
			kakoe_apple_spawn = -1 
			#получил за это очки
			Global.score += 1
			Global.very_score += 1
			Global.chet += 1
			Global.gold += 1
			if Global.musek_efect == true: #звук + очков
				Global.plus_ochki = true
			#Увеличивает рекордные очки
			if (Global.score > Global.hi_score):
				Global.hi_score = Global.score
			Deas_bird = true #птица заканчивает свои действия на карте
			apple_u_bird = true
			
	if area.name == "зона сброса яблок" and apple_u_bird == true and not kakoe_apple_spawn == -1 and Global.tree == 0: #птица коснуласб зоны сброса яблока и если сейчас нет ветра, если у птицы не гнилое яблоко и если у птицы вообще есть яблоко.
		if randf() < 0.2: #20% что птица сбросит яблоко, когда попадет в зону сброса яблок
			var posi_one = $".".get_position()
			if Global.nomer_bird == 1:
				Global.zaspawn_apple_one = kakoe_apple_spawn #передает значение какое яблоко заспавнить
				Global.koordinati_one = posi_one #передает координаты птицы, где заспавнить яблоко
				Global.spawn_mozno_one = true
			if Global.nomer_bird == 2:
				Global.zaspawn_apple_two = kakoe_apple_spawn #передает значение какое яблоко заспавнить
				Global.koordinati_two = posi_one #передает координаты птицы, где заспавнить яблоко
				Global.spawn_mozno_two = true
			if Global.nomer_bird == 3:
				Global.zaspawn_apple_three = kakoe_apple_spawn #передает значение какое яблоко заспавнить
				Global.koordinati_three = posi_one #передает координаты птицы, где заспавнить яблоко
				Global.spawn_mozno_three = true
			if Global.nomer_bird == 4:
				Global.zaspawn_apple_four = kakoe_apple_spawn #передает значение какое яблоко заспавнить
				Global.koordinati_four = posi_one #передает координаты птицы, где заспавнить яблоко
				Global.spawn_mozno_four = true
			if Global.nomer_bird == 5:
				Global.zaspawn_apple_five = kakoe_apple_spawn #передает значение какое яблоко заспавнить
				Global.koordinati_five = posi_one #передает координаты птицы, где заспавнить яблоко
				Global.spawn_mozno_five = true
				
			if kakoe_apple_spawn == 3:
				$"на повышение или понижение высоты".stop()
				if napravlenie_bird_solo == 1:
					if $".".position > Vector2(posi.x,280):
						povishenie_visoty = -1
						vzletaet = false
					if $".".position < Vector2(posi.x,280):
						povishenie_visoty = 1
						vzletaet = true
				if napravlenie_bird_solo == -1:	
					if $".".position > Vector2(posi.x,280):
						povishenie_visoty = 1
						vzletaet = true
					if $".".position < Vector2(posi.x,280):
						povishenie_visoty = -1
						vzletaet = false
			$"Птица сбросила яблоко и пока она не может ловить другие".start()
			nemozet_lovit_posle_sbrosa = true
			apple_u_bird = false
			if kakoe_apple_spawn == 4:
				if deaf_life_birds == true:
					$Shield/shieldss.play("-щит")
					deaf_life_birds = false #щит выключен
			kakoe_apple_spawn = 0	


func _on_птица_сбросила_яблоко_и_пока_она_не_может_ловить_другие_timeout() -> void:
	nemozet_lovit_posle_sbrosa = false
	if vse_eshe_lovit1 == true:
		vse_eshe_lovit1 = false
		apple_u_bird = true
		kakoe_apple_spawn = 1	
		


func _on_area_2d_area_exited(_area):
	if vse_eshe_lovit1 == true:
		vse_eshe_lovit1 = false
	if vse_eshe_lovit2 == true:
		vse_eshe_lovit2 = false
	if vse_eshe_lovit3 == true:
		vse_eshe_lovit3 = false
	if vse_eshe_lovit4 == true:
		vse_eshe_lovit4 = false
	if vse_eshe_lovit5 == true:
		vse_eshe_lovit5 = false
