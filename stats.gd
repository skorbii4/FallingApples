extends CanvasLayer

func _ready() -> void:
	Global.gde_i_shas = "stats"
	$record.text = str(Global.hi_score)

	$all.text = str(Global.very_score)
	$"HP+".text = str(Global.HP_chet)
	$deas.text = str(Global.apple_razbilos)
	
	$SPEED.text = str(Global.speed_stats)
	$JUMP.text = str(Global.jump_stats)
	$DEF.text = str(Global.def_stats)
	$GOLD.text = str(Global.gold_stats)
	$comon_apple.text = str(Global.common_apple)

	
func _process(delta: float) -> void:
	language() #текст меняется в зависимости от языка
	

func _on_manu_pressed():
	Global.onli_menu = true
	Global.GG_one_raz = true #Обновить отображение скина в главном меню
	get_tree().change_scene_to_file("res://menu.tscn")
	


func _on_пояснение_рекорд_pressed():
	$"../подложка".visible = true
	$"record текст".visible = true
func _on_пояснение_рекорд_mouse_exited():
	$"../подложка".visible = false
	$"record текст".visible = false


func _on_пояснение_здоровье_pressed():
	$"../подложка".visible = true
	$"HP+ текст".visible = true
func _on_пояснение_здоровье_mouse_exited():
	$"../подложка".visible = false
	$"HP+ текст".visible = false


func _on_пояснение_комон_яблоко_pressed():
	$"../подложка".visible = true
	$"comon_apple текст".visible = true
func _on_пояснение_комон_яблоко_mouse_exited():
	$"../подложка".visible = false
	$"comon_apple текст".visible = false


func _on_пояснение_speed_яблоко_pressed():
	$"../подложка".visible = true
	$"speed_apple текст".visible = true
func _on_пояснение_speed_яблоко_mouse_exited():
	$"../подложка".visible = false
	$"speed_apple текст".visible = false


func _on_пояснение_jump_яблоко_pressed():
	$"../подложка".visible = true
	$"jump_apple текст".visible = true
func _on_пояснение_jump_яблоко_mouse_exited():
	$"../подложка".visible = false
	$"jump_apple текст".visible = false


func _on_пояснение_def_яблоко_pressed():
	$"../подложка".visible = true
	$"def_apple текст".visible = true
func _on_пояснение_def_яблоко_mouse_exited():
	$"../подложка".visible = false
	$"def_apple текст".visible = false


func _on_пояснение_gold_яблоко_pressed():
	$"../подложка".visible = true
	$"gold_apple текст".visible = true
func _on_пояснение_gold_яблоко_mouse_exited():
	$"../подложка".visible = false
	$"gold_apple текст".visible = false


func _on_пояснение_за_всё_время_pressed():
	$"../подложка".visible = true
	$"all текст".visible = true
func _on_пояснение_за_всё_время_mouse_exited():
	$"../подложка".visible = false
	$"all текст".visible = false


func _on_пояснение_разбилось_pressed():
	$"../подложка".visible = true
	$"DEATH текст".visible = true
func _on_пояснение_разбилось_mouse_exited():
	$"../подложка".visible = false
	$"DEATH текст".visible = false


func language():
	if Global.Language == "RU":
		$"../Label2".text = str ("Статистика")
		$"record текст".text = str ("РЕКОРД
			Наивысший результат по количеству собранных яблок за одну игру.")
		$"HP+ текст".text = str ("ЗДОРОВЬЕ
			Общее количество восстановленых единиц здоровья на протяжении всего времени.")
		$"comon_apple текст".text = str ("ПРОСТОЕ ЯБЛОКО
			Общее количество собранных простых яблок на протяжении всего времени.")
		$"speed_apple текст".text = str ("ЯБЛОКО «СКОРОСТИ»
			Общее количество собранных яблок «Скорости» на протяжении всего времени.")
		$"jump_apple текст".text = str ("ЯБЛОКО «ПРЫГУЧЕСТИ»
			Общее количество собранных яблок «Прыгучести» на протяжении всего времени.")
		$"def_apple текст".text = str ("ЯБЛОКО «ЗАЩИТЫ»
			Общее количество собранных яблок «Защиты» на протяжении всего времени.")
		$"gold_apple текст".text = str ("ЗОЛОТОЕ ЯБЛОКО
			Общее количество собранных золотых яблок на протяжении всего времени.")
		$"all текст".text = str ("ОБЩИЙ СБОР
			Общее количество собранных яблок на протяжении всего времени.")
		$"DEATH текст".text = str ("РАЗБИТОЕ ЯБЛОКО
			Общее количество разбитых яблок на протяжении всего времени.")
	if Global.Language == "EN":
		$"../Label2".text = str ("Statistics")
		$"record текст".text = str ("RECORD
			The highest score in terms of the number of apples collected in one game.")
		$"HP+ текст".text = str ("HEALTH
 			The total number of health units restored throughout the entire time.")
		$"comon_apple текст".text = str ("COMMON APPLE
			The total number of common apples collected throughout the time.")
		$"speed_apple текст".text = str ("APPLE OF «SPEED»
			The total number apples of «Speed» collected throughout the entire time.")
		$"jump_apple текст".text = str ("APPLE OF «JUMP»
 			The total number apples of «Jump» collected throughout the entire time.")
		$"def_apple текст".text = str ("APPLE OF «PROTECTION»
			The total number apples of «Protection» collected throughout the entire time.")
		$"gold_apple текст".text = str ("GOLDEN APPLE
 			The total number of golden apples collected throughout the time.")
		$"all текст".text = str ("GENERAL COLLECTION
 			The total number of apples collected throughout the time.")
		$"DEATH текст".text = str ("THE BROKEN APPLE
 			The total number of broken apples during the whole time.")
