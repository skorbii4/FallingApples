extends Node2D

@onready var lab1 = $CanvasLayer/Label4
@onready var lab2 = $CanvasLayer/Label5
@onready var lab3 = $CanvasLayer/Label3
@onready var lab4 = $CanvasLayer/Label6
@onready var lab5 = $CanvasLayer/Label2
@onready var lab6 = $CanvasLayer/Label7
@onready var lab7 = $CanvasLayer/Label
@onready var lab8 = $CanvasLayer/Label8
var buy = false

func _ready() -> void:
	saveYandex()#сохранение значений для яндекса в магазине
	Global.gde_i_shas = "shop"
	if Global.rezhim_yach == 0:
		$Button.visible = false
	else:
		$Button.visible = true
	if Global.rezhim_yach == 1:
		$"1Режим".visible = true
		$"0Выкл".visible = false
		$"1Режим/режим".visible = true
	if Global.rezhim_yach == 3:
		$"0Выкл".visible = true
		$"1Режим".visible = false
		$"1Режим/режим".visible = false


func _process(delta: float) -> void:
	buyi()# меняется цвет если можно улучшить или наоборот если не хватает
	
	text_vivod_na_ekran()#выводит цифры сколько стоит улучшения
	
	animatia_prokacki()#анимация полосок прокачки, их покупка и во время покупки мигает
	
	menaytsa_str()#меняются страницы
	
	language() #текст меняется в зависимости от языка
			
func _on_manu_pressed():
	Global.onli_menu = true
	Global.GG_one_raz = true #Обновить отображение скина в главном меню
	get_tree().change_scene_to_file("res://menu.tscn")
	
		
#выводит цифры сколько стоит улучшения
func text_vivod_na_ekran():
	$CanvasLayer/Label4.text = str(Global.money_speed)
	$CanvasLayer/Label3.text = str(Global.money_jump)
	$CanvasLayer/Label5.text = str(Global.money_speedx2)
	$CanvasLayer/Label6.text = str(Global.money_jumpx2)
	$CanvasLayer/Label2.text = str(Global.money_hp)
	
	$CanvasLayer/Label7.text = str(Global.money_korz)
	$CanvasLayer/Label8.text = str(Global.money_batut)
	$CanvasLayer/Label.text = str(Global.money_dog)

#меняется цвет если можно улучшить или наоборот если не хватает
func buyi():
	if Global.gold >= Global.money_speed:
		$CanvasLayer/Label4.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_speedx2:
		$CanvasLayer/Label5.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_jump:
		$CanvasLayer/Label3.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_jumpx2:
		$CanvasLayer/Label6.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_hp:
		$CanvasLayer/Label2.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_dog:
		$CanvasLayer/Label.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_batut:
		$CanvasLayer/Label8.modulate = Color(0, 139, 0)
	if Global.gold >= Global.money_korz:
		$CanvasLayer/Label7.modulate = Color(0, 139, 0)
		
	if Global.gold < Global.money_speed:
		$CanvasLayer/Label4.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_speedx2:
		$CanvasLayer/Label5.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_jump:
		$CanvasLayer/Label3.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_jumpx2:
		$CanvasLayer/Label6.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_hp:
		$CanvasLayer/Label2.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_dog:
		$CanvasLayer/Label.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_batut:
		$CanvasLayer/Label8.modulate = Color(139, 0, 0)
	if Global.gold < Global.money_korz:
		$CanvasLayer/Label7.modulate = Color(139, 0, 0)

#анимация полосок прокачки, их покупка и во время покупки мигает
func animatia_prokacki():
	#скорость
	if Global.skorsh >= 1:
		$"1kn/1".play("vs")
	if Global.skorsh >= 2:
		$"1kn2/2".play("vs")
	if Global.skorsh >= 3:
		$"1kn3/3".play("vs")
		lab1.visible = false
		$Koin10.visible = false
		$"пояснение монеты".visible = false
		$"монетка бай и пояснение".visible = false
		$max_lvl.visible = true
		$"монетка сменяется на макс прокачка".visible = true
	
	if Global.gold >= Global.money_speed:
		if Global.skorsh == 0:
			$"1kn/1".play("buy")
		if Global.skorsh == 1:
			$"1kn2/2".play("buy")
		if Global.skorsh == 2:
			$"1kn3/3".play("buy")
		$Koin10.play("buy_gold")
	
	if Global.gold < Global.money_speed:
		if Global.skorsh == 0:
			$"1kn/1".play("default")
		if Global.skorsh == 1:
			$"1kn2/2".play("default")
		if Global.skorsh == 2:
			$"1kn3/3".play("default")
		$Koin10.play("idle_gold")
		
	#скорость x2
	if Global.skorshx2 >= 1:
		$"1kn4/11".play("vs")
	if Global.skorshx2 >= 2:
		$"1kn5/12".play("vs")
	if Global.skorshx2 >= 3:
		$"1kn6/13".play("vs")
		lab2.visible = false
		$Koin8.visible = false
		$"пояснение монеты4".visible = false
		$"монетка бай и пояснение5".visible = false
		$max_lvl5.visible = true
		$"монетка сменяется на макс прокачка5".visible = true
	
	if Global.gold >= Global.money_speedx2:
		if Global.skorshx2 == 0:
			$"1kn4/11".play("buy")
		if Global.skorshx2 == 1:
			$"1kn5/12".play("buy")
		if Global.skorshx2 == 2:
			$"1kn6/13".play("buy")
		$Koin8.play("buy_gold")
			
	if Global.gold < Global.money_speedx2:
		if Global.skorshx2 == 0:
			$"1kn4/11".play("default")
		if Global.skorshx2 == 1:
			$"1kn5/12".play("default")
		if Global.skorshx2 == 2:
			$"1kn6/13".play("default")
		$Koin8.play("idle_gold")
	
	#прыжок
	if Global.jumpsh >= 1:
		$"1kn7/4".play("vs")
	if Global.jumpsh >= 2:
		$"1kn8/5".play("vs")
	if Global.jumpsh >= 3:
		$"1kn9/6".play("vs")
		lab3.visible = false
		$Koin9.visible = false
		$"пояснение монеты1".visible = false
		$"монетка бай и пояснение2".visible = false
		$max_lvl2.visible = true
		$"монетка сменяется на макс прокачка2".visible = true
		
	if Global.gold >= Global.money_jump:
		if Global.jumpsh == 0:
			$"1kn7/4".play("buy")
		if Global.jumpsh == 1:
			$"1kn8/5".play("buy")
		if Global.jumpsh == 2:
			$"1kn9/6".play("buy")
		$Koin9.play("buy_gold")
			
	if Global.gold < Global.money_jump:
		if Global.jumpsh == 0:
			$"1kn7/4".play("default")
		if Global.jumpsh == 1:
			$"1kn8/5".play("default")
		if Global.jumpsh == 2:
			$"1kn9/6".play("default")
		$Koin9.play("idle_gold")
			
	#прыжок x2
	if Global.jumpshx2 >= 1:
		$"1kn14/14".play("vs")
	if Global.jumpshx2 >= 2:
		$"1kn15/15".play("vs")
	if Global.jumpshx2 >= 3:
		$"1kn16/16".play("vs")
		lab4.visible = false
		$Koin7.visible = false
		$"пояснение монеты5".visible = false
		$"монетка бай и пояснение6".visible = false
		$max_lvl6.visible = true
		$"монетка сменяется на макс прокачка6".visible = true
	
	if Global.gold >= Global.money_jumpx2:
		if Global.jumpshx2 == 0:
			$"1kn14/14".play("buy")
		if Global.jumpshx2 == 1:
			$"1kn15/15".play("buy")
		if Global.jumpshx2 == 2:
			$"1kn16/16".play("buy")
		$Koin7.play("buy_gold")
			
	if Global.gold < Global.money_jumpx2:
		if Global.jumpshx2 == 0:
			$"1kn14/14".play("default")
		if Global.jumpshx2 == 1:
			$"1kn15/15".play("default")
		if Global.jumpshx2 == 2:
			$"1kn16/16".play("default")
		$Koin7.play("idle_gold")	
		
	#здоровье
	if Global.hpsh >= 1:
		$"1kn10/7".play("vs")
	if Global.hpsh >= 2:
		$"1kn11/8".play("vs")
	if Global.hpsh >= 3:
		$"1kn12/9".play("vs")
		lab5.visible = false
		$Koin3.visible = false
		$"пояснение монеты2".visible = false
		$"монетка бай и пояснение3".visible = false
		$max_lvl3.visible = true
		$"монетка сменяется на макс прокачка3".visible = true
	
	if Global.gold >= Global.money_hp:
		if Global.hpsh == 0:
			$"1kn10/7".play("buy")
		if Global.hpsh == 1:
			$"1kn11/8".play("buy")
		if Global.hpsh == 2:
			$"1kn12/9".play("buy")
		$Koin3.play("buy_gold")
			
	if Global.gold < Global.money_hp:
		if Global.hpsh == 0:
			$"1kn10/7".play("default")
		if Global.hpsh == 1:
			$"1kn11/8".play("default")
		if Global.hpsh == 2:
			$"1kn12/9".play("default")
		$Koin3.play("idle_gold")
			
	#собака (блок урона)
	if Global.dogsh >= 1:
		$"1kn13/10".play("vs")
	if Global.dogsh >= 2:
		$"1kn19/19".play("vs")
	if Global.dogsh >= 3:
		$"1kn20/20".play("vs")
		lab7.visible = false
		$Koin4.visible = false
		$"пояснение монеты3".visible = false
		$"монетка бай и пояснение4".visible = false
		$max_lvl4.visible = true
		$"монетка сменяется на макс прокачка4".visible = true
	
	if Global.gold >= Global.money_dog:
		if Global.dogsh == 0:
			$"1kn13/10".play("buy")
		if Global.dogsh == 1:
			$"1kn19/19".play("buy")
		if Global.dogsh == 2:
			$"1kn20/20".play("buy")
		$Koin4.play("buy_gold")
	
	if Global.gold < Global.money_dog:
		if Global.dogsh == 0:
			$"1kn13/10".play("default")
		if Global.dogsh == 1:
			$"1kn19/19".play("default")
		if Global.dogsh == 2:
			$"1kn20/20".play("default")
		$Koin4.play("idle_gold")
			
	#батут
	if Global.batsh >= 1:
		$"1kn17/17".play("vs")
	if Global.batsh >= 2:
		$"1kn23/17".play("vs")
	if Global.batsh >= 3:
		$"1kn24/17".play("vs")
		lab8.visible = false
		$Koin5.visible = false
		$"пояснение монеты7".visible = false
		$"монетка бай и пояснение7".visible = false
		$max_lvl8.visible = true
		$"монетка сменяется на макс прокачка8".visible = true
	
	if Global.gold >= Global.money_batut:
		if Global.batsh == 0:
			$"1kn17/17".play("buy")
		if Global.batsh == 1:
			$"1kn23/17".play("buy")
		if Global.batsh == 2:
			$"1kn24/17".play("buy")
		$Koin5.play("buy_gold")
			
	if Global.gold < Global.money_batut:
		if Global.batsh == 0:
			$"1kn17/17".play("default")
		if Global.batsh == 1:
			$"1kn23/17".play("default")
		if Global.batsh == 2:
			$"1kn24/17".play("default")
		$Koin5.play("idle_gold")
			
	#корзинка
	if Global.korzsh >= 1:
		$"1kn18/18".play("vs")
	if Global.korzsh >= 2:
		$"1kn21/18".play("vs")
	if Global.korzsh >= 3:
		$"1kn22/18".play("vs")
		lab6.visible = false
		$Koin6.visible = false
		$"пояснение монеты6".visible = false
		$"монетка бай и пояснение8".visible = false
		$max_lvl7.visible = true
		$"монетка сменяется на макс прокачка7".visible = true
	
	if Global.gold >= Global.money_korz:
		if Global.korzsh == 0:
			$"1kn18/18".play("buy")
		if Global.korzsh == 1:
			$"1kn21/18".play("buy")
		if Global.korzsh == 2:
			$"1kn22/18".play("buy")
		$Koin6.play("buy_gold")
			
	if Global.gold < Global.money_korz:
		if Global.korzsh == 0:
			$"1kn18/18".play("default")
		if Global.korzsh == 1:
			$"1kn21/18".play("default")
		if Global.korzsh == 2:
			$"1kn22/18".play("default")
		$Koin6.play("idle_gold")
	
	
func _on_пояснение_скорость_pressed():
	$"подложка".visible = true
	$"скорость текст".visible = true
	if Global.Language == "RU":
		if Global.skorsh == 0:
			$"скорость текст".text = str ("СКОРОСТЬ
				Увеличивает скорость передвижения персонажа до 125 единиц на 1 уровне.
				Сейчас: 100 единиц")
		if Global.skorsh == 1:
			$"скорость текст".text = str ("СКОРОСТЬ
				Увеличивает скорость передвижения персонажа до 150 единиц на 2 уровне.
				Сейчас: 125 единиц")
		if Global.skorsh == 2:
			$"скорость текст".text = str ("СКОРОСТЬ
				Увеличивает скорость передвижения персонажа до 175 единиц на 3 уровне.
				Сейчас: 150 единиц")
		if Global.skorsh == 3:
			$"скорость текст".text = str ("СКОРОСТЬ
				Увеличивает скорость передвижения персонажа.
				Сейчас: 175 единиц")
				
	if Global.Language == "EN":
		if Global.skorsh == 0:
			$"скорость текст".text = str ("SPEED
 				Increases the character's movement speed to 125 units at level 1.
 				Now: 100 units")
		if Global.skorsh == 1:
			$"скорость текст".text = str ("SPEED
 				Increases the character's movement speed to 150 units at level 2.
 				Now: 125 units")
		if Global.skorsh == 2:
			$"скорость текст".text = str ("SPEED
 				Increases the character's movement speed to 175 units at level 3.
 				Now: 150 units")
		if Global.skorsh == 3:
			$"скорость текст".text = str ("SPEED
 				Increases the character's movement speed.
 				Now: 175 units")
	
func _on_пояснение_скорость_mouse_exited():
	$"подложка".visible = false
	$"скорость текст".visible = false


func _on_пояснение_прыжок_pressed():
	$"подложка".visible = true
	$"прыжок текст".visible = true
	if Global.Language == "RU":
		if Global.jumpsh == 0:
			$"прыжок текст".text = str ("ПРЫЖОК
				Увеличивает силу прыжка персонажа до 125 единиц на 1 уровне.
				Сейчас: 85 единиц")
		if Global.jumpsh == 1:
			$"прыжок текст".text = str ("ПРЫЖОК
				Увеличивает силу прыжка персонажа до 170 единиц на 2 уровне.
				Сейчас: 125 единиц")
		if Global.jumpsh == 2:
			$"прыжок текст".text = str ("ПРЫЖОК
				Увеличивает силу прыжка персонажа до 215 единиц на 3 уровне.
				Сейчас: 170 единиц")
		if Global.jumpsh == 3:
			$"прыжок текст".text = str ("ПРЫЖОК
				Увеличивает силу прыжка персонажа.
				Сейчас: 215 единиц")
			
	if Global.Language == "EN":
		if Global.jumpsh == 0:
			$"прыжок текст".text = str ("JUMP
 				Increases the character's jump power to 125 units at level 1.
 				Now: 85 units")
		if Global.jumpsh == 1:
			$"прыжок текст".text = str ("JUMP
 				Increases the character's jump power to 170 units at level 2.
 				Now: 125 units")
		if Global.jumpsh == 2:
			$"прыжок текст".text = str ("JUMP
 				Increases the character's jump power to 215 units at level 3.
 				Now: 170 units")
		if Global.jumpsh == 3:
			$"прыжок текст".text = str ("JUMP
 				Increases the character's jump power.
 				Now: 215 units")
		
func _on_пояснение_прыжок_mouse_exited():
	$"подложка".visible = false
	$"прыжок текст".visible = false


func _on_пояснение_здоровье_pressed():
	$"подложка".visible = true
	$"хп текст".visible = true
	if Global.Language == "RU":
		if Global.hpsh == 0:
			$"хп текст".text = str ("ЗДОРОВЬЕ
				Увеличивает общее колиство здоровья персонажа до 4 здоровья на 1 уровне.
				Сейчас: 3 здоровья")
		if Global.hpsh == 1:
			$"хп текст".text = str ("ЗДОРОВЬЕ
				Увеличивает общее колиство здоровья персонажа до 5 здоровья на 2 уровне.
				Сейчас: 4 здоровья")
		if Global.hpsh == 2:
			$"хп текст".text = str ("ЗДОРОВЬЕ
				Увеличивает общее колиство здоровья персонажа до 6 здоровья на 3 уровне.
				Сейчас: 5 здоровья")
		if Global.hpsh == 3:
			$"хп текст".text = str ("ЗДОРОВЬЕ
				Увеличивает общее колиство здоровья персонажа.
				Сейчас: 6 здоровья")
				
	if Global.Language == "EN":
		if Global.hpsh == 0:
			$"хп текст".text = str ("HEALTH
 				Increases the total health of the character to 4 health at level 1.
 				Now: 3 health")
		if Global.hpsh == 1:
			$"хп текст".text = str ("HEALTH
 				Increases the total health of the character to 5 health at level 2.
 				Now: 4 health")
		if Global.hpsh == 2:
			$"хп текст".text = str ("HEALTH
 				Increases the total health of the character to 6 health at level 3.
 				Now: 5 health")
		if Global.hpsh == 3:
			$"хп текст".text = str ("HEALTH
 				Increases the total health of the character.
 				Now: 6 health")
		
func _on_пояснение_здоровье_mouse_exited():
	$"подложка".visible = false
	$"хп текст".visible = false



func _on_пояснение_коржик_pressed():
	$"подложка".visible = true
	$"Коржик текст".visible = true
	if Global.Language == "RU":
		if Global.dogsh == 0:
			$"Коржик текст".text = str ("НЕУЯЗВИМОСТЬ
				Увеличивает время блокирования урона персонажа, после потери здоровья до 5 секунд на 1 уровне.
				Сейчас: 4 секунды ")
		if Global.dogsh == 1:
			$"Коржик текст".text = str ("НЕУЯЗВИМОСТЬ
				Увеличивает время блокирования урона персонажа, после потери здоровья до 6 секунд на 2 уровне.
				Сейчас: 5 секунд")
		if Global.dogsh == 2:
			$"Коржик текст".text = str ("НЕУЯЗВИМОСТЬ
				Увеличивает время блокирования урона персонажа, после потери здоровья до 8 секунд на 3 уровне.
				Сейчас: 6 секунд")
		if Global.dogsh == 3:
			$"Коржик текст".text = str ("НЕУЯЗВИМОСТЬ
				Увеличивает время блокирования урона персонажа, после потери здоровья.
				Сейчас: 8 секунд")
				
	if Global.Language == "EN":
		if Global.dogsh == 0:
			$"Коржик текст".text = str ("INVULNERABILITY
 				Increases the time to block a character's damage after losing health to 5 seconds at level 1.
 				Now: 4 seconds")
		if Global.dogsh == 1:
			$"Коржик текст".text = str ("INVULNERABILITY
 				Increases the time to block a character's damage after losing health to 6 seconds at level 2.
 				Now: 5 seconds")
		if Global.dogsh == 2:
			$"Коржик текст".text = str ("INVULNERABILITY
 				Increases the time to block a character's damage after losing health to 8 seconds at level 3.
 				Now: 6 seconds")
		if Global.dogsh == 3:
			$"Коржик текст".text = str ("INVULNERABILITY
				Increases the time to block a character's damage after losing health.
 				Now: 8 seconds")
				
func _on_пояснение_коржик_mouse_exited():
	$"подложка".visible = false
	$"Коржик текст".visible = false


func _on_пояснение_рывок_pressed():
	$"подложка".visible = true
	$"рывок текст".visible = true
	if Global.Language == "RU":
		if Global.skorshx2 == 0:
			$"рывок текст".text = str ("РЫВОК
				Сокращает время перезарядки повторного применения до 20 секунд на 1 уровне.
				Сейчас: отсутствует")
		if Global.skorshx2 == 1:
			$"рывок текст".text = str ("РЫВОК
				Сокращает время перезарядки повторного применения до 15 секунд на 2 уровне.
				Сейчас: 20 секунд")
		if Global.skorshx2 == 2:
			$"рывок текст".text = str ("РЫВОК
				Сокращает время перезарядки повторного применения до 10 секунд на 3 уровне.
				Сейчас: 15 секунд")
		if Global.skorshx2 == 3:
			$"рывок текст".text = str ("РЫВОК
				Сокращает время перезарядки повторного применения.
				Сейчас: 10 секунд")
				
	if Global.Language == "EN":
		if Global.skorshx2 == 0:
			$"рывок текст".text = str ("SPURT
 				Reduces the reload time of repeated use to 20 seconds at level 1.
 				Now: absent")
		if Global.skorshx2 == 1:
			$"рывок текст".text = str ("SPURT
				Reduces the recharge time of repeated use to 15 seconds at level 2.
 				Now: 20 seconds")
		if Global.skorshx2 == 2:
			$"рывок текст".text = str ("SPURT
				Reduces the recharge time of repeated use to 10 seconds at level 3.
 				Now: 15 seconds")
		if Global.skorshx2 == 3:
			$"рывок текст".text = str ("SPURT
				Reduces the recharge time of repeated use.
 				Now: 10 seconds")
				
func _on_пояснение_рывок_mouse_exited():
	$"подложка".visible = false
	$"рывок текст".visible = false

func _on_пояснение_двойной_прыжок_pressed():
	$"подложка".visible = true
	$"двойной прыжок текст".visible = true
	if Global.Language == "RU":
		if Global.jumpshx2 == 0:
			$"двойной прыжок текст".text = str ("ДВОЙНОЙ ПРЫЖОК
				Сокращает время перезарядки повторного применения до 12 секунд на 1 уровне.
				Сейчас: отсутствует")
		if Global.jumpshx2 == 1:
			$"двойной прыжок текст".text = str ("ДВОЙНОЙ ПРЫЖОК
				Сокращает время перезарядки повторного применения до 8 секунд на 2 уровне.
				Сейчас: 12 секунд")
		if Global.jumpshx2 == 2:
			$"двойной прыжок текст".text = str ("ДВОЙНОЙ ПРЫЖОК
				Сокращает время перезарядки повторного применения до 4 секунд на 3 уровне.
				Сейчас: 8 секунд")
		if Global.jumpshx2 == 3:
			$"двойной прыжок текст".text = str ("ДВОЙНОЙ ПРЫЖОК
				Сокращает время перезарядки повторного применения.
				Сейчас: 4 секунд")
				
	if Global.Language == "EN":
		if Global.jumpshx2 == 0:
			$"двойной прыжок текст".text = str ("DOUBLE JUMP
				Reduces the reload time of repeated use to 12 seconds at level 1.
 				Now: absent")
		if Global.jumpshx2 == 1:
			$"двойной прыжок текст".text = str ("DOUBLE JUMP
				Reduces the reload time of repeated use to 8 seconds at level 2.
 				Now: 12 seconds")
		if Global.jumpshx2 == 2:
			$"двойной прыжок текст".text = str ("DOUBLE JUMP
				Reduces the reload time of repeated use to 4 seconds at level 3.
 				Now: 8 seconds")
		if Global.jumpshx2 == 3:
			$"двойной прыжок текст".text = str ("DOUBLE JUMP
 				Reduces the recharge time of repeated use.
 				Now: 4 seconds")
func _on_пояснение_двойной_прыжок_mouse_exited():
	$"подложка".visible = false
	$"двойной прыжок текст".visible = false


func _on_пояснение_вторая_корзинка_pressed():
	$"подложка".visible = true
	$"доп корзинка текст".visible = true
	if Global.Language == "RU":
		if Global.korzsh == 0:
			$"доп корзинка текст".text = str ("ВТОРАЯ КОРЗИНКА
				Сокращает время перезарядки повторного применения до 30 секунд на 1 уровне.
				Сейчас: отсутствует")
		if Global.korzsh == 1:
			$"доп корзинка текст".text = str ("ВТОРАЯ КОРЗИНКА
				Сокращает время перезарядки повторного применения до 25 секунд на 2 уровне.
				Сейчас: 30 секунд")
		if Global.korzsh == 2:
			$"доп корзинка текст".text = str ("ВТОРАЯ КОРЗИНКА
				Сокращает время перезарядки повторного применения до 20 секунд на 2 уровне.
				Сейчас: 25 секунд")
		if Global.korzsh == 3:
			$"доп корзинка текст".text = str ("ВТОРАЯ КОРЗИНКА
				Сокращает время перезарядки повторного применения.
				Сейчас: 20 секунд")
				
	if Global.Language == "EN":
		if Global.korzsh == 0:
			$"доп корзинка текст".text = str ("THE SECOND BASKET
 				Reduces the reload time of repeated use to 30 seconds at level 1.
 				Now: absent")
		if Global.korzsh == 1:
			$"доп корзинка текст".text = str ("THE SECOND BASKET
 				Reduces the reload time of repeated use to 25 seconds at level 2.
 				Now: 30 seconds")
		if Global.korzsh == 2:
			$"доп корзинка текст".text = str ("THE SECOND BASKET
 				Reduces the reload time of repeated use to 20 seconds at level 3.
 				Now: 25 seconds")
		if Global.korzsh == 3:
			$"доп корзинка текст".text = str ("THE SECOND BASKET
				Reduces the recharge time of repeated use.
 				Now: 20 seconds")
		
func _on_пояснение_вторая_корзинка_mouse_exited():
	$"подложка".visible = false
	$"доп корзинка текст".visible = false


func _on_пояснение_батут_pressed():
	$"подложка".visible = true
	$"батут текст".visible = true
	$"режим пишет в описании".visible = true
	if Global.Language == "RU":
		if Global.batsh == 0:
			$"батут текст".text = str ("ЯЩИК
				Увеличивает количество места в ящике для накопления яблок до 1 единицы на 1 уровне.
				Сейчас: отсутствует")
			$"режим пишет в описании".text = str ("Режим: выключен")
		if Global.batsh == 1:
			$"батут текст".text = str ("ЯЩИК
				Увеличивает количество места в ящике для накопления яблок до 2 единиц на 2 уровне.
				Сейчас: 1 единица")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Режим: включен")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Режим: выключен")
		if Global.batsh == 2:
			$"батут текст".text = str ("ЯЩИК
				Увеличивает количество места в ящике для накопления яблок до 3 единиц на 3 уровне.
				Сейчас: 2 единицы")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Режим: включен")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Режим: выключен")
		if Global.batsh == 3:
			$"батут текст".text = str ("ЯЩИК
				Увеличивает количество места в ящике для накопления яблок.
				Сейчас: 3 единицы")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Режим: включен")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Режим: выключен")
				
	if Global.Language == "EN":
		if Global.batsh == 0:
			$"батут текст".text = str ("BOX
 				Increases the amount of space in the apple storage box to 1 unit at 1 level.
				Now: absent")
			$"режим пишет в описании".text = str ("Mode: off")
		if Global.batsh == 1:
			$"батут текст".text = str ("BOX
 				Increases the amount of space in the apple storage box to 2 units at 2 level.
				Now: 1 units")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Mode: on")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Mode: off")
		if Global.batsh == 2:
			$"батут текст".text = str ("BOX
 				Increases the amount of space in the apple storage box to 3 units at 3 level.
				Now: 2 units")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Mode: on")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Mode: off")
		if Global.batsh == 3:
			$"батут текст".text = str ("BOX
 				Increases the amount of space in the box for storing apples.
				Now: 3 units")
			if Global.rezhim_yach == 1:
				$"режим пишет в описании".text = str ("Mode: on")
			if Global.rezhim_yach == 3:
				$"режим пишет в описании".text = str ("Mode: off")
		
func _on_пояснение_батут_mouse_exited():
	$"подложка".visible = false
	$"батут текст".visible = false
	$"режим пишет в описании".visible = false


func _on_монетка_бай_и_пояснение_pressed():
	if Global.gold >= Global.money_speed and (Global.skorsh == 0 or Global.skorsh == 1 or Global.skorsh == 2):
		Global.gold -= Global.money_speed
		Global.skorsh += 1
		Global.money_speed += 125
		Global.speed_prokac += 45 # + 45 к скорости
		Bridge.storage.set(["skorsh","money_speed","speed_prokac","gold"], [Global.skorsh,Global.money_speed,Global.speed_prokac,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()


func _on_монетка_бай_и_пояснение2_pressed():
	if Global.gold >= Global.money_jump and (Global.jumpsh == 0 or Global.jumpsh == 1 or Global.jumpsh == 2):
		Global.gold -= Global.money_jump
		Global.jumpsh += 1
		Global.money_jump += 100
		Global.jump_prokach -= 45 # прыжок увеличивается на 45
		Bridge.storage.set(["jumpsh","money_jump","jump_prokach","gold"], [Global.jumpsh,Global.money_jump,Global.jump_prokach,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()


func _on_монетка_бай_и_пояснение3_pressed():
	if Global.gold >= Global.money_hp and (Global.hpsh == 0 or Global.hpsh == 1 or Global.hpsh == 2):
		Global.gold -= Global.money_hp
		Global.hpsh += 1
		Global.money_hp += 150
		Global.HP_MAX += 1 # + 1 Здоровье
		Bridge.storage.set(["hpsh","money_hp","HP_MAX","gold"], [Global.hpsh,Global.money_hp,Global.HP_MAX,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()


func _on_монетка_бай_и_пояснение4_pressed():
	if Global.gold >= Global.money_dog and (Global.dogsh == 0 or Global.dogsh == 1):
		Global.gold -= Global.money_dog
		Global.dogsh += 1
		Global.money_dog += 125
		Global.block_time += 1 # увеличивает блок на 1 сек
		Bridge.storage.set(["dogsh","money_dog","block_time","gold"], [Global.dogsh,Global.money_dog,Global.block_time,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()
	elif Global.gold >= Global.money_dog and Global.dogsh == 2: #для последней прокачки
		Global.gold -= Global.money_dog
		Global.dogsh += 1
		Global.money_dog *= 2
		Global.block_time += 2 # увеличивает блок на 2 сек
		Bridge.storage.set(["dogsh","money_dog","block_time","gold"], [Global.dogsh,Global.money_dog,Global.block_time,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()

func _on_монетка_бай_и_пояснение5_pressed():
	if Global.gold >= Global.money_speedx2 and (Global.skorshx2 == 0 or Global.skorshx2 == 1 or Global.skorshx2 == 2):
		Global.gold -= Global.money_speedx2
		Global.skorshx2 += 1
		Global.money_speedx2 += 175
		Global.rivok_prokac += 1 # появляется рывок с перезарядкой 20 сек и - 5 сек за каждый след
		Bridge.storage.set(["skorshx2","money_speedx2","rivok_prokac","gold"], [Global.skorshx2,Global.money_speedx2,Global.rivok_prokac,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()


func _on_монетка_бай_и_пояснение6_pressed():
	if Global.gold >= Global.money_jumpx2 and (Global.jumpshx2 == 0 or Global.jumpshx2 == 1 or Global.jumpshx2 == 2):
		Global.gold -= Global.money_jumpx2
		Global.jumpshx2 += 1
		Global.money_jumpx2 += 125
		Global.jump_prokac += 1
		Bridge.storage.set(["jumpshx2","money_jumpx2","jump_prokac","gold"], [Global.jumpshx2,Global.money_jumpx2,Global.jump_prokac,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()


func _on_монетка_бай_и_пояснение7_pressed():
	if Global.gold >= Global.money_batut and Global.batsh == 0:
		Global.gold -= Global.money_batut
		Global.batsh += 1 #Покупка ящика
		if Global.batsh == 1:
			Global.rezhim_yach = 1
			$"1Режим".visible = true
			$"1Режим/режим".visible = true
			$"1Режим/режим".text = str(1)
			$Button.visible = true
		Global.money_batut += 125
		Global.kolvo_sbor_apple = 1
		Bridge.storage.set(["batsh","money_batut","kolvo_sbor_apple","rezhim_yach","gold"], [Global.batsh,Global.money_batut,Global.kolvo_sbor_apple,Global.rezhim_yach,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()
	elif Global.gold >= Global.money_batut and (Global.batsh == 1 or Global.batsh == 2):
		Global.gold -= Global.money_batut
		Global.batsh += 1 #Покупка ящика
		Global.money_batut += 200
		Global.kolvo_sbor_apple += 1
		Bridge.storage.set(["batsh","money_batut","kolvo_sbor_apple","rezhim_yach","gold"], [Global.batsh,Global.money_batut,Global.kolvo_sbor_apple,Global.rezhim_yach,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()

func _on_монетка_бай_и_пояснение8_pressed():
	if Global.gold >= Global.money_korz and Global.korzsh == 0:
		Global.gold -= Global.money_korz
		Global.korzsh += 1
		Global.money_korz += 125
		Bridge.storage.set(["korzsh","money_korz","gold"], [Global.korzsh,Global.money_korz,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()
	elif Global.gold >= Global.money_korz and (Global.korzsh == 1 or Global.korzsh == 2):
		Global.gold -= Global.money_korz
		Global.korzsh += 1
		Global.money_korz += 175
		Bridge.storage.set(["korzsh","money_korz","gold"], [Global.korzsh,Global.money_korz,Global.gold])
		if Global.musek_efect == true:
			$prokacka.play()



func _on_button_pressed():
	Global.rezhim_yach += 1
	if Global.rezhim_yach == 1:
		$"1Режим".visible = true
		$"1Режим/режим".text = str(1)
		$"1Режим/режим".visible = true
	if Global.rezhim_yach == 2:
		Global.rezhim_yach = 3
		$"1Режим/режим".text = str(2)
		$"1Режим/режим".visible = true
	if Global.rezhim_yach == 3:
		$"0Выкл".visible = true
		$"1Режим/режим".visible = false
	if Global.rezhim_yach == 4:
		Global.rezhim_yach = 1
		$"1Режим".visible = true
		$"0Выкл".visible = false
		$"1Режим/режим".visible = true
		$"1Режим/режим".text = str(1)
	Bridge.storage.set(["rezhim_yach"], [Global.rezhim_yach])

func language():
	if Global.Language == "RU":
		$Label.text = str ("Улучшения")
		
	if Global.Language == "EN":
		$Label.text = str ("Improvements")
		
func menaytsa_str(): #меняются страницы
	pass

func saveYandex(): #сохранение значений для яндекса в магазине
	Bridge.storage.set(["skorsh","money_speed","speed_prokac","gold","jumpsh","money_jump","jump_prokach","hpsh","money_hp","HP_MAX","dogsh","money_dog","block_time","skorshx2","money_speedx2","rivok_prokac","jumpshx2","money_jumpx2","jump_prokac","batsh","money_batut","kolvo_sbor_apple","korzsh","money_korz","rezhim_yach"], [Global.skorsh,Global.money_speed,Global.speed_prokac,Global.gold,Global.jumpsh,Global.money_jump,Global.jump_prokach,Global.hpsh,Global.money_hp,Global.HP_MAX,Global.dogsh,Global.money_dog,Global.block_time,Global.skorshx2,Global.money_speedx2,Global.rivok_prokac,Global.jumpshx2,Global.money_jumpx2,Global.jump_prokac,Global.batsh,Global.money_batut,Global.kolvo_sbor_apple,Global.korzsh,Global.money_korz,Global.rezhim_yach])
