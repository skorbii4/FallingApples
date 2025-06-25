extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.gde_i_shas = "skins"
	Bridge.storage.set(["GG","Knopka1","Knopka2","Knopka3","Knopka4"], [Global.GG,Global.Knopka1,Global.Knopka2,Global.Knopka3,Global.Knopka4])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	knopki() #отображение кнопок внизу
	language() #текст меняется в зависимости от языка


func _on_manu_pressed():
	Global.onli_menu = true# переход в главное меню
	Global.GG_one_raz = true #Обновить отображение скина в главном меню
	get_tree().change_scene_to_file("res://menu.tscn")
	

#Выбор скинов
func _on_skin_1_pressed():
	Global.Knopka1 = 0 #выбран
	Global.GG = 0 #включен 1 скин
	if Global.Knopka2 == 1:	#Если вторая кнопка сейчас не на стадии покупки
		Global.Knopka2 = -1 # #Вторая кнопка стала "Принять"
	if Global.Knopka3 == 2:	#Если вторая кнопка сейчас не на стадии покупки
		Global.Knopka3 = -1 # #Вторая кнопка стала "Принять"
	if Global.Knopka4 == 2:
		Global.Knopka4 = -1 #Четветрая кнопка стала "Принять"
	Bridge.storage.set(["GG","Knopka1","Knopka2","Knopka3","Knopka4"], [Global.GG,Global.Knopka1,Global.Knopka2,Global.Knopka3,Global.Knopka4])	

func _on_skin_2_pressed():
	if Global.gold >= Global.GG2 and Global.Knopka2 == 0: #Срабатывает 1 раз для того, чтобы скрыть возможность покупки
		Global.Knopka2 = 1
		Global.Knopka3 = 1 #Разблокировался 3 скин
		if Global.musek_efect == true:
			$"Покупка скина".play()
		Global.gold -= 150 #покупка скина
	if Global.Knopka2 == 1 or Global.Knopka2 == -1: #Если кнопка включена - необходимо остальные кнопки перевести в "Принять"
		Global.Knopka1 = -1 #Первая кнопка стала "Принять"
		if Global.Knopka3 == 2:
			Global.Knopka3 = -1 #Третья кнопка стала "Принять"
		if Global.Knopka4 == 2:
			Global.Knopka4 = -1 #Четветрая кнопка стала "Принять"
		Global.Knopka2 = 1
		Global.GG = 1 #включен 2 скин
	Bridge.storage.set(["GG","Knopka1","Knopka2","Knopka3","Knopka4"], [Global.GG,Global.Knopka1,Global.Knopka2,Global.Knopka3,Global.Knopka4])
		
func _on_skin_3_pressed():
	if Global.gold >= Global.GG3 and Global.Knopka3 == 1: #Срабатывает 1 раз для того, чтобы скрыть возможность покупки
		Global.Knopka3 = 2
		Global.Knopka4 = 1 #Разблокировался 4 скин
		if Global.musek_efect == true:
			$"Покупка скина".play()
		Global.gold -= 275 #покупка скина
	if Global.Knopka3 == 2 or Global.Knopka3 == -1: #Если кнопка не недоступна и не в стадии покупки
		Global.Knopka3 = 2
		Global.Knopka1 = -1 #Выключаю первый скин
		Global.Knopka2 = -1 #Выключаю второй скин
		if Global.Knopka4 == 2:
			Global.Knopka4 = -1 #Четветрая кнопка стала "Принять"
		Global.GG = 2 #включен 3 скин
	Bridge.storage.set(["GG","Knopka1","Knopka2","Knopka3","Knopka4"], [Global.GG,Global.Knopka1,Global.Knopka2,Global.Knopka3,Global.Knopka4])
	
func _on_skin_4_pressed():
	if Global.gold >= Global.GG4 and Global.Knopka4 == 1: #Срабатывает 1 раз для того, чтобы скрыть возможность покупки
		Global.Knopka4 = 2
		if Global.musek_efect == true:
			$"Покупка скина".play()
		Global.gold -= 350 #покупка скина
	if Global.Knopka4 == 2 or Global.Knopka4 == -1:
		Global.Knopka1 = -1 #Выключаю первый скин
		Global.Knopka2 = -1 #Выключаю второй скин
		Global.Knopka3 = -1 #Выключаю третий скин
		Global.Knopka4 = 2 #Включил четветрую кнопку
		Global.GG = 3 #включен 4 скин
	Bridge.storage.set(["GG","Knopka1","Knopka2","Knopka3","Knopka4"], [Global.GG,Global.Knopka1,Global.Knopka2,Global.Knopka3,Global.Knopka4])

func knopki(): #отображение и функционирование кнопок внизу
	
	#Отображение зеленым цветом текст, если хватает монет для покупки и анимация монетки
	if Global.gold >= Global.GG2:
		$"CanvasLayer/price 2".modulate = Color(0, 139, 0)
		$Koin2.play("anim")
	if Global.gold >= Global.GG3:
		$"CanvasLayer/price 3".modulate = Color(0, 139, 0)
		$Koin3.play("anim")
	if Global.gold >= Global.GG4:
		$"CanvasLayer/price 4".modulate = Color(0, 139, 0)
		$Koin4.play("anim")
	#Отображение красным цветом текст, если не хватает монет для покупки	
	if Global.gold < Global.GG2:
		$"CanvasLayer/price 2".modulate = Color(139, 0, 0)
		$Koin2.play("idle")
	if Global.gold < Global.GG3:
		$"CanvasLayer/price 3".modulate = Color(139, 0, 0)
		$Koin3.play("idle")
	if Global.gold < Global.GG4:
		$"CanvasLayer/price 4".modulate = Color(139, 0, 0)
		$Koin4.play("idle")

	
	#Само отображение на кнопках текста и анимация ГГ
	if Global.Knopka1 == 0:
		$"1_GG1".play("RUN")
		$skin1/Label.visible = true
		$skin1/Label2.visible = false
	else:
		$"1_GG1".play("IDLE")
		$skin1/Label.visible = false
		$skin1/Label2.visible = true
		
	if Global.Knopka2 == 0:
		$"2_GG1".visible = false #Недоступен ещё пока цветной
		$"2_GG0".visible = true #Серенький персонаж, т.к. нужно купить его
		$"CanvasLayer/price 2".visible = true
		$Koin2.visible = true
	if Global.Knopka2 == 1:
		$"2_GG1".visible = true #Купили
		$"2_GG0".visible = false #Отключили серенького
		$"2_GG1".play("RUN")
		$"CanvasLayer/price 2".visible = false
		$Koin2.visible = false
		$skin2/Label.visible = true
		$skin2/Label2.visible = false
	if Global.Knopka2 == -1:
		$"2_GG1".visible = true #Купили
		$"2_GG0".visible = false #Отключили серенького
		$"2_GG1".play("IDLE")
		$skin2/Label2.visible = true
		$skin2/Label.visible = false
	
	if Global.Knopka3 == 0:
		$"3_GG0".visible = true #Серенький персонаж, т.к. нужно купить его
		$"3_GG1".visible = false #Недоступен ещё пока цветной
		$skin3/Label3.visible = true #плашка "Недоступно"
	if Global.Knopka3 == 1:
		$"3_GG0".visible = true #Серенький персонаж, т.к. нужно купить его
		$"3_GG1".visible = false #Недоступен ещё пока цветной
		$"CanvasLayer/price 3".visible = true #Текст с покупкой отобразился
		$Koin3.visible = true #Монетка отобразилась
		$skin3/Label3.visible = false #плашка "Недоступно" скрыта и поменяна на возможность покупать
	if Global.Knopka3 == 2:
		$"3_GG0".visible = false #Серенький персонаж скрылся
		$"3_GG1".visible = true #Теперь ГГ цветной
		$"3_GG1".play("RUN")
		$"CanvasLayer/price 3".visible = false #Текст с покупкой скрылся
		$Koin3.visible = false #Монетка скрылась
		$skin3/Label2.visible = false #Плашка "Принять" скрылась
		$skin3/Label.visible = true #Плашка "Выбран" теперь горит
		$skin3/Label.visible = true #Теперь ГГ выбран
	if Global.Knopka3 == -1:
		$"CanvasLayer/price 3".visible = false #Текст с покупкой скрылся
		$Koin3.visible = false #Монетка скрылась
		$"3_GG0".visible = false #Серенький персонаж скрылся
		$"3_GG1".visible = true #Теперь ГГ цветной
		$"3_GG1".play("IDLE")
		$skin3/Label.visible = false #Плашка "Выбран" теперь скрыта
		$skin3/Label2.visible = true #Теперь плашка горит "Принять"
	
	if Global.Knopka4 == 0:
		$"4_GG0".visible = true #Серенький персонаж, т.к. нужно купить его
		$"4_GG1".visible = false #Недоступен ещё пока цветной
		$skin4/Label3.visible = true #плашка "Недоступно"
	if Global.Knopka4 == 1:
		$"4_GG0".visible = true #Серенький персонаж, т.к. нужно купить его
		$"4_GG1".visible = false #Недоступен ещё пока цветной
		$"CanvasLayer/price 4".visible = true #Текст с покупкой отобразился
		$Koin4.visible = true #Монетка отобразилась
		$skin4/Label3.visible = false #плашка "Недоступно" скрыта и поменяна на возможность покупать
	if Global.Knopka4 == 2:
		$"4_GG0".visible = false #Серенький персонаж скрылся
		$"4_GG1".visible = true #Теперь ГГ цветной
		$"4_GG1".play("RUN")
		$"CanvasLayer/price 4".visible = false #Текст с покупкой скрылся
		$Koin4.visible = false #Монетка скрылась
		$skin4/Label2.visible = false #Плашка "Принять" скрылась
		$skin4/Label.visible = true #Плашка "Выбран" теперь горит
		$skin4/Label.visible = true #Теперь ГГ выбран
	if Global.Knopka4 == -1:
		$"CanvasLayer/price 4".visible = false #Текст с покупкой скрылся
		$Koin4.visible = false #Монетка скрылась
		$"4_GG0".visible = false #Серенький персонаж скрылся
		$"4_GG1".visible = true #Теперь ГГ цветной
		$"4_GG1".play("IDLE")
		$skin4/Label.visible = false #Плашка "Выбран" теперь скрыта
		$skin4/Label2.visible = true #Теперь плашка горит "Принять"

func language():
	if Global.Language == "RU":
		$Label.text = str ("Внешний вид")
		$skin1/Label.text = str ("Выбран")
		$skin1/Label2.text = str ("Принять")
		$skin2/Label.text = str ("Выбран")
		$skin2/Label2.text = str ("Принять")
		$skin3/Label.text = str ("Выбран")
		$skin3/Label2.text = str ("Принять")
		$skin3/Label3.text = str ("Недоступно")
		$skin4/Label.text = str ("Выбран")
		$skin4/Label2.text = str ("Принять")
		$skin4/Label3.text = str ("Недоступно")
	if Global.Language == "EN":
		$Label.text = str ("Skins")
		$skin1/Label.text = str ("Selected")
		$skin1/Label2.text = str ("To accept")
		$skin2/Label.text = str ("Selected")
		$skin2/Label2.text = str ("To accept")
		$skin3/Label.text = str ("Selected")
		$skin3/Label2.text = str ("To accept")
		$skin3/Label3.text = str ("Unavailable")
		$skin4/Label.text = str ("Selected")
		$skin4/Label2.text = str ("To accept")
		$skin4/Label3.text = str ("Unavailable")
