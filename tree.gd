extends Node2D

@onready var timer = $Timer
var rand 
var n = 0
var timers = true
var shans_ezhik = 0.7 #изначально 70% что ёжик заспавнится после ветра
var shans_bird = 0.7 #изначально 70% что птица заспавнится после ветра

func _ready() -> void:
	rand = randi_range(30,60)
	print ("Ветер начнётся через " + str (rand) + " сек")
	timer.set_wait_time(rand)
	timer.start()
	
func timer_mal():
	if timers == false:
		rand = randi_range(15,25)
		print ("Ветер продлится " + str (rand) + " сек")
		Global.veter_timer = rand # сколько секунд будет ветер дуть
		Global.veter_one_raz = true #включить функцию отображения ветра сбоку
		timer.set_wait_time(rand)
		timer.start()
		timers = true

func timer_big():
	if timers == false:
		rand = randi_range(30,60)
		print ("Ветер начнётся через " + str (rand) + " сек")
		timer.set_wait_time(rand)
		timer.start()
		timers = true
		return [timer]
		if randf() < 0.33: # 33% что ёжик заспавнится, когда пройдет ветер
			Global.ezhik_spawn = true
			print ("Ёжик заспавнился")
		else:
			Global.ezhik_spawn = false
	
func _on_timer_timeout():
	timers = false
	print ("Таймер остановился")
	if Global.tree == 0:
		if randf() < 0.5: 
			Global.tree = 1
			Global.korz_na_golove = -1
		else:
			Global.tree = -1
			Global.korz_na_golove = -1
	if Global.tree == 2:
		Global.korz_na_golove = 1
		Global.tree = 3
	if Global.tree == -2:
		Global.korz_na_golove = 1
		Global.tree = -3

func _process(delta: float) -> void:
		if Global.tree == -1:
			if not Global.polozhenie_ezhika == 4:
				Global.ezhik_spawn = false
			left()
		
		if Global.tree == 1:
			if not Global.polozhenie_ezhika == 4:
				Global.ezhik_spawn = false
			right()
				
		if Global.tree == -3:
			if Global.polozhenie_ezhika == 4:
				Global.deaf_live_ezhik = -1
			left()
			
		if Global.tree == 3:
			if Global.polozhenie_ezhika == 4:
				Global.deaf_live_ezhik = -1
			right()

func left():
	if Global.tree == -1:
		Global.tree = -2
	if Global.tree == -2:
		timer_mal()
		return
	if Global.tree == -3:
		Global.tree = 0
		#проверка на спавн ёжика
		if randf() < shans_ezhik: #шанс ёжика
			if Global.ezhik_spawn == false:
				Global.ezhik_spawn = true
		else:
			Global.ezhik_spawn = false
		if shans_ezhik < 1:
			shans_ezhik += 0.2 #после каждого ветра увеличивает шанс на спавн ёжика на 2% (через 15 ветров ёжик будет спавниться со 100% вероятностю)
		#проверка на спавн птицы
		if randf() < shans_bird: #шанс птицы
			Global.bird_spawn = true #спавнит птиц
			if randf() < 0.33: #33% шанс на респ от 1 до 3 птиц
				Global.schet_bird = 1
			else:
				if randf() < 0.5:
					Global.schet_bird = 2
				else:
					Global.schet_bird = 3
		else:
			Global.bird_spawn = false #спавнит птиц
		if shans_bird < 1:
			shans_bird += 0.2 #после каждого ветра увеличивает шанс на спавн птицы на 2% (через 15 ветров птица будет спавниться со 100% вероятностю)

		timer_big()

func right():
	if Global.tree == 1:
		Global.tree = 2
	if Global.tree == 2:
		timer_mal()
	if Global.tree == 3:
		Global.tree = 0
		#проверка на спавн ёжика
		if randf() < shans_ezhik: #шанс ёжика
			if Global.ezhik_spawn == false:
				Global.ezhik_spawn = true
		else:
			Global.ezhik_spawn = false
		if shans_ezhik < 1:
			shans_ezhik += 0.2 #после каждого ветра увеличивает шанс на спавн ёжика на 2% (через 15 ветров ёжик будет спавниться со 100% вероятностю)
		#проверка на спавн птицы
		if randf() < shans_bird: #шанс птицы
			Global.bird_spawn = true #спавнит птиц
			if randf() < 0.99: #33% шанс на респ от 1 до 3 птиц
				Global.schet_bird = 1
			else:
				if randf() < 0.5:
					Global.schet_bird = 2
				else:
					Global.schet_bird = 3
		else:
			Global.bird_spawn = false #спавнит птиц
		if shans_bird < 1:
			shans_bird += 0.2 #после каждого ветра увеличивает шанс на спавн птицы на 2% (через 15 ветров птица будет спавниться со 100% вероятностю)

		timer_big()
