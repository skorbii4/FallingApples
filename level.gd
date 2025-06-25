extends Node2D

var rand_spawn_apple
var rand_spawn_ezhik

var posi
var ezh = 0 #сколько раз выполнится цикл
@onready var timer_ezh_two = $spawn_ezh

var time_pad_apple = 2.5 #через 2.5 cек падает след яблоко
var koordinati_tp_korz = 0 #телепортирует корзинку на координаты на противоположную сторону
var timer = false #таймер на спавн птиц
var prost_i = 0 #обычный счетсчик для цикла спавна птиц

func _ready() -> void:
	Global.gde_i_shas = "lvl"
	Bridge.platform.send_message("gameplay_started")
	Global.lvl.play()
	
	
	if Global.batsh >= 1 and Global.rezhim_yach == 1: #спавн батут(сделать на 1 чтобы заработало)
		var bat_polozh = Global.batutiks.instantiate()
		var randomizh
		if randf() < 0.5: 
			randomizh = randi_range(100,300)
		else:
			randomizh = randi_range(800,1000)
		bat_polozh.position = Vector2 (randomizh,500)
		add_child(bat_polozh)
		Global.bat_spawn = false
	Global.kol_vo_nazati_korz = 0 #изначально 0 нажатий на корзинке
	
	#спавн 1 яблока			
	var apple_spawni = Global.applez.instantiate()
	rand_spawn_apple = randi_range(45,1110)
	apple_spawni.position = Vector2 (rand_spawn_apple,-100)
	add_child(apple_spawni)
	
	var player_spawni = Global.player.instantiate()
	player_spawni.position = Vector2 (584,555)
	add_child(player_spawni)
	
	Global.skorostapple = 120 #обновляет скорость яблок в начале уровня
	Global.bird_spawn = false
	
func _process(delta: float) -> void:
	
	menaetsa_polozh_korz() #меняется положение корзинки
	vse_o_ezhike()#спавн ёжика
	vse_o_bird()#спавн птицы
	ysloznenie() #усложнение
	if Global.spawn_2_ezhika_eshe == true:
		Global.spawn_2_ezhika_eshe = false
		if ezh < 2:
			timer_ezh_two.start()
		else:
			ezh = 0
			timer_ezh_two.stop()
			return
	
func _on_set_score_completed(success): #функция записи в лидерборд
	print(success)

#спавнит яблоки	(% яблока разделить на остаток числа от 100 = получиться ответ randf)
func spawn_one_apple():
	if randf() < 0.5: # 50% что яблоко упадет хорошее
		var apple_spawni = Global.applez.instantiate()
		rand_spawn_apple = randi_range(45,1110)
		apple_spawni.position = Vector2 (rand_spawn_apple,-100)
		add_child(apple_spawni)
	else:
		if randf() < 0.4: # 25% что яблоко упадет плохое 
			var apple_spawni = Global.apple_beds.instantiate()
			rand_spawn_apple = randi_range(45,1110)
			apple_spawni.position = Vector2 (rand_spawn_apple,-100)
			add_child(apple_spawni)
		else:
			if randf() < 0.32: # 8% что яблоко упадет Скорости
				var apple_spawni = Global.apple_runs.instantiate()
				rand_spawn_apple = randi_range(45,1110)
				apple_spawni.position = Vector2 (rand_spawn_apple,-100)
				add_child(apple_spawni)
			else:
				if randf() < 0.47: # 8% что яблоко упадет Прыгучести
					var apple_spawni = Global.apple_jumps.instantiate()
					rand_spawn_apple = randi_range(45,1110)
					apple_spawni.position = Vector2 (rand_spawn_apple,-100)
					add_child(apple_spawni)
				else:
					if randf() < 0.55: # 5% что яблоко упадет Защиты
						var apple_spawni = Global.apple_deafs.instantiate()
						rand_spawn_apple = randi_range(45,1110)
						apple_spawni.position = Vector2 (rand_spawn_apple,-100)
						add_child(apple_spawni)
					else: # 4% что яблоко упадет Золотое
						var apple_spawni = Global.apple_golds.instantiate()
						rand_spawn_apple = randi_range(45,1110)
						apple_spawni.position = Vector2 (rand_spawn_apple,-100)
						add_child(apple_spawni)

#сюда прописывать усложнения
func ysloznenie():
	if Global.chet >= 10 + Global.hard:
		Global.chet -= 10 + Global.hard
		
		# Здесь прописывать усложнения
		if Global.skorostapple < 200: #Скорость падения яблок увеличивается на 6 пока не достигнет скорости 300
			Global.skorostapple += 3
		if time_pad_apple > 1.5: #Скорость падения яблок будет уменьшаться до тех пор, пока не будет скорость между падениями 2 сек
			time_pad_apple -= 0.02
		if Global.speeds_sonikx < 75: #Доп Скорость ёжика увеличивается на 1 до 75 максимум
			Global.speeds_sonikx += 1
		if Global.speeds_birds_dop < 75: #Доп Скорость птицы увеличивается на 1 до 75 максимум
			Global.speeds_birds_dop += 1
			
		print ("Усложнение")
		
#когда коснулось зоны спавна яблоко - запускается таймер на новое яблоко
func _on_спавн_яблок_body_entered(body):
	if body.name == "apple_bed" or body.name == "apple" or body.name == "apple_jump" or body.name == "apple_run" or body.name == "apple_def" or body.name == "apple_gold":
		$"спавн яблок/Timer".set_wait_time(time_pad_apple)
		$"спавн яблок/Timer".start()
	
#спавн нового яблока	
func _on_timer_timeout():
	spawn_one_apple()

	
#окончание таймера на спавн ёжика	
func _on_spawn_ezh_timeout():
	var ezh_spawn = Global.ezhik.instantiate()
	if Global.speed_ezh == 1:
		ezh_spawn.position = Vector2 (-25,580)
	else:
		ezh_spawn.position = Vector2 (1227,580)
	if Global.tree == 0:
		Global.ezhik_smex_gold_apple = true #смех ёжика
		add_child(ezh_spawn)
		Global.spawn_2_ezhika_eshe = true
		ezh += 1


func menaetsa_polozh_korz(): #меняется положение корзинки
	if Input.is_action_just_pressed("бросить корзинку") and Global.korzsh >= 1 and Global.bros == true and Global.korz_na_golove == 0: #если купил, то спавн корзинки
			Global.kol_vo_nazati_korz += 1
			if Global.kol_vo_nazati_korz == 2:
				if Global.bros == true: #спавн корзинки
					Global.bros = false
					var korz_polozh = Global.korzinkas.instantiate()
					posi = $player.get_position()
					Global.bros_dla_int = true
					if Global.smotru == "left":
						korz_polozh.position = Vector2 (posi.x - 241 + koordinati_tp_korz, 570)
					if Global.smotru == "right":
						korz_polozh.position = Vector2 (posi.x + 259 + koordinati_tp_korz, 570)
					add_child(korz_polozh)
					$KorzDl.visible = false #выключает временную корзинку
					Global.zadat_skor = true
					Global.kol_vo_nazati_korz = 0
					Global.one_raz_korz = true
					
	if Global.kol_vo_nazati_korz == 1 and Global.bros == true: #чтобы в реал лайф показывать куда может заспавнится корзинка
		$KorzDl.visible = true
		var korz_polozh = Global.korzinkas.instantiate()
		posi = $player.get_position()
		if Global.smotru == "left":
			$KorzDl.position = Vector2 (posi.x -250 + koordinati_tp_korz, 567)
		if Global.smotru == "right":
			$KorzDl.position = Vector2 (posi.x +250 + koordinati_tp_korz, 567)
		if Global.one_raz_korz == true:
			$isceznet_vremen_korz.start()
			Global.one_raz_korz = false
	if Global.kol_vo_nazati_korz == 0:
		$KorzDl.visible = false
	
	if Global.tp_korz_left == true:
		if Global.smotru == "left":
			koordinati_tp_korz = 1230
		else:
			koordinati_tp_korz = 0
	if Global.tp_korz_right == true:
		if Global.smotru == "right":
			koordinati_tp_korz = -1225
		else:
			koordinati_tp_korz = 0
	if Global.tp_korz_left == false and Global.tp_korz_right == false:
		koordinati_tp_korz = 0
		
func _on_isceznet_vremen_korz_timeout(): #таймер на временную корзинку (5 сек)
	Global.kol_vo_nazati_korz = 0
	$KorzDl.visible = false 

#координаты для корзинки когда телепортируюсь
func _on_корзинка_тп_л_body_entered(body):
	Global.tp_korz_left = true
func _on_корзинка_тп_л_body_exited(body):
	Global.tp_korz_left = false
	koordinati_tp_korz = 0
func _on_корзинка_тп_л2_body_entered(body):
	Global.tp_korz_right = true
func _on_корзинка_тп_л2_body_exited(body):
	Global.tp_korz_right = false
	koordinati_tp_korz = 0

#спавн ёжика
func vse_o_ezhike():
	var ezh_spawn = Global.ezhik.instantiate()
	if Global.ezhik_spawn == true:
		if randf() < 0.5:
			Global.speed_ezh = 1
			ezh_spawn.position = Vector2 (-25,580)
		else:
			Global.speed_ezh = -1
			ezh_spawn.position = Vector2 (1227,580)
			
		add_child(ezh_spawn)
		#определяет какой заспавнится ёжик		
		if randf() < 0.45: # 45% что ёжик заспавнится с чистой спинкой
			Global.polozhenie_ezhika = 0
			Global.deaf_live_ezhik = 0
			Global.ezhik_spawn = false
			return
		else:
			if randf() < 0.45: # 25% что ёжик заспавнится с простым яблоком
				Global.polozhenie_ezhika = 1 
				Global.deaf_live_ezhik = 0
				Global.ezhik_spawn = false
				return
			else:
				if randf() < 0.25: # 10% что ёжик заспавнится с яблоком скорости
					Global.polozhenie_ezhika = 2 
					Global.deaf_live_ezhik = 0
					Global.ezhik_spawn = false
					return
				else:
					if randf() < 0.33: # 10% что ёжик заспавнится с яблоком прыгучести
						Global.polozhenie_ezhika = 3 
						Global.deaf_live_ezhik = 0
						Global.ezhik_spawn = false
						return
					else:
						if randf() < 0.6: # 6% что ёжик заспавнится с яблоком защиты
							Global.polozhenie_ezhika = 4
							Global.deaf_live_ezhik = 1 # активирует щит ёжика
							Global.ezhik_spawn = false
							return
						else:		
							Global.polozhenie_ezhika = 5 # 4% что ёжик заспавнится с золотым яблоком
							Global.deaf_live_ezhik = 0
							Global.ezhik_smex_gold_apple = true #смех ёжика
							Global.ezhik_spawn = false
							Global.spawn_2_ezhika_eshe = true
							return

#спавн птицы
func vse_o_bird():
	if Global.bird_spawn == true and prost_i <= Global.schet_bird and Global.nomer_bird < 5:
		if timer == false:
			timer = true
			prost_i += 1
			var random = randi_range(2,5)
			$Timer_na_spanw_bird.set_wait_time(random)
			$Timer_na_spanw_bird.start()
			
			#спавн с определенным яблоком	
			if randf() < 0.7: # 70% что птица заспавнится с обычным яблоком
				Global.polozhenie_bird = 1
				konkretn_bird()
			else:
				if randf() < 0.3:# 10% что птица заспавнится с яблоком скорости
					Global.polozhenie_bird = 2
					konkretn_bird()
				else:
					if randf() < 0.5:# 10% что птица заспавнится с яблоком прыгучести
						Global.polozhenie_bird = 3
						konkretn_bird()
					else:
						if randf() < 0.6:# 6% что птица заспавнится с яблоком защиты
							Global.polozhenie_bird = 4
							konkretn_bird()
						else:# 4% что птица заспавнится с золотым яблоком
							Global.polozhenie_bird = 5
							konkretn_bird()
	else:
		Global.bird_spawn = false #выключает возможность спавна
		Global.schet_bird = 0 #перестает спавнить птиц
		prost_i = 0 #счетчик для спавна снова равен 0

func konkretn_bird():#определяет с каким яблоком заспавнить птицу
	var bird_spawn
	if randf() < 0.5:
		bird_spawn = Global.bird1.instantiate()
		Global.napravlenie_bird = 1
		var rand
		if not Global.polozhenie_bird == 3:
			rand = randi_range(160,400)
		else:
			rand = 80
		bird_spawn.position = Vector2 (50,rand)
		add_child(bird_spawn)	
	else:
		bird_spawn = Global.bird1.instantiate()
		Global.napravlenie_bird = -1
		var rand
		if not Global.polozhenie_bird == 3:
			rand = randi_range(160,400)
		else:
			rand = 80
		bird_spawn.position = Vector2 (1100,rand)
		add_child(bird_spawn)	
		
func _on_timer_na_spanw_bird_timeout():
	timer = false

		

#как только птица оказалась с зоне сброса яблок
func _on_зона_сброса_яблок_area_entered(area):
	if Global.nomer_bird == 1:
		$"зона сброса яблок/one".start()
	if Global.nomer_bird == 2:
		$"зона сброса яблок/one2".start()
	if Global.nomer_bird == 3:
		$"зона сброса яблок/one3".start()
	if Global.nomer_bird == 4:
		$"зона сброса яблок/one4".start()
	if Global.nomer_bird == 5:
		$"зона сброса яблок/one5".start()

#спавнит яблоки
func _on_one_timeout():
	var apple_spawni
	if Global.zaspawn_apple_one == 1 and Global.spawn_mozno_one == true:
		apple_spawni = Global.applez.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_one.x,Global.koordinati_one.y)
	if Global.zaspawn_apple_one == 2 and Global.spawn_mozno_one == true:
		apple_spawni = Global.apple_runs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_one.x,Global.koordinati_one.y)
	if Global.zaspawn_apple_one == 3 and Global.spawn_mozno_one == true:
		apple_spawni = Global.apple_jumps.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_one.x,Global.koordinati_one.y)
	if Global.zaspawn_apple_one == 4 and Global.spawn_mozno_one == true:
		apple_spawni = Global.apple_deafs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_one.x,Global.koordinati_one.y)
	if Global.zaspawn_apple_one == 5 and Global.spawn_mozno_one == true:
		apple_spawni = Global.apple_golds.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_one.x,Global.koordinati_one.y)
	Global.spawn_mozno_one = false
	add_child(apple_spawni)
func _on_one_2_timeout():
	var apple_spawni
	if Global.zaspawn_apple_two == 1 and Global.spawn_mozno_two == true:
		apple_spawni = Global.applez.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_two.x,Global.koordinati_two.y)
	if Global.zaspawn_apple_two == 2 and Global.spawn_mozno_two == true:
		apple_spawni = Global.apple_runs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_two.x,Global.koordinati_two.y)
	if Global.zaspawn_apple_two == 3 and Global.spawn_mozno_two == true:
		apple_spawni = Global.apple_jumps.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_two.x,Global.koordinati_two.y)
	if Global.zaspawn_apple_two == 4 and Global.spawn_mozno_two == true:
		apple_spawni = Global.apple_deafs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_two.x,Global.koordinati_two.y)
	if Global.zaspawn_apple_two == 5 and Global.spawn_mozno_two == true:
		apple_spawni = Global.apple_golds.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_two.x,Global.koordinati_two.y)
	Global.spawn_mozno_two = false
	add_child(apple_spawni)
func _on_one_3_timeout():
	var apple_spawni
	if Global.zaspawn_apple_three == 1 and Global.spawn_mozno_three == true:
		apple_spawni = Global.applez.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_three.x,Global.koordinati_three.y)
	if Global.zaspawn_apple_three == 2 and Global.spawn_mozno_three == true:
		apple_spawni = Global.apple_runs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_three.x,Global.koordinati_three.y)
	if Global.zaspawn_apple_three == 3 and Global.spawn_mozno_three == true:
		apple_spawni = Global.apple_jumps.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_three.x,Global.koordinati_three.y)
	if Global.zaspawn_apple_three == 4 and Global.spawn_mozno_three == true:
		apple_spawni = Global.apple_deafs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_three.x,Global.koordinati_three.y)
	if Global.zaspawn_apple_three == 5 and Global.spawn_mozno_three == true:
		apple_spawni = Global.apple_golds.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_three.x,Global.koordinati_three.y)
	Global.spawn_mozno_three = false
	add_child(apple_spawni)
func _on_one_4_timeout():
	var apple_spawni
	if Global.zaspawn_apple_four == 1 and Global.spawn_mozno_four == true:
		apple_spawni = Global.applez.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_four.x,Global.koordinati_four.y)
	if Global.zaspawn_apple_four == 2 and Global.spawn_mozno_four == true:
		apple_spawni = Global.apple_runs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_four.x,Global.koordinati_four.y)
	if Global.zaspawn_apple_four == 3 and Global.spawn_mozno_four == true:
		apple_spawni = Global.apple_jumps.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_four.x,Global.koordinati_four.y)
	if Global.zaspawn_apple_four == 4 and Global.spawn_mozno_four == true:
		apple_spawni = Global.apple_deafs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_four.x,Global.koordinati_four.y)
	if Global.zaspawn_apple_four == 5 and Global.spawn_mozno_four == true:
		apple_spawni = Global.apple_golds.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_four.x,Global.koordinati_four.y)
	Global.spawn_mozno_four = false
	add_child(apple_spawni)
func _on_one_5_timeout():
	var apple_spawni
	if Global.zaspawn_apple_five == 1 and Global.spawn_mozno_five == true:
		apple_spawni = Global.applez.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_five.x,Global.koordinati_five.y)
	if Global.zaspawn_apple_five == 2 and Global.spawn_mozno_five == true:
		apple_spawni = Global.apple_runs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_five.x,Global.koordinati_five.y)
	if Global.zaspawn_apple_five == 3 and Global.spawn_mozno_five == true:
		apple_spawni = Global.apple_jumps.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_five.x,Global.koordinati_five.y)
	if Global.zaspawn_apple_five == 4 and Global.spawn_mozno_five == true:
		apple_spawni = Global.apple_deafs.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_five.x,Global.koordinati_five.y)
	if Global.zaspawn_apple_five == 5 and Global.spawn_mozno_five == true:
		apple_spawni = Global.apple_golds.instantiate()
		apple_spawni.position = Vector2 (Global.koordinati_five.x,Global.koordinati_five.y)
	Global.spawn_mozno_five = false
	add_child(apple_spawni)
