extends Control

@onready var progress_bar = $ProgressBar #Полоска загрузки сцены
@onready var Logotip = $"Логотип" #Логотип
@onready var Black_monitor = $"Анимация_на_появление_логотипа/visible" #анимация на смену черного экрана


func _ready():
	Pouavlenie_zagruzki()#Появление логотипа и самой загрузки
	load_resources()#загрузка ресурсов
	
#Появление логотипа и самой загрузки
func Pouavlenie_zagruzki():
	Global.zagruzka = true #Загрузка игры запущена
	Black_monitor.play("появление логотипа")
	await Black_monitor.animation_finished
	progress_bar.visible = true

func _on_storage_get_completed(success, data):
	if success:
	#золото
		if data[0] != null:
			Global.gold = int(data[0])
		#статистика
		if data[1] != null:
			Global.hi_score = int(data[1])
		if data[2] != null:
			Global.very_score = int(data[2])
		if data[3] != null:
			Global.HP_chet = int(data[3])
		if data[4] != null:
			Global.apple_razbilos = int(data[4])
		if data[5] != null:
			Global.speed_stats = int(data[5])
		if data[6] != null:
			Global.jump_stats = int(data[6])
		if data[7] != null:
			Global.def_stats = int(data[7])
		if data[8] != null:
			Global.gold_stats = int(data[8])
		if data[9] != null:
			Global.common_apple = int(data[9])
		#уровень прокачки навыка в магазине
		if data[10] != null:
			Global.skorsh = int(data[10])
		if data[11] != null:
			Global.skorshx2 = int(data[11])
		if data[12] != null:
			Global.jumpsh = int(data[12])
		if data[13] != null:
			Global.jumpshx2 = int(data[13])
		if data[14] != null:
			Global.hpsh = int(data[14])
		if data[15] != null:
			Global.dogsh = int(data[15])
		if data[16] != null:
			Global.batsh = int(data[16])
		if data[17] != null:
			Global.korzsh = int(data[17])
		#для ящика
		if data[18] != null:
			Global.rezhim_yach = int(data[18])
		#скины
		if data[19] != null:
			Global.GG = int(data[19])
		if data[20] != null:
			Global.Knopka1 = int(data[20])
		if data[21] != null:
			Global.Knopka2 = int(data[21])
		if data[22] != null:
			Global.Knopka3 = int(data[22])
		if data[23] != null:
			Global.Knopka4 = int(data[23])
		#язык
		if data[24] != null:
			Global.Language = String(data[24])
		if data[25] != null:
			Global.novosti = String(data[25])
		#стоимость улучшений
		if data[26] != null:
			Global.money_korz = int(data[26])
		if data[27] != null:
			Global.money_batut = int(data[27])
		if data[28] != null:
			Global.money_jumpx2 = int(data[28])
		if data[29] != null:
			Global.money_speedx2 = int(data[29])
		if data[30] != null:
			Global.money_dog = int(data[30])
		if data[31] != null:
			Global.money_hp = int(data[31])
		if data[32] != null:
			Global.money_jump = int(data[32])
		if data[33] != null:
			Global.money_speed = int(data[33])
		#бафы от улучшений
		if data[34] != null:
			Global.kolvo_sbor_apple = int(data[34])
		if data[35] != null:
			Global.jump_prokac = int(data[35])
		if data[36] != null:
			Global.rivok_prokac = int(data[36])
		if data[37] != null:
			Global.block_time = int(data[37])
		if data[38] != null:
			Global.HP_MAX = int(data[38])
		if data[39] != null:
			Global.jump_prokach = int(data[39])
		if data[40] != null:
			Global.speed_prokac = int(data[40])
		
func load_resources():
	#Загрузка сохранений
	Bridge.storage.get(["gold",
		"hi_score","very_score","HP_chet","apple_razbilos","speed_stats","jump_stats","def_stats","gold_stats","common_apple",
		"skorsh","skorshx2","jumpsh","jumpshx2","hpsh","dogsh","batsh","korzsh",
		"rezhim_yach",
		"GG","Knopka1","Knopka2","Knopka3","Knopka4",
		"Language","novosti",
		"money_korz","money_batut","money_jumpx2","money_speedx2","money_dog","money_hp","money_jump","money_speed",
		"kolvo_sbor_apple","jump_prokac","rivok_prokac","block_time","HP_MAX","jump_prokach","speed_prokac"], Callable(self, "_on_storage_get_completed"))

	# Имитация загрузки игры
	var loaded_resources = 0
	progress_bar.value = (loaded_resources)
	await get_tree().create_timer(0.6).timeout

	for resource_path in 100:
		# полоска загрузки поехала
		loaded_resources += 1
		# Обновление прогресс бара
		progress_bar.value = (loaded_resources * 1)

		# Задержка в 0.02 секунды с использованием await для имитации загрузки
		await get_tree().create_timer(0.02).timeout
		
	#подождать 0,5 секунд для перехода в меню
	await get_tree().create_timer(0.5).timeout
	#экран загрузки отработал своё
	Global.zagruzka = false #Загрузка игры закончена
	Bridge.platform.send_message("game_ready")
	Global.menuska = true
	get_tree().change_scene_to_file("res://menu.tscn")
	Global.menu.play()
	# Информация по управлению
	Global.upravl_otkr = true
