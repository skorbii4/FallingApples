extends Node2D

@onready var anim = $"skin/1_GG"
@onready var ru = $"язык игры/ЯзыкРусский"
@onready var en = $"язык игры/ЯзыкАнгл"
@onready var play1 = $play
@onready var play2 = $play2


func _ready() -> void:
	Global.gde_i_shas = "menu"
	Global.menuska = true
	Bridge.platform.send_message("gameplay_stopped") #игра приостановлена
	Bridge.advertisement.show_interstitial() #показать рекламу
	afk_gg()#в меню обновляет игрока
	platforma_game() #определяет играю я на телефоне или на компе
	saveYandexznachenia() #Сохраняет рекорд за время игры
	
	if Global.Language == "RU":
		ru.visible = true
		en.visible = false
		play1.text = str ("Играть")
		play2.text = str ("Играть")
	if Global.Language == "EN":
		en.visible = true
		ru.visible = false
		play1.text = str ("Play")
		play2.text = str ("Play")
	
func _on_set_score_completed(success):
	print(success)

func afk_gg(): #в меню обновляет игрока	
	if Global.GG_one_raz == true:
		Global.GG_one_raz = false
		if Global.GG == 0:
			anim.play("1AFK")
		if Global.GG == 1:
			anim.play("2AFK")
		if Global.GG == 2:
			anim.play("3AFK")
		if Global.GG == 3:
			anim.play("4AFK")
		
func _on_play_2_pressed() -> void:
	obnovlenie_vsex()#обновление глобала
	Global.menu.stop()
	Global.lvl.play()
	#игра началась
	get_tree().change_scene_to_file("res://level.tscn")
	
func _on_shop_pressed():
	Global.onli_menu = false
	Global.esc = false
	get_tree().change_scene_to_file("res://shop.tscn")
	
func _on_stats_pressed():
	Global.onli_menu = false
	Global.esc = false
	get_tree().change_scene_to_file("res://stats.tscn")
		
func _on_skin_pressed():
	Global.onli_menu = false
	get_tree().change_scene_to_file("res://Скины.tscn")
	Global.esc = false

func _on_shop_mouse_entered():
	$shop/Koin.visible = false
	$shop/koin2.visible = true
	$shop/koin2.play("koin")
func _on_shop_mouse_exited():
	$shop/Koin.visible = true
	$shop/koin2.visible = false

func _on_skin_mouse_entered():
	if Global.GG == 0:
		anim.play("1ANIM")
	if Global.GG == 1:
		anim.play("2ANIM")
	if Global.GG == 2:
		anim.play("3ANIM")
	if Global.GG == 3:
		anim.play("4ANIM")
func _on_skin_mouse_exited():
	if Global.GG == 0:
		anim.play("1AFK")
	if Global.GG == 1:
		anim.play("2AFK")
	if Global.GG == 2:
		anim.play("3AFK")
	if Global.GG == 3:
		anim.play("4AFK")

func _on_stats_mouse_entered():
	$stats/Korz.play("korz")
func _on_stats_mouse_exited():
	$stats/Korz.play("idle")


func _on_play_mouse_entered() -> void:
	play1.visible = false
	play2.visible = true
	if Global.Language == "RU":
		play2.text = str ("Играть")
	if Global.Language == "EN":
		play2.text = str ("Play")
func _on_play_2_mouse_exited() -> void:
	play1.visible = true
	play2.visible = false

func platforma_game(): #отображает на какой платформе играю и в случае чего скрывает кнопкидля мобилки
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		Global.winda = false
	else:
		Global.winda = true

func _on_язык_игры_pressed(): #язык игры
	if Global.Language == "RU":
		Global.Language = "EN"
		Bridge.storage.set(["Language"], [Global.Language])
		en.visible = true
		ru.visible = false
		play1.text = str ("Play")
		play2.text = str ("Play")
	else:
		Global.Language = "RU"
		Bridge.storage.set(["Language"], [Global.Language])
		ru.visible = true
		en.visible = false
		play1.text = str ("Играть")
		play2.text = str ("Играть")

func obnovlenie_vsex():#обновление глобала
	Global.paus = false
	Global.respawn = false
	Global.kol_vo_nazati_korz = 0
	Global.esc = false #Отключаем выполнение выхода (на всякий случай)
	Global.avto_modes = false #отключаем автомод
	
	#очки ставим на 0
	Global.score = 0
	if not Global.hi_score:
		Global.hi_score = 0
	Global.razn = Global.score
	
	#корзинка и рывок
	Global.bros = true #бросить корзинку
	Global.migaet_korz = 0
	Global.rivok_mozno = true
	
	#обновляет возможность прыгать
	if Global.jump_prokac >= 1: # на двойной прыжок права
		Global.JUMP_mozno = true
	else:
		Global.JUMP_mozno = false
	Global.jump_pl = false
	
	Global.ezhik_spawn = false #Выключает ёжика (надо, он потом во время игры сам включится)
	Global.polozhenie_ezhika = 0
	Global.deaf_live_ezhik = 0 # щит ёжика не активен
	
	Global.block_dmg = false # Выключает блок у ГГ
	Global.neuaz_one_raz = false # отключить неуязвимость
	
	
	Global.apple_spawn = true #при выходе в меню стоял false
	Global.player_spawn = true #можно заспавнить игрока
	Global.menuska = false #заход на уровень
	
	Global.delete_apples = true #Запустить функцию удаления яблок

	#Ставим все положения Яблок, Ветра и их перемещения на стандарт
	Global.tree = 0
	
	#Ставим все бафы и положение корзинки на 0
	Global.korz_na_golove = 0
	Global.baf_skor_apple = 0
	Global.baf_jump_apple = 0
	Global.baf_jump_apple_prov = false
	Global.kolvо_bafs = 0
	
	#Отключаем бонусы от яблок
	Global.damage = false
	Global.heal = false
	Global.deaf = 0
	Global.baf_speed = false
	Global.baf_jump = false
	#доп скорость птицы и ёжика обнуляем
	Global.speeds_sonikx = 0
	Global.speeds_birds_dop = 0
	#обновляет список монет за возрождение
	Global.resp_monet = 40
	
	#отображение языка
	if Global.Language == "RU":
		ru.visible = true
		en.visible = false
		play1.text = str ("Играть")
	else:
		en.visible = true
		ru.visible = false
		play1.text = str ("Play")

func saveYandexznachenia(): #Сохраняет рекорд за время игры
	Bridge.storage.set(["gold","hi_score","very_score","HP_chet","apple_razbilos","speed_stats","jump_stats","def_stats","gold_stats","common_apple"], [Global.gold, Global.hi_score, Global.very_score, Global.HP_chet, Global.apple_razbilos, Global.speed_stats, Global.jump_stats, Global.def_stats, Global.gold_stats, Global.common_apple])
