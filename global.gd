extends Node

#музыка
@onready var menu = $"Музыка/в меню/menu_muz"
@onready var lvl = $"Музыка/Во время игры/lvl"
#звуки
@onready var veter = $"Звуки/Ветер/veter"
@onready var plus_ochkii = $"Звуки/Яблоки/Общее/+очки"
@onready var minus_ochki = $"Звуки/Яблоки/Общее/-очки"
@onready var apple_skor = $"Звуки/Яблоки/Звуки улучшенных яблок/skor"
@onready var apple_jump = $"Звуки/Яблоки/Звуки улучшенных яблок/jump"
@onready var minus_def = $"Звуки/Яблоки/Звуки улучшенных яблок/Потеря защиты"
@onready var apple_def1 = $"Звуки/Яблоки/Звуки улучшенных яблок/собрал 1 яблоко защиты"
@onready var apple_def2 = $"Звуки/Яблоки/Звуки улучшенных яблок/собрал 2 яблока защиты"
@onready var apple_deas_zvuk = $"Звуки/Яблоки/Общее/apple_death"
@onready var apple_gold2 = $"Звуки/Яблоки/Звуки улучшенных яблок/gold"
@onready var ezhik_smex = $"Звуки/Ёжик/смех ёжика"
@onready var heals = $"Звуки/Яблоки/Общее/хил"
var healss = false
var damagess = false


@onready var muzik = $"Главное меню/musek2"
@onready var muz_on = $"Главное меню/musek2/Musek"
@onready var muz_off = $"Главное меню/musek2/Musek1"

@onready var muzik_eff = $"Главное меню/musek3"
@onready var muz_eff_on = $"Главное меню/musek3/EffectOn"
@onready var muz_eff_off = $"Главное меню/musek3/EffectOff"

@onready var esceip = $"Главное меню/esc"
@onready var esc_on = $"Главное меню/esc/Esc2"
@onready var esc_off = $"Главное меню/esc/Esc"

@onready var information = $info
@onready var information_on = $info/Kniga2
@onready var information_off = $info/Kniga

@onready var koin = $"Главное меню/Koin"
@onready var gold_menu = $"Главное меню/gold"

@onready var glav_menu = $"Главное меню"


#Общие настройки
var Language = "RU" #язык игрока (потом будет загружаться, в завимости от выбора игрока)
var winda #показывает на пк или на телефоне играю
var novosti = "new" #new - новость есть, pro - прочитано, chit - читаю
var upravl_otkr = true # true - в начале игры открывает окно управления игры, false - скрывает это окно

#всё для книги помощи
var stranica #показывает, какая сейчас страница
var razdel #для 4книги, что не создавать много других разделов
var gde_i_shas #местоположение, откуда нажал на подсказку игрок

#Предзагрузка
var batutiks = preload("res://batut.tscn")
var korzinkas = preload("res://korzinka.tscn")
var kniga4 = preload("res://книга4.tscn")
var player = preload("res://player.tscn")
var ezhik = preload("res://ёжик.tscn")
var bird1 = preload("res://птица.tscn")
var applez = preload("res://apple.tscn")
var apple_beds = preload("res://apple_bed.tscn")
var apple_runs = preload("res://apple_run.tscn")
var apple_jumps = preload("res://apple_jump.tscn")
var apple_deafs = preload("res://apple_def.tscn")
var apple_golds = preload("res://apple_gold.tscn")
#яблоки просто лежат сверху на ящике
var apple_on_batut = preload("res://apple_on_batut.tscn")
var apple_run_on_batut = preload("res://apple_run_on_batut.tscn")
var apple_jump_on_batut = preload("res://apple_jump_on_batut.tscn")
var apple_def_on_batut = preload("res://apple_def_on_batut.tscn")
var apple_gold_on_batut = preload("res://apple_gold_on_batut.tscn")
#трава
var trava = preload("res://трава.tscn")

#Респавн игрока (менюшка)
var resp_monet = 40 #изначально респ стоит 40 монет
var respawn = false #функция, которая показывает, что включен респавн

#Музыка
var def_brok = false #Звук сломанного щита
var ochki_minus = false #Звук -очков
var plus_ochki = false #Звук +очки
var plus_speed = false #Звук скорости
var plus_jump = false #Звук прыжка
var plus_def1 = false #Звук защиты 1
var plus_def2 = false #Звук защиты 2
var plus_gold = false #Звук золотого яблока


#циферки для игры
var score : int #счет во время игры
var razn = score #разница, нужно для определения, сколько высветится яблок при ловле
var hi_score : int #рекорд
var very_score : int #сколько яблок собрал за всё время
var gold : int #монеты
var HP #Здоровье в данный момент, которое меняется во время боя
var HP_MAX = 3 #Максимальное здоровье игрока (в начале 3 потом до 6 поднять можно)
var HP_chet = 0 #для статистики hp


#всё для яблок
var dobr #тип яблока №1
var pozicia = 0 #чтобы яблоки спавнились корректно, нужно считать сколько яблок не разбилось
var apple_spawn = true #спавн яблок
var skorostapple = 120 #изначальная скорость падения яблока
var one_raz = true #чтоб при усложнении когда будет счет 5, если пойдет в минус очки, то сложность не менялась

#Для ГГ
var GG : int #Как только игрок запускает игру - скин будет стандартный, т.е. = 0, потом уже можно во вкладе со скинами менять данный параметр, в том числе и как будет выглядеть персонаж.
var GG_one_raz = true #нужно для того, чтобы в главном меню менялась моделька главного героя 1 раз
var player_spawn = false #спавн ГГ
var korz_na_golove = 0 #Положение корзинки, 0 – корзинка остается в последнем положении где была, -1, опустить корзинку, 1 поднять корзинку
var smotru : String #right - смотрю направо, left - смотрю налево
var block_dmg = false # блок урона для ГГ
var neuaz_one_raz = false #чтоб 1 раз сработало и повесить иконку под ХП
var poluch_dmg = false
var neuaz = false # неуязвимость
var migaet_gg = false # Проверяет, чтоб ГГ мигал
var sdelal_jump = false #проверяет, сделал ли гг прыжок, false когда на земле гг
var sdelal_jumpx2 = false #проверяет, сделал ли гг двойной прыжок, false когда на земле гг
var tolkay = false #нужно для анимации толкания батута
var run_left #нужно для кнопки влево для мобилки
var avto_modes = false # значение истино, когда нужно персонажу автоматически пройти без участия игрока
var prighul_dla_bat = false #нужно чтобы понять, когда в зоне толкания игрок прыгнул

#Скины
var Knopka1 : int #Выбрано (0-выбрано,-1-выбрать)
var Knopka2 : int #Предлагает купить (0-купить, 1-выбрано, -1-выбрать)
var Knopka3 : int #Недоступно (0-недоступно, 1-купить, 2-выбрано, -1-выбрать)
var Knopka4 : int #Недоступно (0-недоступно, 1-купить, 2-выбрано, -1-выбрать)
var GG2 = 150 #цена второго скина
var GG3 = 275 #цена третьего скина
var GG4 = 350 #цена четвертого скина
	
#Ёжик
var ezhik_spawn = false #спавн ёжика
var speed_ezh = 0 #влево или вправо побежит ёжик
#var razok_ezhik = true #чтоб один раз пошел влево или вправо
var polozhenie_ezhika = 0 #Для понимания, что ёжик бежит или несёт что-то на своих иголках
var deaf_live_ezhik # проверка на жив ли щит ёжика или закончился
var speeds_sonikx = 0 # ДОП скорость ёжика за усложнение
var spawn_2_ezhika_eshe #спавнит ещё двух ёжиков при золотом яблоке
var poimal_gold_apple #проверяет, поймал ёжик яблоко золотое или заспавнился уже с ним (чтобы таймер поставить на спавн)
var ezhik_smex_gold_apple #запускает звук смеха ёжика

#Птица
var bird_spawn #проверка на спавн птицы
var napravlenie_bird #направление птицы
var polozhenie_bird #определяет с каким яблоком летит птица
var schet_bird = 0 #изначально 0 птиц
var deaf_live_bird = false #нет щита у птицы
var nomer_bird = 0 #нумерует птиц, изначально 0
#передает значение какое яблоко заспавнить
var zaspawn_apple_one #передает значение какое яблоко заспавнить
var zaspawn_apple_two #передает значение какое яблоко заспавнить
var zaspawn_apple_three #передает значение какое яблоко заспавнить
var zaspawn_apple_four #передает значение какое яблоко заспавнить
var zaspawn_apple_five #передает значение какое яблоко заспавнить
#координаты птиц
var koordinati_one #координаты первой птицы
var koordinati_two #координаты второй птицы
var koordinati_three #координаты третьей птицы
var koordinati_four #координаты четвертой птицы
var koordinati_five #координаты пятой птицы
#проверка на спавн яблока
var spawn_mozno_one #можно заспавнить первое яблоко
var spawn_mozno_two #можно заспавнить второе яблоко
var spawn_mozno_three #можно заспавнить третье яблоко
var spawn_mozno_four #можно заспавнить четвертое яблоко
var spawn_mozno_five #можно заспавнить пятое яблоко
# ДОП скорость птицы за усложнение
var speeds_birds_dop = 0

#Для ящик
var bat_spawn = false #спавн ящика
var skor_bat = 0 #скорость ящика
var tolkay_left = false #толкаю ящик влево
var tolkay_right = false #толкаю ящик вправо
var prikosnovenie_left_bat #проверка на прикосновение с левой стороны
var prikosnovenie_right_bat #проверка на прикосновение с правой стороны
var sam_process_tolkania_bat = false #определяет, толкаю сейчас ящик или нет (true или false)
var kolvo_sbor_apple #число, сколько яблок помещается в ящике (максимум 3, минимум 1)
var deas_apple_v_uachike = false #функция по уничтожению яблок в ящике
var spawnis_apple_yach_1 = "-" #что удалять в ящике
var rezhim_yach = 0 #определяет режим ящика (0 - нет ящика, -1 - выключен, 1 - первый режим)

#так же для ящика но для понимания по каким координатам заспавнить яблоко в ящике

#место для базового яблока
var spawn_applez
#место для яблока скорости
var spawn_apple_run
#место для яблока прыгучести
var spawn_apple_jump
#место для яблока защиты
var spawn_apple_def
#место для золотого яблока
var spawn_apple_gold
#нужно для определения занятости слотов для ящика
var one_zanat_slot = true
var two_zanat_slot = true
var three_zanat_slot = true

#Для корзинки
var skor_korz = 0 #скорость корзинки
var bros = true #заспавнить корзинку
var bros_dla_int = false #бросить корзинку
var zadat_skor = false #нужно, чтоб в начале корзинка подлетела, а потом начала падать
var migaet_korz = 0 # 0 положение idle, 1 мигает, 2 исчезает и переходит в положение 0
var kol_vo_nazati_korz = 0 #изначально у корзинки 0 нажатий
var one_raz_korz = true #чтобы 1 раз сработал таймер на уничтожение временной корзинки
var tp_korz_left = false #чтобы когда перемещаюсь на другую сторону корзинка тоже тпшиться
var tp_korz_right = false #чтобы когда перемещаюсь на другую сторону корзинка тоже тпшиться

#Для ветра
var veter_one_raz = false # чтоб функция ветра сработала 1 раз
var veter_timer = 0 #для отображения сек, сколько будет дуть ветер

#Кнопочки для меню
var onli_menu = true
var pokaz_info = false #показывать текст при наведении на иконки
var pokaz_muz1 = false
var pokaz_muz2 = false
var pokaz_esc = false #показывать и скрывать меню с кнопочками

var skrit_chet = false
var skrit_gold = false
var skrit_record = false
var spawn_apple_menu = 0 #спавнит до 10 яблок в меню (оптимизация)


#пауза отключена
var pause: bool = false 

#Общее положение дерева и когда дует ветер
var tree = 0 #Положение дерева (0 всё как обычно, 1 – чуть дует вправо, 2 – дует вправо, 3 – потихоньку утихает ветер, -1 -2 и -3 тоже самое, но только влево)


#бафы от яблок
var baf_skor_apple = 0  #Циферки на баф скорости ГГ от яблока (200 ед.)
var baf_jump_apple = 0 #Циферки на баф прыжка ГГ от яблока (-200 ед.)
var baf_jump_apple_prov = false
var deaf = 0
var baf_jump = false #показывает, получил ли баф ГГ или его сейчас нет (0 - нет бафа, 1 - получил баф, 2 - закончился баф и перевел в 0)
var baf_speed = false

var baf_SPEED = false #показывает, получил ли баф ГГ или его сейчас нет (0 - нет бафа, 1 - получил баф, 2 - закончился баф и перевел в 0)
var baf_JUMP = false #показывает, получил ли баф ГГ или его сейчас нет (0 - нет бафа, 1 - получил баф, 2 - закончился баф и перевел в 0)

var kolvо_bafs = 0 #сколько у ГГ сейчас активно бафов
var apple_deas = false


#бафы из магазина
var speed_prokac = 0

var rivok_prokac = 0 #в магазине прокачка рывка
var jump_prokac = 0 #в магазине прокачка прыжка
var JUMP_mozno = true #чтоб двойной прыжок сработал 1 раз и потом на перезарядку
var jumpx2_dla_int = false #Совершить двойной прыжок
var rivok = false # когда совершаю рывок, для анимации нужно
var tolk_bat = false # когда толкаю батут, для анимации нужно
var rivok_dla_int = false #Совершить рывок
var block_time = 4 #Время, которое блокируется урон (4 сек изначально, максимум 8)
var rivok_mozno = true
var jump_prokach = 0

#получение урона и восстановление здоровья
var damage = false
var heal = false

var chet = 0 #Счётчик для увеличения сложности
var hard = 0 #Сложность

var musek = true
var musek_efect = true

var menuska #Функция, чтобы музыка главного меню не играла во время основной игры

var mozno_nazat_na_knopku_tolk #нужно, чтобы корректно и 1 раз срабатывала кнопка

var delete_apples = false
var esc = false #меню
var info = false #информация

#статистика яблок
var apple_razbilos = 0 #статистика по кол-ву разбитых яблок
var speed_stats = 0
var jump_stats = 0
var def_stats = 0
var gold_stats = 0
var common_apple = 0

#уровни прокачки
var skorsh = 0
var jumpsh = 0
var skorshx2 = 0
var jumpshx2 = 0
var hpsh = 0
var dogsh = 0
var batsh = 0
var korzsh = 0

#циферки за сколько улучшается
var money_speed = 125
var money_jump = 100
var money_speedx2 = 125
var money_jumpx2 = 125
var money_hp = 175

var money_dog = 100
var money_batut = 200
var money_korz = 200

var anim_bat = false
var jump_pl = false

var zagruzka #загрузка игры

var Nagrada_reklama = false #дает награду за рекламу

var paus = false #пауза во время игры
var pauss = false #пауза в меню

var reward_received = false


var one_raz_veter_muzek = true
	
func _ready() -> void:
	#нужно для смены вкладок, чтобы ставить игру на паузу
	get_viewport().focus_entered.connect(_focus_in)
	get_viewport().focus_exited.connect(_focus_out)
	

func _focus_in():
	if zagruzka == false:
		if reward_received == true: #игра снова сможет корректно работать, когда поставить на паузу
			Bridge.platform.send_message("in_game_loading_started")
			paus = false
			Global.esc = false
			reward_received = false
func _focus_out():
	if zagruzka == false:
		if reward_received == false and Global.menuska == false and respawn == false: #до просмотра рекламы
			Bridge.platform.send_message("in_game_loading_stopped")
			paus = true
			Global.esc = true


func _process(_delta: float) -> void:
	muz() #вся музыка тут
	otobrazhenie_knopok_menu() #отображает кнопки в самом меню
	
	if Input.is_action_just_pressed("esc") and menuska == true and Global.info == false:
		Global.esc = !Global.esc
				
func _on_musek_2_pressed():
	Global.musek = ! Global.musek
	if Global.musek == true:
		Global.menu.play()
	else:
		Global.menu.stop()

func _on_musek_3_pressed():
	Global.musek_efect = ! Global.musek_efect

func _on_esc_pressed():
	Global.esc = ! Global.esc
		
func _on_info_pressed():
	Global.info = ! Global.info
	if Global.info == true and Global.menuska == true:
		Global.stranica = 1
		if Global.gde_i_shas == "menu":
			Global.razdel = "nachalo"
		if Global.gde_i_shas == "shop":
			Global.razdel = "shop"
		if Global.gde_i_shas == "stats":	
			Global.razdel = "stats"
		if Global.gde_i_shas == "skins":
			Global.razdel = "skins"
		if Global.gde_i_shas == "lvl":
			Global.razdel = "lvl"
		if Global.gde_i_shas == "Interface":
			Global.razdel = "Interface"
		if Global.gde_i_shas == "apple":
			Global.razdel = "apple"
		if Global.gde_i_shas == "prepatstvia":
			Global.razdel = "prepatstvia"
		glav_menu.visible = false
		get_tree().change_scene_to_file("res://книга4.tscn")
		information_off.visible = false
		information_on.visible = true
		
	if Global.info == false and Global.menuska == true:
		if Global.gde_i_shas == "menu":
			get_tree().change_scene_to_file("res://menu.tscn")
		if Global.gde_i_shas == "stats":
			get_tree().change_scene_to_file("res://stats.tscn")
		if Global.gde_i_shas == "shop":
			get_tree().change_scene_to_file("res://shop.tscn")
		if Global.gde_i_shas == "skins":
			get_tree().change_scene_to_file("res://Скины.tscn")
		if Global.gde_i_shas == "lvl":
			get_tree().change_scene_to_file("res://level.tscn")
		Global.GG_one_raz = true #Обновить отображение скина в главном меню
		glav_menu.visible = true
		information_off.visible = true
		information_on.visible = false
		
func muz(): #всё связанное с музыкой
	if def_brok == true:
		def_brok = false
		minus_def.play()
	if plus_ochki == true:
		plus_ochki = false
		plus_ochkii.play()
	if ochki_minus == true:
		ochki_minus = false
		minus_ochki.play()
	if plus_speed == true:
		plus_speed = false
		apple_skor.play()
	if plus_jump == true:
		plus_jump = false
		apple_jump.play()
	if plus_def1 == true:
		plus_def1 = false
		apple_def1.play()
	if plus_def2 == true:
		plus_def2 = false
		apple_def2.play()
	if plus_gold == true:
		plus_gold = false
		apple_gold2.play()
	if apple_deas == true:
		apple_deas = false
		apple_deas_zvuk.play()
	if healss == true:
		healss = false
		Global.heals.play()
	if ezhik_smex_gold_apple == true:
		ezhik_smex_gold_apple = false
		ezhik_smex.play()
		
	#звук ветра
	if Global.musek_efect == true and Global.menuska == false:	
		if not Global.tree == 0 and one_raz_veter_muzek == true:
			one_raz_veter_muzek = false
			veter.play()
		if Global.tree == 0:
			one_raz_veter_muzek = true
			veter.stop()
	if Global.musek_efect == false or Global.menuska == true: 	
		one_raz_veter_muzek = true
		veter.stop()

func otobrazhenie_knopok_menu(): #отображает кнопки в самом меню
	gold_menu.text = str(Global.gold)
	#во время загрузки и после загрузки игры
	if gde_i_shas == "menu":
		esceip.visible = true
		$"Новости".visible = true
		if Global.novosti == "new":
			$"Новости/НовостиНеПрочитано".visible = true
			$"Новости/НовостиПрочитано".visible = false
			$"Новости/НовостиЧитаю".visible = false
		if Global.novosti == "pro":
			$"Новости/НовостиПрочитано".visible = true
			$"Новости/НовостиНеПрочитано".visible = false
			$"Новости/НовостиЧитаю".visible = false
		if Global.novosti == "chit":
			$"Новости/НовостиЧитаю".visible = true
			$"Новости/НовостиНеПрочитано".visible = false
			$"Новости/НовостиПрочитано".visible = false
	else:
		$"Новости".visible = false
	if menuska == true and info == false and zagruzka == false and (novosti == "new" or novosti == "pro"): #Если открыто главное меню
		glav_menu.visible = true
	if menuska == true and info == false and zagruzka == false and (novosti == "chit"): #Если открыты новости
		glav_menu.visible = false
		$"Новости".visible = true
		esc = false
	if menuska == true and info == true and zagruzka == false: #Если открыта книга помощи
		$"Новости".visible = false
		
	if menuska == true:	
		#Пауза раскрывается и скрывается
		if Global.esc == false:
			esc_on.visible = false
			esc_off.visible = true
			muzik.visible = false
			muzik_eff.visible = false
			information.visible = false
		else:
			esc_on.visible = true
			esc_off.visible = false
			muzik.visible = true
			muzik_eff.visible = true
			information.visible = true
			
		if Global.musek == true:
			muz_on.visible = true
			muz_off.visible = false
		else:
			muz_on.visible = false
			muz_off.visible = true
		if Global.musek_efect == true:
			muz_eff_on.visible = true
			muz_eff_off.visible = false	
		else:
			muz_eff_on.visible = false
			muz_eff_off.visible = true
			
	if menuska == false:	
		glav_menu.visible = false
		information.visible = false
		
#для яндекса функции
func liderbord(): #сохраняет в лидерборд рекорд
	var options
	
	match Bridge.platform.id:
		"yandex":
			options = {
				"leaderboardName": "liders",
				"score": Global.hi_score
			}
	Bridge.leaderboard.set_score(options, Callable(self, "_on_set_score_completed"))
	print("Рекорд сохранен")
	
func _on_set_score_completed(success):
	print(success)	
	
func saveYandexznachenia(): #Сохраняет всё что было заработано за время игры
	Bridge.storage.set(["gold","hi_score","very_score","HP_chet","apple_razbilos","speed_stats","jump_stats","def_stats","gold_stats","common_apple"], [Global.gold, Global.hi_score, Global.very_score, Global.HP_chet, Global.apple_razbilos, Global.speed_stats, Global.jump_stats, Global.def_stats, Global.gold_stats, Global.common_apple])
	print("Заработанные знчения за игру сохранены")


func _on_новости_pressed() -> void:
	if novosti == "new" or novosti == "pro":
		novosti = "chit"
		glav_menu.visible = false
		esc = false
		get_tree().change_scene_to_file("res://новости.tscn")
	elif novosti == "chit":
		novosti = "pro"
		Bridge.storage.set(["novosti"], [novosti])
		glav_menu.visible = true
		Global.GG_one_raz = true #Обновить отображение скина в главном меню
		get_tree().change_scene_to_file("res://menu.tscn")
