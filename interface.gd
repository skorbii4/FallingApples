extends Node2D


@onready var HP_1 = $hp_1
@onready var HP_2 = $hp_2
@onready var HP_3 = $hp_3
@onready var HP_4 = $hp_4
@onready var HP_5 = $hp_5
@onready var HP_6 = $hp_6

var vrash = false #вращение рестарта

var animats = false #анимация для рекламы
var animats2 = false #анимация только для здоровья

var TIMER_SPEED = 0
var timer_speed

var TIMER_JUMP = 0
var timer_jump

var TIMER_JUMPx2 = 0
var timer_jumpx2

var TIMER_korz = 0
var timer_korz

var TIMER_rivok = 0
var timer_rivok

var TIMER_neuaz = 0
var timer_neuaz

var TIMER_veter = 0
var timer_veter

var deaf_bafs = false #нужно, чтоб яблоко защиты посчитал 1 рах за баф

var deaf_position = 0
var jump_position = 0
var speed_position = 0
var neuazvimost_position = 0
var veter_position = 0

@onready var muz = $lvl

@onready var chetik = $CanvasLayer/chetik
@onready var gold = $CanvasLayer/gold
@onready var record = $CanvasLayer/record
@onready var korz = $CanvasLayer/Mobil_buttons/korz
@onready var rivok = $CanvasLayer/Mobil_buttons/rivok
@onready var rivokoff =$CanvasLayer/Mobil_buttons/rivok2
@onready var bat =$CanvasLayer/Mobil_buttons/yachik

@onready var lvl_musek = $lvl

var rivoktrue = false #Рывок не нажат

var massiv = []
var nomerachia #номерует случайно подсказки во время паузы
var z = 0 #изначально для того, чтобы проходить по страницам

   
func _ready() -> void:
	Bridge.advertisement.connect("rewarded_state_changed", Callable(self, "_on_rewarded_state_changed"))
	otobr_hp() #отображает хп
	massiv_rand_podskazki()#сформировать массив подсказок, чтобы каждый раз рандомно отображались во время паузы
	podskazki() #всплывающие подсказки во время паузы
	ypravl_v_nachale_open()#если запускаю первый раз, то открывается "книга помощи" на вкладке "управление"
	
func _on_rewarded_state_changed(state):
	if Bridge.advertisement.rewarded_state == "opened":
		Global.paus = true
		animats = false
		print("Реклама открыта.")
	if Bridge.advertisement.rewarded_state == "closed":
		Global.reward_received = true #после просмотра рекламы
		print("Реклама закрыта пользователем.")
	if Bridge.advertisement.rewarded_state == "rewarded":
		Global.Nagrada_reklama = true #после просмотра рекламы
		print("Пользователь получил награду!")
	if Bridge.advertisement.rewarded_state == "failed":	
		Global.paus = true
		print("Произошла ошибка при показе рекламы.")
	
func _process(delta: float) -> void:
	# выводится текст статистики
	menaetsa_vo_vrema_game()#меняется во время игры, чтобы не нагружать process
	
	nagrada()#награда за просмотр рекламы
	
	deaf_effect_sboku() #эффект защиты от яблока
	speed_effect_sboku() #эффект скорости от яблока
	jump_effect_sboku() #эффект прыжка от яблока
	neuazvimost_effect_sboku() #эффект неуязвимости от потери хп
	verer_effect_sboku() #эффект ветра
	
	korz_timer_knopka() # обратный отчет 30 сек, чтоб можно было снова бросить корзинку
	rivok_timer_knopka() # обратный отчет, чтоб можно было снова нажать рывок
	dabl_jump_timer_knopka() # обратный отчет, чтоб можно было снова нажать двойной прыжок
	
	heal_anim() #анимация хила
	damage_anim() #анимация урона
	
	skrit_ikonki_menu() #иконки меню, скрывает и раскрывает
	
	knopka_tolk_yach() #всё связанное с кнопкой толкать ящик
	
	language() #текст меняется в зависимости от языка
	
	otobr_knopok() #скрывает и отображает корректно кнопки если пк или мобилка
	
	respawn_f() #функция появления за монеты
	
	podskazki() #всплывающие подсказки во время паузы
	
	if vrash == true:
		vrashi() #функция вращения рестарта
	
	if veter_position == 0 and neuazvimost_position == 0 and jump_position == 0 and deaf_position == 0 and speed_position == 0:	
		Global.kolvо_bafs = 0
	
	paus_game()#пауза во время игры
		

	

func _on_manu_pressed(): #нажал выйти в меню
	get_tree().paused = false
	Global.menuska = true
	Global.esc = false
	Global.GG_one_raz = true #Обновить отображение скина в главном меню
	Global.lvl.stop()
	Global.menu.play()
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_manu_2_pressed():
	get_tree().paused = false
	Global.menuska = true
	Global.esc = false
	Global.GG_one_raz = true #Обновить отображение скина в главном меню
	Global.lvl.stop()
	Global.menu.play()
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_musek_2_pressed():
	if Global.musek == false:
		$musek2/Musek.visible = true
		$musek2/Musek1.visible = false
		Global.musek = true
		Global.lvl.play()
	else:
		$musek2/Musek.visible = false
		$musek2/Musek1.visible = true
		Global.musek = false
		Global.lvl.stop()
		
func _on_musek_3_pressed():
	if Global.musek_efect == false:
		Global.musek_efect = true
		$musek3/EffectOn.visible = true
		$musek3/EffectOff.visible = false
		
	else:
		Global.musek_efect = false
		$musek3/EffectOn.visible = false
		$musek3/EffectOff.visible = true

func _on_esc_pressed():
	Global.paus = !Global.paus
	if Global.esc == false:
		Global.esc = true
		$esc/Esc2.visible = false
		$esc/Esc.visible = true
		
	else:
		Global.esc = false
		$esc/Esc2.visible = true
		$esc/Esc.visible = false

func _on_info_pressed():
	Global.info = ! Global.info
	if Global.info == true:
		Global.stranica = 1
		Global.razdel = "lvl"
		$info/Kniga.visible = false
		$info/Kniga2.visible = true
		var kniga_spawni = Global.kniga4.instantiate()
		kniga_spawni.position = Vector2 (0,0)
		add_child(kniga_spawni)
		$manu.visible = false
		$info.visible = false
		#$esc.visible = false
		$Pramougoln.visible = false
		$Podl.visible = false
		$Korz2.visible = false
		$Top2.visible = false
		$Koin.visible = false
		if Global.HP_MAX == 3:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
		if Global.HP_MAX == 4:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
		if Global.HP_MAX == 5:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
			HP_5.visible = false
			HP_6.visible = false
		if Global.HP_MAX == 6:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
			HP_5.visible = false
			HP_6.visible = false
		$CanvasLayer/Mobil_buttons.visible = false
		$CanvasLayer.visible = false
		$musek3.visible = false
		$musek2.visible = false
		$esc.visible = false
	else:
		$info/Kniga.visible = true
		$info/Kniga2.visible = false
		var child_node = $".".get_node("Книга4")
		child_node.queue_free()
		$manu.visible = true
		$info.visible = true
		$esc.visible = true
		$Pramougoln.visible = true
		$Podl.visible = true
		$Korz2.visible = true
		$Top2.visible = true
		$Koin.visible = true
		if Global.HP_MAX == 3:
			#отображает
			HP_1.visible = true
			HP_2.visible = true
			HP_3.visible = true
			#скрывает
			HP_4.visible = false
			HP_5.visible = false
			HP_6.visible= false
		if Global.HP_MAX == 4:
			#отображает
			HP_1.visible = true
			HP_2.visible = true
			HP_3.visible = true
			HP_4.visible = true
			#скрывает
			HP_5.visible = false
			HP_6.visible = false
		if Global.HP_MAX == 5:
			#отображает
			HP_1.visible = true
			HP_2.visible = true
			HP_3.visible = true
			HP_4.visible = true
			HP_5.visible = true
			#скрывает
			HP_6.visible = false
		if Global.HP_MAX == 6:
			#отображает
			HP_1.visible = true
			HP_2.visible = true
			HP_3.visible = true
			HP_4.visible = true
			HP_5.visible = true
			HP_6.visible = true
		$CanvasLayer/Mobil_buttons.visible = true
		$CanvasLayer.visible = true
		$musek3.visible = true
		$musek2.visible = true
		Global.paus = false
		Global.esc = false
		

func _on_rivok_timer_timeout():
	if TIMER_rivok == 1: #чтобы 0 не отображался на таймере
		$CanvasLayer/jump_rivok.visible = false
		TIMER_rivok -= 1
	else:
		TIMER_rivok -= 1
		$CanvasLayer/jump_rivok.text = str(TIMER_rivok)
	timer_rivok = false	

func _on_korz_timeout():
	if TIMER_korz == 1: #чтобы 0 не отображался на таймере
		$CanvasLayer/jump_korz.visible = false
		TIMER_korz -= 1
	else:
		TIMER_korz -= 1
		$CanvasLayer/jump_korz.text = str(TIMER_korz)
	timer_korz = false	

func _on_speed_timer_timeout():
	TIMER_SPEED -= 1
	if TIMER_SPEED > 0:
		$CanvasLayer/speed_ef.text = str(TIMER_SPEED)
	timer_speed = false
	if TIMER_SPEED == 0: #если таймер закончился
			$CanvasLayer/speed_ef.visible = false #чтобы 0 не отображался на таймере
			Global.baf_speed = false
			Global.baf_skor_apple = 0
			Global.kolvо_bafs -= 1
			if speed_position == 1: # если позиция скорости равна 1, то все смещаются
				deaf_position -= 1
				jump_position -= 1
				neuazvimost_position -= 1
				veter_position -= 1
			else:
				if speed_position <= deaf_position: #если позиция скорости меньше, чем защита
					deaf_position -= 1
				if speed_position <= jump_position: #если позиция скорости меньше, чем прыжок
					jump_position -= 1
				if speed_position <= neuazvimost_position: #если позиция скорости меньше, чем неуязвимость
					neuazvimost_position -= 1
				if speed_position <= veter_position: #если позиция скорости меньше, чем ветер
					veter_position -= 1
			speed_position = 0
			$SPEED_timer.stop()

func _on_jump_timer_timeout():
	TIMER_JUMP -= 1
	if TIMER_JUMP > 0:
		$CanvasLayer/jump_ef.text = str(TIMER_JUMP)
	timer_jump = false
	if TIMER_JUMP == -1: #если таймер закончился
			$CanvasLayer/jump_ef.visible = false #чтобы 0 не отображался на таймере
			Global.baf_jump = false
			Global.baf_jump_apple = 0
			Global.kolvо_bafs -= 1
			if jump_position == 1: # если позиция прыжка равна 1, то все смещаются
				deaf_position -= 1
				speed_position -= 1
				neuazvimost_position -= 1
				veter_position -= 1
			else:
				if jump_position <= deaf_position: #если позиция прыжка меньше, чем защита
					deaf_position -= 1
				if jump_position <= speed_position: #если позиция прыжка меньше, чем скорости
					jump_position -= 1
				if jump_position <= neuazvimost_position: #если позиция прыжка меньше, чем неуязвимость
					neuazvimost_position -= 1
				if jump_position <= veter_position: #если позиция прыжка меньше, чем ветер
					veter_position -= 1
			jump_position = 0
			$JUMP_timer.stop()

func _on_dabl_jamp_timer_timeout():
	if TIMER_JUMPx2 == 1: #чтобы 0 не отображался на таймере
		$CanvasLayer/jump_dabl.visible = false
		TIMER_JUMPx2 -= 1
	else:
		TIMER_JUMPx2 -= 1
		$CanvasLayer/jump_dabl.text = str(TIMER_JUMPx2)
	timer_jumpx2 = false

func _on_neuaz_timer_timeout():
	TIMER_neuaz -= 1
	if TIMER_neuaz > 0:
		$CanvasLayer/neuaz_ef.text = str(TIMER_neuaz)
	timer_neuaz = false
	if TIMER_neuaz == 0: #если таймер закончился
			$CanvasLayer/neuaz_ef.visible = false #чтобы 0 не отображался на таймере
			Global.kolvо_bafs -= 1
			if neuazvimost_position == 1: # если позиция неуязвимости равна 1, то все смещаются
				deaf_position -= 1
				jump_position -= 1
				speed_position -= 1
				veter_position -= 1
			else:
				if neuazvimost_position <= deaf_position: #если позиция неуязвимости меньше, чем защита
					deaf_position -= 1
				if neuazvimost_position <= jump_position: #если позиция неуязвимости меньше, чем прыжок
					jump_position -= 1
				if neuazvimost_position <= speed_position: #если позиция неуязвимости меньше, чем скорость
					speed_position -= 1
				if neuazvimost_position <= veter_position: #если позиция неуязвимости меньше, чем ветер
					veter_position -= 1
			neuazvimost_position = 0
			$neuaz_timer.stop()
			Global.block_dmg = false
			Global.poluch_dmg = false

func _on_veter_timer_timeout():
	TIMER_veter -= 1
	if TIMER_veter > 0:
		$CanvasLayer/veter_ef.text = str(TIMER_veter)
	timer_veter = false
	if TIMER_veter == 0: #если таймер закончился
			$CanvasLayer/veter_ef.visible = false  #чтобы 0 не отображался на таймере
			Global.kolvо_bafs -= 1
			if veter_position == 1: # если позиция ветра равна 1, то все смещаются
				deaf_position -= 1
				jump_position -= 1
				speed_position -= 1
				neuazvimost_position -= 1
			else:
				if veter_position <= deaf_position: #если позиция ветра меньше, чем защита
					deaf_position -= 1
				if veter_position <= jump_position: #если позиция ветра меньше, чем прыжок
					jump_position -= 1
				if veter_position <= speed_position: #если позиция ветра меньше, чем скорость
					speed_position -= 1
				if veter_position <= neuazvimost_position: #если позиция ветра меньше, чем неуязвимость
					neuazvimost_position -= 1
			veter_position = 0
			$veter_timer.stop()

func deaf_effect_sboku(): # эффект защиты от яблока
	if Global.deaf == 1 and deaf_bafs == false: #если я получил яблоко защиты до того, как оно уже у меня было
		deaf_bafs = true
		Global.kolvо_bafs += 1
		deaf_position = Global.kolvо_bafs
		
	if Global.kolvо_bafs < deaf_position: # Если вдруг кол-во бафов будет меньше, чем позиция в данный момент у защиты (баг)
		deaf_position = Global.kolvо_bafs	
		
		#позиция, в зависимости сколько бафов сейчас у ГГ	
	if deaf_position == 0:
			$CanvasLayer/DeafEf.visible = false
	if deaf_position == 1:
			$CanvasLayer/DeafEf.position = Vector2 (55,235)
			$CanvasLayer/DeafEf.visible = true
	if deaf_position == 2:
			$CanvasLayer/DeafEf.position = Vector2 (105,235)
			$CanvasLayer/DeafEf.visible = true
	if deaf_position == 3:
			$CanvasLayer/DeafEf.position = Vector2 (155,235)
			$CanvasLayer/DeafEf.visible = true
	if deaf_position == 4:
			$CanvasLayer/DeafEf.position = Vector2 (205,235)
			$CanvasLayer/DeafEf.visible = true
	if deaf_position == 5:
			$CanvasLayer/DeafEf.position = Vector2 (255,235)
			$CanvasLayer/DeafEf.visible = true
			
	if Global.deaf == 0 and deaf_bafs == true: #В момент, когда баф пропал
		deaf_bafs = false
		Global.kolvо_bafs -= 1
		if deaf_position == 1: # если позиция защиты равна 1, то все смещаются
			speed_position -= 1
			jump_position -= 1
			neuazvimost_position -= 1
			veter_position -= 1
		else:
			if deaf_position <= speed_position: #если позиция защиты меньше, чем скорость 
				speed_position -= 1
			if deaf_position <= jump_position: #если позиция защиты меньше, чем прыжок
				jump_position -= 1
			if deaf_position <= neuazvimost_position: #если позиция защиты меньше, чем неуязвимость
				neuazvimost_position -= 1
			if deaf_position <= veter_position: #если позиция защиты меньше, чем ветер
				veter_position -= 1
		deaf_position = 0
		
	
func speed_effect_sboku(): #эффект скорости от яблока
	
	if Global.baf_SPEED == true: # если я только получил яблоко скорости
		Global.baf_SPEED = false
		timer_speed = false
		TIMER_SPEED = 20
		if Global.baf_speed == false: #если яблоко уже активно, то не посчитает за новый баф
			Global.baf_speed = true
			Global.kolvо_bafs += 1
			speed_position = Global.kolvо_bafs #позиция считается в самый первый раз при появлении бафа
		$CanvasLayer/speed_ef.text = str(TIMER_SPEED)
		
	if Global.kolvо_bafs < speed_position: # Если вдруг кол-во бафов будет меньше, чем позиция в данный момент у скорости (баг)
		speed_position = Global.kolvо_bafs
		
	#позиции по время активных бафов
	if speed_position == 0:
			$CanvasLayer/SpeedEff.visible = false
			$CanvasLayer/speed_ef.visible = false
	if speed_position == 1:
			$CanvasLayer/SpeedEff.position = Vector2 (55,247)
			$CanvasLayer/SpeedEff.visible = true
			$CanvasLayer/speed_ef.position = Vector2 (41,247)
			$CanvasLayer/speed_ef.visible = true
	if speed_position == 2:
			$CanvasLayer/SpeedEff.position = Vector2 (105,247)
			$CanvasLayer/SpeedEff.visible = true
			$CanvasLayer/speed_ef.position = Vector2 (91,247)
			$CanvasLayer/speed_ef.visible = true
	if speed_position == 3:
			$CanvasLayer/SpeedEff.position = Vector2 (155,247)
			$CanvasLayer/SpeedEff.visible = true
			$CanvasLayer/speed_ef.position = Vector2 (141,247)
			$CanvasLayer/speed_ef.visible = true
	if speed_position == 4:
			$CanvasLayer/SpeedEff.position = Vector2 (205,247)
			$CanvasLayer/SpeedEff.visible = true
			$CanvasLayer/speed_ef.position = Vector2 (191,247)
			$CanvasLayer/speed_ef.visible = true
	if speed_position == 5:
			$CanvasLayer/SpeedEff.position = Vector2 (255,247)
			$CanvasLayer/SpeedEff.visible = true
			$CanvasLayer/speed_ef.position = Vector2 (241,247)
			$CanvasLayer/speed_ef.visible = true
	
	#таймер для обратного отчета		
	if timer_speed == false:
		timer_speed = true
		if TIMER_SPEED > 0:
			$SPEED_timer.set_wait_time(1)
			$SPEED_timer.start()
			
func jump_effect_sboku(): #эффект прыжка от яблока
	if Global.baf_JUMP == true: # если я только получил яблоко прыжка
		Global.baf_JUMP = false
		timer_jump = false
		TIMER_JUMP = 20
		if Global.baf_jump == false: #если яблоко уже активно, то не посчитает за новый баф
			Global.baf_jump = true
			Global.kolvо_bafs += 1
			jump_position = Global.kolvо_bafs #позиция считается в самый первый раз при появлении бафа
		$CanvasLayer/jump_ef.text = str(TIMER_JUMP)
	
	if Global.kolvо_bafs < jump_position: # Если вдруг кол-во бафов будет меньше, чем позиция в данный момент у прыжка (баг)
		jump_position = Global.kolvо_bafs
	
	#позиции по время активных бафов	
	if jump_position == 0:
			$CanvasLayer/JumpEf.visible = false
			$CanvasLayer/jump_ef.visible = false
	if jump_position == 1:
			$CanvasLayer/JumpEf.position = Vector2 (55,247)
			$CanvasLayer/JumpEf.visible = true
			$CanvasLayer/jump_ef.position = Vector2 (41,247)
			$CanvasLayer/jump_ef.visible = true
	if jump_position == 2:
			$CanvasLayer/JumpEf.position = Vector2 (105,247)
			$CanvasLayer/JumpEf.visible = true
			$CanvasLayer/jump_ef.position = Vector2 (91,247)
			$CanvasLayer/jump_ef.visible = true
	if jump_position == 3:
			$CanvasLayer/JumpEf.position = Vector2 (155,247)
			$CanvasLayer/JumpEf.visible = true
			$CanvasLayer/jump_ef.position = Vector2 (141,247)
			$CanvasLayer/jump_ef.visible = true
	if jump_position == 4:
			$CanvasLayer/JumpEf.position = Vector2 (205,247)
			$CanvasLayer/JumpEf.visible = true
			$CanvasLayer/jump_ef.position = Vector2 (191,247)
			$CanvasLayer/jump_ef.visible = true
	if jump_position == 5:
			$CanvasLayer/JumpEf.position = Vector2 (255,247)
			$CanvasLayer/JumpEf.visible = true
			$CanvasLayer/jump_ef.position = Vector2 (241,247)
			$CanvasLayer/jump_ef.visible = true
	
	#таймер для обратного отчета			
	if timer_jump == false:	
		timer_jump = true
		if TIMER_JUMP > 0:
			$JUMP_timer.set_wait_time(1)
			$JUMP_timer.start()

func neuazvimost_effect_sboku(): #эффкут неуязвимости от потери хп
	if Global.neuaz_one_raz == true: # как только потерял ХП
		Global.neuaz_one_raz = false
		Global.block_dmg = true
		timer_neuaz = false
		TIMER_neuaz = Global.block_time
		Global.kolvо_bafs += 1
		neuazvimost_position = Global.kolvо_bafs #позиция считается в самый первый раз при появлении бафа
		$CanvasLayer/neuaz_ef.text = str(TIMER_neuaz)
	
	if Global.kolvо_bafs < neuazvimost_position: # Если вдруг кол-во бафов будет меньше, чем позиция в данный момент у прыжка (баг)
		neuazvimost_position = Global.kolvо_bafs
	
	#позиции по время активных бафов	
	if neuazvimost_position == 0:
			$CanvasLayer/neuazEf.visible = false
			$CanvasLayer/neuaz_ef.visible = false
	if neuazvimost_position == 1:
			$CanvasLayer/neuazEf.position = Vector2 (55,247)
			$CanvasLayer/neuazEf.visible = true
			$CanvasLayer/neuaz_ef.position = Vector2 (41,247)
			$CanvasLayer/neuaz_ef.visible = true
	if neuazvimost_position == 2:
			$CanvasLayer/neuazEf.position = Vector2 (105,247)
			$CanvasLayer/neuazEf.visible = true
			$CanvasLayer/neuaz_ef.position = Vector2 (91,247)
			$CanvasLayer/neuaz_ef.visible = true
	if neuazvimost_position == 3:
			$CanvasLayer/neuazEf.position = Vector2 (155,247)
			$CanvasLayer/neuazEf.visible = true
			$CanvasLayer/neuaz_ef.position = Vector2 (141,247)
			$CanvasLayer/neuaz_ef.visible = true
	if neuazvimost_position == 4:
			$CanvasLayer/neuazEf.position = Vector2 (205,247)
			$CanvasLayer/neuazEf.visible = true
			$CanvasLayer/neuaz_ef.position = Vector2 (191,247)
			$CanvasLayer/neuaz_ef.visible = true
	if neuazvimost_position == 5:
			$CanvasLayer/neuazEf.position = Vector2 (255,247)
			$CanvasLayer/neuazEf.visible = true
			$CanvasLayer/neuaz_ef.position = Vector2 (241,247)
			$CanvasLayer/neuaz_ef.visible = true		

	#таймер для обратного отчета			
	if timer_neuaz == false:	
		timer_neuaz = true
		if TIMER_neuaz > 0:
			$neuaz_timer.set_wait_time(1)
			$neuaz_timer.start()

func verer_effect_sboku(): #эффект ветра
	if Global.veter_one_raz == true: # начало ветра
		Global.veter_one_raz = false
		timer_veter = false
		TIMER_veter = Global.veter_timer
		Global.kolvо_bafs += 1
		veter_position = Global.kolvо_bafs #позиция считается в самый первый раз при появлении бафа
		$CanvasLayer/veter_ef.text = str(TIMER_veter)
	
	if Global.kolvо_bafs < veter_position: # Если вдруг кол-во бафов будет меньше, чем позиция в данный момент у ветра (баг)
		veter_position = Global.kolvо_bafs
	
	#позиции по время активных бафов	
	if veter_position == 0:
			$CanvasLayer/veterEf.visible = false
			$CanvasLayer/veter_ef.visible = false
	if veter_position == 1:
			$CanvasLayer/veterEf.position = Vector2 (55,247)
			$CanvasLayer/veterEf.visible = true
			$CanvasLayer/veter_ef.position = Vector2 (41,247)
			$CanvasLayer/veter_ef.visible = true
	if veter_position == 2:
			$CanvasLayer/veterEf.position = Vector2 (105,247)
			$CanvasLayer/veterEf.visible = true
			$CanvasLayer/veter_ef.position = Vector2 (91,247)
			$CanvasLayer/veter_ef.visible = true
	if veter_position == 3:
			$CanvasLayer/veterEf.position = Vector2 (155,247)
			$CanvasLayer/veterEf.visible = true
			$CanvasLayer/veter_ef.position = Vector2 (141,247)
			$CanvasLayer/veter_ef.visible = true
	if veter_position == 4:
			$CanvasLayer/veterEf.position = Vector2 (205,247)
			$CanvasLayer/veterEf.visible = true
			$CanvasLayer/veter_ef.position = Vector2 (191,247)
			$CanvasLayer/veter_ef.visible = true
	if veter_position == 5:
			$CanvasLayer/veterEf.position = Vector2 (255,247)
			$CanvasLayer/veterEf.visible = true
			$CanvasLayer/veter_ef.position = Vector2 (241,247)
			$CanvasLayer/veter_ef.visible = true

	#таймер для обратного отчета			
	if timer_veter == false:	
		timer_veter = true
		if TIMER_veter > 0:
			$veter_timer.set_wait_time(1)
			$veter_timer.start()
			
			
func korz_timer_knopka(): # обратный отчет 30 сек, чтоб можно было снова бросить корзинку
	if Global.bros_dla_int == true: #нужно для 1 раза
		Global.bros_dla_int = false
		timer_korz = false
		if Global.korzsh == 1:
			TIMER_korz = 30
		if Global.korzsh == 2:
			TIMER_korz = 25
		if Global.korzsh == 3:
			TIMER_korz = 20
		$CanvasLayer/jump_korz.text = str(TIMER_korz)
		$CanvasLayer/jump_korz.visible = true
		
		
		#таймер для обратного отчета			
	if timer_korz == false:	
		timer_korz = true
		if TIMER_korz > 0:
			$CanvasLayer/Mobil_buttons/korz.modulate = Color(0.5,0.5,0.5,0.8)
			$korz.set_wait_time(1)
			$korz.start()
		if Global.korzsh == 1:
			if TIMER_korz == 23 and not Global.migaet_korz == -1: #начинает мигать корзинка
				Global.migaet_korz = 1
			if TIMER_korz == 20 and not Global.migaet_korz == -1: #пропадает корзинка
				Global.migaet_korz = 2
		if Global.korzsh == 2: 
			if TIMER_korz == 18 and not Global.migaet_korz == -1: #начинает мигать корзинка
				Global.migaet_korz = 1
			if TIMER_korz == 15 and not Global.migaet_korz == -1: #пропадает корзинка
				Global.migaet_korz = 2
		if Global.korzsh == 3: 
			if TIMER_korz == 13 and not Global.migaet_korz == -1: #начинает мигать корзинка
				Global.migaet_korz = 1
			if TIMER_korz == 10 and not Global.migaet_korz == -1: #пропадает корзинка
				Global.migaet_korz = 2
		if TIMER_korz == 0: #если таймер закончился
			$CanvasLayer/Mobil_buttons/korz.modulate = Color(1,1,1,0.8)
			$CanvasLayer/jump_korz.visible = false
			Global.bros = true
			Global.migaet_korz = 0
			$korz.stop()

func rivok_timer_knopka(): # обратный отчет, чтоб можно было снова нажать рывок
	if Global.rivok_dla_int == true: #нужно для 1 раза
		Global.rivok_dla_int = false
		timer_rivok = false
		$CanvasLayer/jump_rivok.visible = true #включает отображение таймера
		if Global.rivok_prokac == 1:
			TIMER_rivok = 20
		if Global.rivok_prokac == 2:
			TIMER_rivok = 15
		if Global.rivok_prokac == 3:
			TIMER_rivok = 10
		$CanvasLayer/jump_rivok.text = str(TIMER_rivok)
		$CanvasLayer/jump_rivok.visible = true
		
		#таймер для обратного отчета			
	if timer_rivok == false:	
		timer_rivok = true
		if TIMER_rivok > 0:
			$CanvasLayer/Mobil_buttons/rivok.modulate = Color(0.5,0.5,0.5,0.8)
			$RIVOK_timer.set_wait_time(1)
			$RIVOK_timer.start()
		if TIMER_rivok == 0: #если таймер закончился
			$CanvasLayer/Mobil_buttons/rivok.modulate = Color(1,1,1,0.8)
			$CanvasLayer/jump_rivok.visible = false #отключает отображение таймера
			$RIVOK_timer.stop()
			$CanvasLayer/jump_rivok.visible = false

func dabl_jump_timer_knopka(): # обратный отчет, чтоб можно было снова нажать двойной прыжок
	if Global.jumpx2_dla_int == true: #нужно для 1 раза
		Global.jumpx2_dla_int = false 
		timer_jumpx2 = false
		$CanvasLayer/jump_dabl.visible = true #включает отображение таймера
		if Global.jump_prokac == 1:
			TIMER_JUMPx2 = 12
		if Global.jump_prokac == 2:
			TIMER_JUMPx2 = 8
		if Global.jump_prokac == 3:
			TIMER_JUMPx2 = 4
		$CanvasLayer/jump_dabl.text = str(TIMER_JUMPx2)
		$CanvasLayer/jump_dabl.visible = true
		
		#таймер для обратного отчета			
	if timer_jumpx2 == false:	
		timer_jumpx2 = true
		if TIMER_JUMPx2 > 0:
			$CanvasLayer/Mobil_buttons/jump.modulate = Color(0.5,0.5,0.5,0.8)
			$dabl_jamp_timer.set_wait_time(1)
			$dabl_jamp_timer.start()
		if TIMER_JUMPx2 == 0: #если таймер закончился
			$CanvasLayer/Mobil_buttons/jump.modulate = Color(1,1,1,0.8)
			$dabl_jamp_timer.stop()
			$CanvasLayer/jump_dabl.visible = false
			Global.JUMP_mozno = true # снова можно двойной прыжок нажать

func heal_anim(): #анимация хила
	if Global.heal == true:
		Global.HP_chet += 1
		if Global.HP == 6:
			HP_6.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_6.animation_finished
		if Global.HP == 5:
			HP_5.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_5.animation_finished
		if Global.HP == 4:
			HP_4.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_4.animation_finished
		if Global.HP == 3:
			HP_3.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_3.animation_finished
		if Global.HP == 2:
			HP_2.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_2.animation_finished
		if Global.HP == 1:
			HP_1.play("HEAL")
			Global.heal = false	
			if Global.musek_efect == true:
				$heal.play()
			await HP_1.animation_finished
func damage_anim(): #анимация урона
	if Global.damage == true:
		if Global.HP == 5:
			HP_6.play("damage")
			await HP_6.animation_finished
			Global.damage = false
		if Global.HP == 4:
			HP_5.play("damage")
			await HP_5.animation_finished
			Global.damage = false
		if Global.HP == 3:
			HP_4.play("damage")
			await HP_4.animation_finished
			Global.damage = false
		if Global.HP == 2:
			HP_3.play("damage")
			await HP_3.animation_finished
			Global.damage = false
		if Global.HP == 1:
			HP_2.play("damage")
			await HP_2.animation_finished
			Global.damage = false
		if Global.HP < 0:
			Global.HP = 0
		if Global.HP == 0:
			HP_1.play("damage")
			await HP_1.animation_finished
			if Global.respawn == false:
				Global.paus = !Global.paus
				Global.respawn = true #запускает функцию респавна
				Global.damage = false
				Global.liderbord()#сохраняет в лидерборд рекорд
				Global.saveYandexznachenia()#Сохраняет всё что было заработано за время игры
			

func skrit_ikonki_menu(): #иконки меню, скрывает и раскрывает
	if Global.musek == true:
		if Global.info == false:
			$musek2/Musek.visible = true
			$musek2/Musek1.visible = false
	else:
		if Global.info == false:
			$musek2/Musek.visible = false
			$musek2/Musek1.visible = true
	if Global.musek_efect == true:
		if Global.info == false:
			$musek3/EffectOn.visible = true
			$musek3/EffectOff.visible = false	
	else:
		if Global.info == false:
			$musek3/EffectOn.visible = false
			$musek3/EffectOff.visible = true	
	if Global.esc == false:
		if Global.info == false:
			$esc/Esc.visible = true
			$esc/Esc2.visible = false	
			$musek2.visible = false
			$musek3.visible = false
			$manu.visible = false
		$info.visible = false
	else:
		if Global.info == false:
			$esc/Esc.visible = false
			$esc/Esc2.visible = true	
			$musek2.visible = true
			$musek3.visible = true
			$manu.visible = true
		$info.visible = true	

#При нажатии и отпускании кнопок лево и право меняются
func _on_run_right_pressed():
	$CanvasLayer/Mobil_buttons/run_right.modulate = Color(0.5,0.5,0.5,0.8)

func _on_run_right_released():
	$CanvasLayer/Mobil_buttons/run_right.modulate = Color(1,1,1,0.8)


func _on_run_left_pressed():
	$CanvasLayer/Mobil_buttons/run_left.modulate = Color(0.5,0.5,0.5,0.8)

func _on_run_left_released():
	$CanvasLayer/Mobil_buttons/run_left.modulate = Color(1,1,1,0.8)

func knopka_tolk_yach(): #всё связанное с кнопкой толкать ящик
	#кнопка возникает только когда нет ветра и есть прикосновение в зонах 
	if Global.prikosnovenie_right_bat == true and Global.smotru == "left" and (Global.tree == 0 or Global.tree == 3 or Global.tree == -3):
		bat.visible = true
		if Global.sam_process_tolkania_bat == false:
			Global.mozno_nazat_na_knopku_tolk = true
		else:
			Global.mozno_nazat_na_knopku_tolk = false
	elif Global.prikosnovenie_left_bat == true and Global.smotru == "right" and (Global.tree == 0 or Global.tree == 3 or Global.tree == -3):
		bat.visible = true
		if Global.sam_process_tolkania_bat == false:
			Global.mozno_nazat_na_knopku_tolk = true
		else:
			Global.mozno_nazat_na_knopku_tolk = false
	else:
		if Global.winda == false: #если не компьютер, то кнопки надо скрывть
			bat.visible = false
		Global.sam_process_tolkania_bat = false

	
	# кнопка горит серым, если толкаю или обратно белой, когда перестаю толкать
	if Global.sam_process_tolkania_bat == true:
		$CanvasLayer/Mobil_buttons/yachik.modulate = Color(0.5,0.5,0.5,0.8)
	if Global.sam_process_tolkania_bat == false and not Input.is_action_pressed("ui_accept") and not Global.tree == 0:
		$CanvasLayer/Mobil_buttons/yachik.modulate = Color(0.5,0.5,0.5,0.8)
	if Global.sam_process_tolkania_bat == false and not Input.is_action_pressed("ui_accept") and Global.tree == 0:
		$CanvasLayer/Mobil_buttons/yachik.modulate = Color(1,1,1,0.8)
	if Global.avto_modes == true:
		$CanvasLayer/Mobil_buttons/yachik.modulate = Color(1,0.7,0.21,0.8)
	if Global.sdelal_jump == true and Global.jump_prokac == 0: #прыжок с земли без возможности двойного прыжка
		$CanvasLayer/Mobil_buttons/jump.modulate = Color(0.5,0.5,0.5,0.8)
	if Global.sdelal_jump == false and Global.jump_prokac == 0:
		$CanvasLayer/Mobil_buttons/jump.modulate = Color(1,1,1,0.8)
	if Global.sdelal_jump == true and (Global.jump_prokac >= 1 and Global.JUMP_mozno == true): #прыжок с земли при возможном двойном прыжке
		$CanvasLayer/Mobil_buttons/jump.visible = false
		$CanvasLayer/Mobil_buttons/jump2.visible = true
		$CanvasLayer/Mobil_buttons/jump2.modulate = Color(1,0.7,0.21,0.8)
	else:
		$CanvasLayer/Mobil_buttons/jump.visible = true
		$CanvasLayer/Mobil_buttons/jump2.visible = false
	if Global.kol_vo_nazati_korz == 1:
		$CanvasLayer/Mobil_buttons/korz.modulate = Color(1,0.7,0.21,0.8)
	if Global.kol_vo_nazati_korz == 0 and TIMER_korz == 0:
		$CanvasLayer/Mobil_buttons/korz.modulate = Color(1,1,1,0.8)
		
		
func language():
	if Global.Language == "RU":
		$pausa.text = str ("Пауза")
		$"респавн/Плашка с текстом".text = str ("Вы проиграли")
	else:
		$pausa.text = str ("Pause")
		$"респавн/Плашка с текстом".text = str ("You lost")
		
func otobr_hp(): #отображает хп
	if Global.HP_MAX == 3:
		#отображает
		HP_1.visible = true
		HP_2.visible = true
		HP_3.visible = true
		#скрывает
		HP_4.visible = false
		HP_5.visible = false
		HP_6.visible= false
	if Global.HP_MAX == 4:
		#отображает
		HP_1.visible = true
		HP_2.visible = true
		HP_3.visible = true
		HP_4.visible = true
		#скрывает
		HP_5.visible = false
		HP_6.visible = false
	if Global.HP_MAX == 5:
		#отображает
		HP_1.visible = true
		HP_2.visible = true
		HP_3.visible = true
		HP_4.visible = true
		HP_5.visible = true
		#скрывает
		HP_6.visible = false
	if Global.HP_MAX == 6:
		#отображает
		HP_1.visible = true
		HP_2.visible = true
		HP_3.visible = true
		HP_4.visible = true
		HP_5.visible = true
		HP_6.visible = true

	
func otobr_knopok(): #скрывает и отображает корректно кнопки если пк или мобилка
	if Global.winda == true: #если винда, то кнопки сместить и выключить стрелочки
		#выключить кнопки
		$CanvasLayer/Mobil_buttons/run_left.visible = false
		$CanvasLayer/Mobil_buttons/run_right.visible = false
		$CanvasLayer/Mobil_buttons/jump.position = Vector2 (962,586)
		$CanvasLayer/Mobil_buttons/jump.set_scale(Vector2(2, 2))
		$CanvasLayer/Mobil_buttons/jump2.position = Vector2 (962,586)
		$CanvasLayer/Mobil_buttons/jump2.set_scale(Vector2(2, 2))
		if Global.sdelal_jump == true and (Global.jump_prokac >= 1 and Global.JUMP_mozno == true):
			$CanvasLayer/Mobil_buttons/jump.visible = false
			$CanvasLayer/Mobil_buttons/jump2.visible = true
		else:
			$CanvasLayer/Mobil_buttons/jump.visible = true
		
		$CanvasLayer/Mobil_buttons/rivok.position = Vector2 (1021,586)
		$CanvasLayer/Mobil_buttons/rivok.set_scale(Vector2(2, 2))
		$CanvasLayer/Mobil_buttons/rivok.visible = true
		if Global.skorshx2 == 0:
			$CanvasLayer/Mobil_buttons/rivok.modulate = Color(0.5,0.5,0.5,0.8)
		
		$CanvasLayer/Mobil_buttons/korz.position = Vector2 (1081,586)
		$CanvasLayer/Mobil_buttons/korz.set_scale(Vector2(2, 2))
		$CanvasLayer/Mobil_buttons/korz.visible = true
		if Global.korzsh == 0:
			$CanvasLayer/Mobil_buttons/korz.modulate = Color(0.5,0.5,0.5,0.8)
			
		$CanvasLayer/Mobil_buttons/yachik.position = Vector2 (1141,586)
		$CanvasLayer/Mobil_buttons/yachik.set_scale(Vector2(2, 2))
		$CanvasLayer/Mobil_buttons/yachik.visible = true
		if Global.batsh == 0 or not ((Global.prikosnovenie_right_bat == true and Global.smotru == "left") or (Global.prikosnovenie_left_bat == true and Global.smotru == "right") and (Global.tree == 0 or Global.tree == 3 or Global.tree == -3)):
			$CanvasLayer/Mobil_buttons/yachik.modulate = Color(0.5,0.5,0.5,0.8)
			
		$CanvasLayer/jump_korz.position = Vector2 (1099,606)
		$CanvasLayer/jump_korz.set_scale(Vector2(0.5, 0.5))
		$CanvasLayer/jump_rivok.position = Vector2 (1038,606)
		$CanvasLayer/jump_rivok.set_scale(Vector2(0.5, 0.5))
		$CanvasLayer/jump_dabl.position = Vector2 (980,606)
		$CanvasLayer/jump_dabl.set_scale(Vector2(0.5, 0.5))
	else:
		#включить кнопки
		$CanvasLayer/Mobil_buttons/run_left.visible = true
		$CanvasLayer/Mobil_buttons/run_right.visible = true
		if Global.korzsh >= 1:
				korz.visible = true
		else:
			korz.visible = false
		if Global.skorshx2 >= 1:
			rivok.visible = true
		else:
			rivok.visible = false	
	
	#когда нажимаю на клаве, то кнопки тоже загораются лево и право
	if Input.is_action_pressed("ui_left"):
		$CanvasLayer/Mobil_buttons/run_left.modulate = Color(0.5,0.5,0.5,0.8)
	else:
		$CanvasLayer/Mobil_buttons/run_left.modulate = Color(1,1,1,0.8)
	if Input.is_action_pressed("ui_right"):
		$CanvasLayer/Mobil_buttons/run_right.modulate = Color(0.5,0.5,0.5,0.8)
	else:
		$CanvasLayer/Mobil_buttons/run_right.modulate = Color(1,1,1,0.8)	


func _on_видео_mouse_entered():
	animats = true

func _on_видео_mouse_exited():
	animats = false

func _on_видео_pressed():
	if Global.respawn == true:
		Bridge.advertisement.show_rewarded()


func _on_restarts_pressed():
	Global.resp_monet = 40 #изначально респ стоит 40 монет
	Global.score = 0 #обнуляет очки
	Global.kolvо_bafs = 0 #обнуляет все бафы
	get_tree().reload_current_scene()


func _on_restarts_mouse_entered():
	vrash = true
	
func vrashi(): #функция вращения рестарта
	$"респавн/restarts/Restart".rotation += 0.04


func _on_restarts_mouse_exited():
	vrash = false
	$"респавн/restarts/Restart".rotation = 0

func respawn_f(): #функция появления за монеты
	$"респавн/число отображения монет для респа".text = str (Global.resp_monet)
	if Global.resp_monet <= Global.gold:
		$"респавн/Koin".play("buy_gold")
		$"респавн/число отображения монет для респа".modulate = Color(0, 139, 0)
	else:
		$"респавн/Koin".play("idle_gold")
		$"респавн/число отображения монет для респа".modulate = Color(139, 0, 0)


func _on_респ_за_монеты_pressed():
	if Global.respawn == true:
			if Global.resp_monet <= Global.gold:
				Global.gold -= Global.resp_monet
				Global.resp_monet = (Global.resp_monet * 2) - 30
				#функция лечения
				Global.HP_chet += 2
				Global.heal = true
				Global.HP = 2
				HP_1.play("HEAL")
				HP_2.play("HEAL")
				Global.heal = false	
				Global.paus = false
				Global.respawn = false
				Global.poluch_dmg = true
				Global.migaet_gg = false
				get_tree().paused = false
				if Global.musek_efect == true:
					$heal.play()


func _on_респ_за_монеты_mouse_entered():
	animats2 = true


func _on_респ_за_монеты_mouse_exited():
	animats2 = false


func massiv_rand_podskazki():#сформировать массив подсказок, чтобы каждый раз рандомно отображались во время паузы
	var rng = RandomNumberGenerator.new()
	var k = 0 #сколько раз выполнится цикл
	var random_int_num #случайное число
	rng.randomize()
	while k < 32:
		random_int_num = rng.randi_range(1, 32)
		if random_int_num in massiv:
			k -= 1
		else:
			massiv.push_front(random_int_num) #добавляет вперед массива случайное число
		k += 1
	print (str (massiv) + " - Массив чисел")
	print (str (massiv.size()) + " - Длинна массива")
	print (str (k) + " - Сколько раз выполнился массив")

func podskazki(): #всплывающие подсказки во время паузы
	nomerachia = massiv[z]
	if Global.Language == "RU":
		if nomerachia == 1:
			$"Подсказки2".text = str ("Локация имеет соединение между левым и правым краем карты, 
				что позволяет быстро перемещаться с одного края на другой.")
		if nomerachia == 2:
			$"Подсказки2".text = str ("При первой активации корзинки игрок увидит место, 
				где она может быть установлена. При повторной активации 
				корзинка будет размещена в этом месте.")
		if nomerachia == 3:
			$"Подсказки2".text = str ("После приобретения ящика в «Улучшениях» 
				появится возможность 
				включать и выключать его во время игры.")
		if nomerachia == 4:
			$"Подсказки2".text = str ("Ёжика с яблоком «Прыгучести» 
				можно попытаться перепрыгнуть, но для этого 
				нужно иметь большую силу прыжка, 
				чем у самого ёжика, или заставить его 
				перепрыгнуть через игрока.")
		if nomerachia == 5:
			$"Подсказки2".text = str ("Птица с золотым яблоком будет более хитрой. 
				Игроку потребуется проявить смекалку, 
				чтобы заполучить у неё золотое яблоко.")
		if nomerachia == 6:
			$"Подсказки2".text = str ("Птица с яблоком «Скорости» обладает 
				повышенной скоростью передвижения.")
		if nomerachia == 7:
			$"Подсказки2".text = str ("Птица с яблоком «Прыгучести» поднимается вверх. 
				В этот момент забрать у неё яблоко становится сложнее.")
		if nomerachia == 8:
			$"Подсказки2".text = str ("Птица с яблоком «Защиты» получает защиту
				от неблагоприятных погодных условий. 
				Чтобы забрать у неё яблоко, нужно разрушить её щит.")
		if nomerachia == 9:
			$"Подсказки2".text = str ("Ёжик с обычным яблоком 
				не сможет поймать корзинку и другие яблоки.")
		if nomerachia == 10:
			$"Подсказки2".text = str ("Ёжик без яблока может 
				с небольшой вероятностью поймать корзинку 
				и будет бегать с ней, 
				помогая игроку собирать яблоки.")
		if nomerachia == 11:
			$"Подсказки2".text = str ("Ёжик с яблоком «Скорости» обладает 
				повышенной скоростью передвижения.")
		if nomerachia == 12:
			$"Подсказки2".text = str ("Ёжик с яблоком «Прыгучести» может подпрыгнуть вверх 
				вместе с игроком.")
		if nomerachia == 13:
			$"Подсказки2".text = str ("Ёжик с яблоком «Защиты» получает защиту 
				от неблагоприятных погодных условий.")
		if nomerachia == 14:
			$"Подсказки2".text = str ("Ёжик с золотым яблоком всегда перемещается 
				вместе со своими друзьями.")
		if nomerachia == 15:
			$"Подсказки2".text = str ("Птица без яблока может поймать другое падающее яблоко 
				во время полета и получить его способность.")
		if nomerachia == 16:
			$"Подсказки2".text = str ("Ёжик без яблока может поймать падающее яблоко 
				и получить его способность.")
		if nomerachia == 17:
			$"Подсказки2".text = str ("Если ёжик поймает гнилое яблоко, он исчезнет, 
				а игрок получит очки.")
		if nomerachia == 18:
			$"Подсказки2".text = str ("Птица улетит, если поймает гнилое яблоко, 
				а игрок получит очки.")
		if nomerachia == 19:
			$"Подсказки2".text = str ("Если гнилое яблоко упадет в ящик 
				с уже имеющимися в нём яблоками, 
				оно уничтожит первое из них. 
				Если же в ящике не было яблок, 
				игрок потеряет очки и здоровье.")
		if nomerachia == 20:
			$"Подсказки2".text = str ("Поймав любое яблоко из размещенной корзинки, 
				игрок получит очки, а корзинка исчезнет.")
		if nomerachia == 21:
			$"Подсказки2".text = str ("Используйте рывок и двойной прыжок разумно.")
		if nomerachia == 22:
			$"Подсказки2".text = str ("Отключить звуки игры и музыку можно в игровом меню
				или во время паузы.")
		if nomerachia == 23:
			$"Подсказки2".text = str ("Поймав яблоко «Скорости», игрок получит 
				повышенную скорость передвижения.")
		if nomerachia == 24:
			$"Подсказки2".text = str ("Поймав яблоко «Прыгучести», игрок получит 
				повышенную силу прыжка.")
		if nomerachia == 25:
			$"Подсказки2".text = str ("Поймав яблоко «Защиты», игрок получит 
				защиту от одного любого урона. 
				Если игрок уже имеет активный щит и поймает это яблоко, 
				эффект защиты исчезнет, а игрок получит 
				дополнительные очки и восстановит одно здоровье.")
		if nomerachia == 26:
			$"Подсказки2".text = str ("Поймав золотое яблоко, 
				игрок восстановит одно здоровье.
				Если поймать золотое яблоко, когда здоровье игрока полное, 
				вы получите много очков.")
		if nomerachia == 27:
			$"Подсказки2".text = str ("Если время хранения яблока в ящике истечет — оно пропадет, 
				зато принесет игроку много очков и способность данного яблока.")
		if nomerachia == 28:
			$"Подсказки2".text = str ("Внешний вид персонажа не влияет на уровень игры игрока.")
		if nomerachia == 29:
			$"Подсказки2".text = str ("В главном меню можно сменить язык игры 
				на другой доступный вариант.")
		if nomerachia == 30:
			$"Подсказки2".text = str ("Для ознакомления с игрой 
				откройте в настройках раздел «Книга помощи».")
		if nomerachia == 31:
			$"Подсказки2".text = str ("Играйте в своё удовольствие!")
		if nomerachia == 32:
			$"Подсказки2".text = str ("Игроку не следует ловить гнилое яблоко.")
	#английский язык	
	if Global.Language == "EN":
		if nomerachia == 1:
			$"Подсказки2".text = str ("The location has a connection between the left and right 
				edges of the map, which allows you to quickly move 
				from one edge to the other.")
		if nomerachia == 2:
			$"Подсказки2".text = str ("When the basket is activated for the first time, 
				the player will see the place where it can be installed. 
				Upon reactivation, the shopping cart
				will be placed in this location.")
		if nomerachia == 3:
			$"Подсказки2".text = str ("After purchasing the box in the store, 
				you will be able to turn it 
				on and off during the game.")
		if nomerachia == 4:
			$"Подсказки2".text = str ("You can try to jump over a hedgehog 
			with a jumping apple, but for this you need 
			to have a greater jumping force than the hedgehog itself, 
			or make it jump over the player.")
		if nomerachia == 5:
			$"Подсказки2".text = str ("A bird with a golden apple will be more cunning. 
				The player will need to be smart 
				to get the golden apple from her.")
		if nomerachia == 6:
			$"Подсказки2".text = str ("A bird with an apple of «Speed» 
				has an increased speed of movement.")
		if nomerachia == 7:
			$"Подсказки2".text = str ("A bird with an apple of «Jump» rises up. 
				At this point, it becomes more difficult 
				to take the apple from her.")
		if nomerachia == 8:
			$"Подсказки2".text = str ("A bird with a «Protection» apple receives protection 
			from adverse weather conditions. To take the apple from her, 
			you need to destroy her shield.")
		if nomerachia == 9:
			$"Подсказки2".text = str ("A hedgehog with an ordinary apple 
				will not be able to catch a basket and other apples.")
		if nomerachia == 10:
			$"Подсказки2".text = str ("A hedgehog without an apple can catch 
				a basket with a small probability 
				and will run with it, 
				helping the player to collect apples.")
		if nomerachia == 11:
			$"Подсказки2".text = str ("The hedgehog with the apple of «Speed» 
				has an increased speed of movement.")
		if nomerachia == 12:
			$"Подсказки2".text = str ("A hedgehog with the apple of «Jump» 
				can jump up with the player.")
		if nomerachia == 13:
			$"Подсказки2".text = str ("A hedgehog with a «Protection» 
				apple receives protection from adverse weather conditions.")
		if nomerachia == 14:
			$"Подсказки2".text = str ("The hedgehog with the golden apple 
				always moves with his friends.")
		if nomerachia == 15:
			$"Подсказки2".text = str ("A bird without an apple can catch 
				another falling apple during flight and gain its ability.")
		if nomerachia == 16:
			$"Подсказки2".text = str ("A hedgehog without an apple can catch 
				a falling apple and get its ability.")
		if nomerachia == 17:
			$"Подсказки2".text = str ("If the hedgehog catches a rotten apple, 
				it will disappear, and the player will get points.")
		if nomerachia == 18:
			$"Подсказки2".text = str ("The bird will fly away if it catches a rotten apple, 
				and the player will get points.")
		if nomerachia == 19:
			$"Подсказки2".text = str ("If a rotten apple falls into a box 
				with apples already in it, 
				it will destroy the first of them. 
				If there were no apples in the box, 
				the player will lose points and health.")
		if nomerachia == 20:
			$"Подсказки2".text = str ("Catching any apple from the placed basket, 
				the player will receive points, 
				and the basket will disappear.")
		if nomerachia == 21:
			$"Подсказки2".text = str ("Use the shurt and double jump wisely.")
		if nomerachia == 22:
			$"Подсказки2".text = str ("You can turn off the game sounds and music 
				in the game menu or during a pause.")
		if nomerachia == 23:
			$"Подсказки2".text = str ("Catching the apple of «Speed», 
				the player will receive an increased movement speed.")
		if nomerachia == 24:
			$"Подсказки2".text = str ("Catching the apple of «Jump», 
				the player will receive increased jumping power.")
		if nomerachia == 25:
			$"Подсказки2".text = str ("Catching the apple of «Protection», 
				the player will receive protection from any damage. 
				If the player already has an active shield 
				and catches this apple, the protection effect will disappear, 
				and the player will receive additional points and restore one health.")
		if nomerachia == 26:
			$"Подсказки2".text = str ("After catching the golden apple, 
				the player will restore one health. If you catch the golden apple 
				when the player's health is full, you will get a lot of points.")
		if nomerachia == 27:
			$"Подсказки2".text = str ("If the storage time of the apple in the box expires, 
				it will disappear, but it will bring the player 
				a lot of points and the ability of this apple.")
		if nomerachia == 28:
			$"Подсказки2".text = str ("The appearance of the character 
				does not affect the player's level of play.")
		if nomerachia == 29:
			$"Подсказки2".text = str ("In the main menu, you can change the language 
				of the game to another available option.")
		if nomerachia == 30:
			$"Подсказки2".text = str ("To familiarize yourself with the game, 
				open the «Help Book» section in the settings.")
		if nomerachia == 31:
			$"Подсказки2".text = str ("Play for fun!")
		if nomerachia == 32:
			$"Подсказки2".text = str ("The player should not catch a rotten apple.")
		
	

#переключение подсказок
func _on_стрелочка_подсказки_лево_pressed():
	if z == 0:
		z = 31
	else: 
		z -= 1
func _on_стрелочка_подсказки_право_pressed():
	if z == 31:
		z = 0
	else:
		z += 1

#при наведении мышки стрелочки моргают
func _on_стрелочка_подсказки_лево_mouse_entered():
	$"Стрелочка подсказки лево".modulate = Color(1, 1, 1, 0.4)
func _on_стрелочка_подсказки_лево_mouse_exited():
	$"Стрелочка подсказки лево".modulate = Color(1, 1, 1, 0.6)
func _on_стрелочка_подсказки_право_mouse_entered():
	$"Стрелочка подсказки право".modulate = Color(1, 1, 1, 0.4)
func _on_стрелочка_подсказки_право_mouse_exited():
	$"Стрелочка подсказки право".modulate = Color(1, 1, 1, 0.6)

func ypravl_v_nachale_open():#если запускаю первый раз, то открывается "книга помощи" на вкладке "управление"
	if Global.upravl_otkr == true:
		Global.upravl_otkr = false
		Global.esc = true
		Global.paus = true
		Global.info = true
		Global.stranica = 2
		Global.razdel = "lvl"
		$info/Kniga.visible = false
		$info/Kniga2.visible = true
		var kniga_spawni = Global.kniga4.instantiate()
		kniga_spawni.position = Vector2 (0,0)
		add_child(kniga_spawni)
		$manu.visible = false
		$info.visible = false
		#$esc.visible = false
		$Pramougoln.visible = false
		$Podl.visible = false
		$Korz2.visible = false
		$Top2.visible = false
		$Koin.visible = false
		if Global.HP_MAX == 3:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
		if Global.HP_MAX == 4:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
		if Global.HP_MAX == 5:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
			HP_5.visible = false
			HP_6.visible = false
		if Global.HP_MAX == 6:
			#скрывает
			HP_1.visible = false
			HP_2.visible = false
			HP_3.visible = false
			HP_4.visible = false
			HP_5.visible = false
			HP_6.visible = false
		$CanvasLayer/Mobil_buttons.visible = false
		$CanvasLayer.visible = false
		$musek3.visible = false
		$musek2.visible = false
		$esc.visible = false

func menaetsa_vo_vrema_game():#меняется во время игры, чтобы не нагружать process
	gold.text = str(Global.gold)
	record.text = str(Global.hi_score)
	chetik.text = str(Global.score)
	
	if Global.Language == "RU":
		$"Награда получена/Плашка с текстом".text = str("Награда 
			получена!!!")
	if Global.Language == "EN":
		$"Награда получена/Плашка с текстом".text = str("The reward has 
		been received!!!")
	
func nagrada():#награда за просмотр рекламы
	if Global.Nagrada_reklama == true and Global.paus == false:
			#тут яндекс код вставить с рекламой
			Global.HP_chet += 2
			Global.heal = true
			Global.HP = 2
			HP_1.play("HEAL")
			HP_2.play("HEAL")
			Global.heal = false	
			Global.respawn = false
			Global.poluch_dmg = true
			Global.migaet_gg = false
			get_tree().paused = false
			if Global.musek_efect == true:
				$heal.play()
			Global.Nagrada_reklama = false

func paus_game():#пауза во время игры
	#пауза при нажатии на esc
	if Input.is_action_just_pressed("esc") and Global.respawn == false and Global.info == false:
		Global.paus = !Global.paus
		if Global.esc == false:
			Global.esc = true
			$esc/Esc2.visible = false
			$esc/Esc.visible = true
			
		else:
			Global.esc = false
			$esc/Esc2.visible = true
			$esc/Esc.visible = false
		
	if Global.paus == false: # пауза отключена в игре
		# Вызовите эту функцию, когда нужно возобновить игру
		get_tree().paused = false
		Bridge.platform.send_message("in_game_loading_started")
		Bridge.platform.send_message("gameplay_started")
		$pausa.visible = false
		$Pramougoln.visible = false
		$"респавн".visible = false
		$esc.visible = true
		$"Стрелочка подсказки лево".visible = false
		$"Стрелочка подсказки право".visible = false
		$"Подсказки2".visible = false
		$"подсказки".visible = false
		$"Награда получена".visible = false
		
		if Global.winda == false:
			$CanvasLayer/Mobil_buttons/run_left.position = Vector2 (21, 483)
			$CanvasLayer/Mobil_buttons/run_right.position = Vector2 (160, 483)
			$CanvasLayer/Mobil_buttons/jump.position = Vector2 (974, 483)
			$CanvasLayer/Mobil_buttons/jump2.position = Vector2 (974, 483)
			$CanvasLayer/Mobil_buttons/rivok.position = Vector2 (1043, 368)
			$CanvasLayer/Mobil_buttons/korz.position = Vector2 (903, 368)
			$CanvasLayer/Mobil_buttons/yachik.position = Vector2 (834, 483)
			$CanvasLayer/jump_dabl.position = Vector2 (1011, 524)
			$CanvasLayer/jump_korz.position = Vector2 (941, 410)
			$CanvasLayer/jump_rivok.position = Vector2 (1078, 409)
	if Global.paus == true and Global.respawn == false and Global.reward_received == false: # пауза включена в игре
		# Вызовите эту функцию, когда нужно приостановить игру
		if Global.info == false:
			$pausa.visible = true
			$Pramougoln.visible = true
			$"Стрелочка подсказки лево".visible = true
			$"Стрелочка подсказки право".visible = true
			$"Подсказки2".visible = true
			$"подсказки".visible = true
			$esc.visible = true
			$info.visible = true
			$manu.visible = true
			$musek3.visible = true
			$musek2.visible = true
		if Global.winda == false:
			#просто за край карты увожу кнопки
			$CanvasLayer/Mobil_buttons/run_left.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/run_right.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/jump.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/jump2.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/rivok.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/korz.position = Vector2 (-200, -200)
			$CanvasLayer/Mobil_buttons/yachik.position = Vector2 (-200, -200)
			$CanvasLayer/jump_korz.position = Vector2 (-200, -200)
			$CanvasLayer/jump_rivok.position = Vector2 (-200, -200)
			$CanvasLayer/jump_dabl.position = Vector2 (-200, -200)
		Bridge.platform.send_message("in_game_loading_stopped")
		Bridge.platform.send_message("gameplay_stopped")
		get_tree().paused = true
	if Global.respawn == true and Global.reward_received == false: # пауза после проигрыша включена	
		# Вызовите эту функцию, когда нужно приостановить игру
		$"респавн".visible = true
		$esc.visible = false
		Bridge.platform.send_message("in_game_loading_stopped")
		Bridge.platform.send_message("gameplay_stopped")
		get_tree().paused = true
	if Global.respawn == true and Global.reward_received == true and Global.winda == true: # пауза после просмотра видео
		$"респавн".visible = false
		$esc.visible = false
		$"Награда получена".visible = true
		$musek2.visible = false
		$musek3.visible = false
		$info.visible = false
		Global.respawn = false
		get_tree().paused = true
	if Global.respawn == true and Global.reward_received == true and Global.winda == false: # после видео снять дать награду
		$"респавн".visible = false
		Global.respawn = false
		Global.paus = false
		Global.reward_received = false
	if Global.reward_received == false:
		$"Награда получена".visible = false
