extends Node2D

func _ready():
	pass

func _process(_delta):
	if Global.razdel == "nachalo":
		$"страницы внизу".text = str (Global.stranica) + "/3"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 3:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 3:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "shop":
		$"страницы внизу".text = str (Global.stranica) + "/9"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 9:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 10:
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "stats" or Global.razdel == "skins":
		$"страницы внизу".text = str (Global.stranica) + "/1"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
	#раздел про игру пошел	
	if Global.razdel == "lvl":
		if Global.winda == true:
			$"страницы внизу".text = str (Global.stranica) + "/3"
		else:
			$"страницы внизу".text = str (Global.stranica) + "/2"
		if Global.winda == true:
			if Global.stranica == 1:
				$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
				$"Право_книга".modulate = Color(1,1,1,1)
			if Global.stranica == 3:
				$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
				$"Лево_книга".modulate = Color(1,1,1,1)
			if Global.stranica > 1 and Global.stranica < 3:	
				$"Лево_книга".modulate = Color(1,1,1,1)
				$"Право_книга".modulate = Color(1,1,1,1)
		else:
			if Global.stranica == 1:
				$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
				$"Право_книга".modulate = Color(1,1,1,1)
			if Global.stranica == 2:
				$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
				$"Лево_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "Interface":
		$"страницы внизу".text = str (Global.stranica) + "/3"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 3:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 3:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "prepatstvia":
		$"страницы внизу".text = str (Global.stranica) + "/4"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 4:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 4:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "apple":
		$"страницы внизу".text = str (Global.stranica) + "/6"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 6:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 6:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "ezh":
		$"страницы внизу".text = str (Global.stranica) + "/8"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 8:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 8:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	if Global.razdel == "bird":
		$"страницы внизу".text = str (Global.stranica) + "/7"
		if Global.stranica == 1:
			$"Лево_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Право_книга".modulate = Color(1,1,1,1)
		if Global.stranica == 7:
			$"Право_книга".modulate = Color(0.83,0.32,0.31,1)
			$"Лево_книга".modulate = Color(1,1,1,1)
		if Global.stranica > 1 and Global.stranica < 7:	
			$"Лево_книга".modulate = Color(1,1,1,1)
			$"Право_книга".modulate = Color(1,1,1,1)
	
	text_str() #текст и само изображение на страницах


func text_str(): #текст и само изображение на страницах
	if Global.Language == "RU": #русский язык
		if Global.razdel == "nachalo": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Знакомство с игрой")
				$"Лабелы/Label".text = str ("ПАДЕНИЕ ЯБЛОК
					- Инди платформер, в котором игроку
					необходимо перемещаться по локации 
					и с помощью корзинки ловить яблоки. ")
				#включает
				$"анимации/Все анимации в одной".play("1 стр")
				$"анимации/Все анимации в одной".visible = true
				$"КраснаяПлашка".visible = true
				#выключает
				$"анимация птиц".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Знакомство с игрой")
				$"Лабелы/Label".text = str ("- На вашем пути будут возникать различные препятствия, 
				такие как погодные условия, местные обитатели леса, а также, 
				игроку необходимо следить за изменяющейся игровой обстановкой. 
				Придется принимать быстрые решения на различные игровые ситуации.")
				#выключает
				$"анимации/Все анимации в одной".visible = false
				$"КраснаяПлашка".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Знакомство с игрой")
				$"Лабелы/Label".text = str ("- Зарабатывай монеты во время игры. 
				- Покупай улучшения для персонажа.
				- Ставь новые рекорды.
				- Играй в своё удовольствие.")
				#включает
				$"анимации/Все анимации в одной".play("3 стр")
				$"анимации/Все анимации в одной".visible = true
				
				#выключает
		if Global.razdel == "shop": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Улучшения")
				$"Лабелы/Label".text = str ("- Полученные монеты
				можно потратить на различные
				улучшения в игре,
				добавляющие совсем другой 
				игровой опыт.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимации/Все анимации в одной".play("4 стр")
				$"анимации/Все анимации в одной".visible = true
				#выключает
				$"Лабелы/Label2".visible = false
				$"Лабелы/Label3".visible = false
				$JumpPlashka2.visible = false
				$"КраснаяПлашка2".visible = false
				$"ЧернаяПлашка".visible = false
			#начинается описание улучшений
			if Global.stranica == 2:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("СКОРОСТЬ
					Характеристика, которая определяет, 
					как быстро движется игрок.
					
					100/125/150/175 единиц за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка2".visible = true
				$"ЧернаяПлашка".visible = true
				#было видео
				
				#выключает
				$"КраснаяПлашка3".visible = false
				$JumpPlashka1.visible = false
				$"ЧернаяПлашка2".visible = false
				$"Лабелы/Label2".visible = false
				$"Лабелы/Label3".visible = false
				$"анимации/Все анимации в одной".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("ПРЫЖОК
					Характеристика, которая определяет, 
					на какую высоту игрок способен прыгнуть.
					
					80/125/170/215 единиц за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка3".visible = true
				$"ЧернаяПлашка2".visible = true
				
				#было видео
				
				#выключает
				$"КраснаяПлашка2".visible = false
				$"ЧернаяПлашка".visible = false
				$"КраснаяПлашка4".visible = false
				$"ЧернаяПлашка3".visible = false
				$"ЧернаяПлашка8".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("ЗДОРОВЬЕ
				Ключевой параметр, который позволяет 
				оставаться в игре как можно дольше.
				
				3/4/5/6 здоровья за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка4".visible = true
				$"ЧернаяПлашка3".visible = true
				$"ЧернаяПлашка8".visible = true
				
				#было видео
				
				#выключает
				$"КраснаяПлашка3".visible = false
				$"ЧернаяПлашка2".visible = false
				$"КраснаяПлашка5".visible = false
				$"ЧернаяПлашка3".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("НЕУЯЗВИМОСТЬ
					Период времени, в течение которого игрок 
					защищён от любого вида урона.
					
					4/5/6/8 секунд за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка5".visible = true
				$"ЧернаяПлашка3".visible = true
				
				#было видео
				
				#выключает
				$"КраснаяПлашка4".visible = false
				$"ЧернаяПлашка5".visible = false
				$"КраснаяПлашка7".visible = false
				$"ЧернаяПлашка8".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("РЫВОК
					Умение игрока, которое позволяет сделать 
					быстрый скачок вперед по направлению игрока.
					
					отсутствует/20/15/10 секунд за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка5".visible = true
				$"КраснаяПлашка7".visible = true
				#выключает
				$"КраснаяПлашка5".visible = false
				$"ЧернаяПлашка3".visible = false
				$"ЧернаяПлашка7".visible = false
				$"КраснаяПлашка9".visible = false
			if Global.stranica == 7:
				$"Заголовок".text = str ("Улучшения: Описание")	
				$"Лабелы/Label".text = str ("ДВОЙНОЙ ПРЫЖОК
					Умение игрока, которое позволяет сделать еще один прыжок. 
					На время отключает возможность игрока прыгать.
					
					отсутсвует/12/8/4 секунд за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка7".visible = true
				$"КраснаяПлашка9".visible = true
				
				#было видео
				
				#выключает
				$"ЧернаяПлашка5".visible = false
				$"КраснаяПлашка7".visible = false
				$"ЧернаяПлашка6".visible = false
				$"КраснаяПлашка8".visible = false
			if Global.stranica == 8:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("ВТОРАЯ КОРЗИНКА 
					Появляется возможность установить дополнительную корзину 
					на небольшом расстоянии для сбора яблок.
					
					отсутствует/30/25/20секунд за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка6".visible = true
				$"КраснаяПлашка8".visible = true
				
				#было видео
				
				#выключает
				$"ЧернаяПлашка4".visible = false
				$"КраснаяПлашка6".visible = false
				$"ЧернаяПлашка7".visible = false
				$"КраснаяПлашка9".visible = false
			if Global.stranica == 9:
				$"Заголовок".text = str ("Улучшения: Описание")
				$"Лабелы/Label".text = str ("ЯЩИК
					Предмет, который появляется в игре.
					Он служит для сбора и стратегического хранения яблок.
					
					отсутсвует/1/2/3 единиц за 0/1/2/3 уровень.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка4".visible = true
				$"КраснаяПлашка6".visible = true
				
				#было видео
				
				#выключает
				$"ЧернаяПлашка6".visible = false
				$"КраснаяПлашка8".visible = false
		if Global.razdel == "stats": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Статистика")
				$"Лабелы/Label".text = str ("- Просматривайте свои достижения
				накопленные в ходе игры, которые представлены 
				в виде собранной статистики за различные выполненные действия.")	
				#включает
				
				#было видео
				
				#выключает
				$"ЧернаяПлашка4".visible = false
				$"КраснаяПлашка6".visible = false
				$"анимации/Все анимации в одной".visible = false
		if Global.razdel == "skins": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Внешний вид")
				$"Лабелы/Label".text = str ("- За накопившиеся монеты
				можно приобрести новый внешний вид 
				для своего персонажа.
				- Смена врешнего вида 
				не влияет на игровой опыт.")
				#включает
				$"анимации/Все анимации в одной".play("5 стр")
				$"анимации/Все анимации в одной".visible = true
				#было видео
				
				#выключает
		if Global.razdel == "lvl": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Как играть")
				$"Лабелы/Label".text = str ("- Вам предстоит ловить падающие яблоки с дерева в корзинку, 
					зарабатывая при этом очки и монеты. 
					- С каждым пойманным яблоком игра будет усложняться, 
					делая игровой процесс более динамичным и интересным. 
					- Приобретая улучшения, игроку открывается 
					больше возможностей для сбора яблок.")	
				#включает
				$"Лабелы/Label".visible = true
				#выключает
				$"Лабелы/Label3".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
				$"анимации/Все анимации в одной".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Управление")
				#включает
				if Global.winda == true:
					$"Кнопки управления".visible = true
					$"Кнопки управления/Z".text = str ("- Использовать рывок.")
					$"Кнопки управления/X".text = str ("- Толкать ящик.")
					$"Кнопки управления/C".text = str ("- Поставить корзинку.")
					$"Кнопки управления/ПРОБЕЛ".text = str ("- Использовать прыжок / двойной прыжок.")
					$"Кнопки управления/СТРЕЛОЧКИ ЛЕВО И ПРАВО".text = str ("- Движение игрока влево / вправо.")
				else:
					$"Кнопки управленияEN".visible = true
					$"Кнопки управленияEN/Z".text = str ("- Использовать рывок.")
					$"Кнопки управленияEN/X".text = str ("- Толкать ящик.")
					$"Кнопки управленияEN/C".text = str ("- Поставить корзинку.")
					$"Кнопки управленияEN/ПРОБЕЛ".text = str ("- Использовать прыжок / двойной прыжок.")
					$"Кнопки управленияEN/СТРЕЛОЧКИ ЛЕВО И ПРАВО".text = str ("- Движение игрока влево / вправо.")
				
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false	
				$"Иконки меню".visible = false
				$"Кнопки действий".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Кнопки действий")
				#включает
				$"Кнопки действий".visible = true
				$"Кнопки действий/рывок".text = str ("- Показывает возможность использовать рывок.")
				$"Кнопки действий/ящик".text = str ("- Показывает возможность толкать ящик.")
				$"Кнопки действий/корзинка".text = str ("- Показывает возможность использовать корзинку.")
				$"Кнопки действий/прыжок".text = str ("- Показывает возможность использовать 
					прыжок / двойной прыжок.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
		if Global.razdel == "Interface": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Интерфейс: Меню")
				$"Лабелы/Label3".text = str ("- При нажатии в игре 
					выключится / включится музыка.
					- При нажатии в игре 
					выключатся / включатся все звуковые эффекты.
					- При нажатии 
					откроется / закроется «Книга Помощи».")
				#включает
				$"Лабелы/Label3".visible = true
				$"Иконки меню".visible = true
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Интерфейс параметры".visible = false
				$"Кнопки действий".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Интерфейс: Параметры")
				#включает
				$"Интерфейс параметры".visible = true
				$"Интерфейс параметры/счет".text = str ("- Текущий счет игрока за время одной игры.")
				$"Интерфейс параметры/рекорд".text = str ("- Наивысший результат игрока за всё время.")
				$"Интерфейс параметры/монета".text = str ("- Монеты игрока.")
				$"Интерфейс параметры/хп".text = str ("- Текущий счет игрока за время одной игры.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
				$"Эффекты".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Интерфейс: Эффекты")
				#включает
				$"Эффекты".visible = true
				$"Эффекты/Скорость".text = str ("- Увеличенная скорость игрока.")
				$"Эффекты/Прыжок".text = str ("- Увеличенная сила прыжка.")
				$"Эффекты/Защита".text = str ("- Щит, блокирующий один раз любой урон.")
				$"Эффекты/Неуяз".text = str ("- Неуязвимость.")
				$"Эффекты/Ветер".text = str ("- Действие ветра.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Лабелы/Label3".visible = false
				$"Интерфейс параметры".visible = false

		if Global.razdel == "prepatstvia":	#раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Препятствия")
				$"Лабелы/Label".text = str ("- Во время игры вам 
				будут попадаться различные препятвия, усложняя процесс ловли яблок. 
				
				- Существует 3 основных препятсвия:
				Сильный ветер / Ёжик / Птицы")
				#включает
				$"Лабелы/Label".visible = true
				
				#было видео
				
				#выключает
				$"Лабелы/Label3".visible = false
				$"Эффекты".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Препятсвия: Сильный ветер")
				$"Лабелы/Label".text = str ("- Сильный ветер будет сдувать объекты в том же направлении, 
					что добавляет сложность при ловле яблок.
					- Игрок против направления ветра будет двигаться с трудом, 
					а по направлению — с повышенной скоростью. 
					- Игрок во время ветра будет держать корзинку в руках, 
					облегчая поимку яблок.")
				#включает
				
				#было видео
				
				#выключает
			if Global.stranica == 3:
				$"Заголовок".text = str ("Препятсвия: Ёжик")
				$"Лабелы/Label".text = str ("- После сильного ветра с некоторым шансом будет появляться ёжик, 
					который передвигается по локации в случайном направлении.
					- При соприкосновении с ёжиком игрок потеряет здоровье, 
					а если ёжик поймает падающее яблоко, то получит его свойство.
					- Ёжик может появиться со случайным яблоком.
					- Как только начинается ветер, ёжик пропадает.")
				#включает
				$"Лабелы/Label".visible = true
			if Global.stranica == 4:
				$"Заголовок".text = str ("Препятсвия: Птицы")
				$"Лабелы/Label".text = str ("- После сильного ветра с некоторым шансом будут появляться птицы, 
					которые летают по локации в случайном направлении.
					- При соприкосновении с птицей игрок потеряет здоровье, 
					а если птица поймает падающее яблоко, то получит его свойства.
					- Птица может появиться со случайным яблоком.
					- Как только начинается ветер, птицы пропадают.")
				#включает
				$"Лабелы/Label".visible = true
				#выключает
				$"анимация яблок".visible = false
		if Global.razdel == "apple": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Обычное яблоко появляется с повышенным шансом. 
					Поймав данное яблоко, игрок получит очки и монеты. 
					Пропустив данное яблоко, игрок потеряет здоровье.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("простое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Гнилое яблоко появляется с повышенным шансом. 
					Поймав данное яблоко, игрок потеряет здоровье и очки. 
					Пропустив данное яблоко, игрок получит очки и монеты.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("гнилое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Яблоко «Скорости» появляется с пониженным шансом. 
				Поймав данное яблоко, игрок получит очки, монеты 
				и временное увеличение скорости. 
				Пропустив данное яблоко, игрок потеряет здоровье.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("скорость")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Яблоко «Прыгучести» появляется с пониженным шансом. 
					Поймав данное яблоко, игрок получит очки, монеты 
					и временное увеличение силы прыжка. 
					Пропустив данное яблоко, игрок потеряет здоровье.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("прыгучесть")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Яблоко «Защиты» появляется с маленьким шансом. 
					Поймав данное яблоко, игрок получит очки, монеты и щит, 
					блокирующий один раз любой урон. 
					Если поймать данное яблоко, уже имея активный щит, 
					игрок восстановит своё здоровье и получит ещё больше очков. 
					Пропустив данное яблоко, игрок потеряет здоровье.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("защита")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Типы яблок")
				$"Лабелы/Label".text = str ("- Золотое яблоко появляется с маленьким шансом. 
					Поймав данное яблоко, игрок получит много очков, монеты 
					и восстановит своё здоровье. 
					Если поймать данное яблоко, уже имея полное здоровье, 
					игрок получит очень много очков.
					Пропустив данное яблоко, игрок потеряет здоровье.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("золотое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
				$"КраснаяПлашка".visible = false
				$"анимация ёжиков".visible = false
		if Global.razdel == "ezh": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик без яблока 
					появляется с повышенным шансом. 
					Такой ёжик может ловить яблоки, 
					получая их свойства.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("без яблока")
				#выключает
				$"Плашка2".visible = false
				$"анимация яблок".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с простым яблоком 
					появляется с повышенным шансом. 
					Такой ёжик не может ловить другие яблоки.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("простое")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с гнилым яблоком 
					не появляется. 
					Такой ёжик сразу же 
					пропадает с локации, 
					а игрок получает очки и монеты.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("гнилое")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с яблоком «Скорости» 
					появляется с пониженным шансом. 
					Такой ёжик получает 
					повышенную скорость передвижения.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("скорость")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с яблоком «Прыгучести» 
					появляется с пониженным шансом. 
					Такой ёжик получает возможность 
					прыгать вместе с игроком.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("прыгучесть")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с яблоком «Защиты» 
					появляется с маленьким шансом. 
					Такой ёжик получает иммунитет 
					к первому сильному ветру.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("защита")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 7:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с золотым яблоком 
					появляется с маленьким шансом. 
					Такой ёжик появляется 
					вместе со своими друзьями.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("золотое")
			if Global.stranica == 8:
				$"Заголовок".text = str ("Типы ёжиков")
				$"Лабелы/Label".text = str ("- Ёжик с корзинкой не появляется. 
					С небольшой долей вероятностью 
					на ёжика без яблок можно повесить корзинку, 
					которая будет собирать для вас яблоки, 
					упавшие на ёжика. Такие яблоки принесут 
					в два раза больше очков и монет.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("корзинка")
				#выключает
				$"анимация птиц".visible = false
		if Global.razdel == "bird": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица без яблока 
					появляется с повышенным шансом. 
					Такая птица может ловить яблоки, 
					получая их свойства.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("без яблока")
				#выключает
				$"анимация ёжиков".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с простым яблоком 
					появляется с повышенным шансом. 
					Такая птица не может ловить 
					другие яблоки.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("простое")
			if Global.stranica == 3:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с гнилым яблоком не появляется. 
					Такая птица сразу же 
					пропадает с локации, 
					а игрок получает очки и монеты.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("гнилое")
			if Global.stranica == 4:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с яблоком «Скорости» 
					появляется с пониженным шансом. 
					Такая птица получает 
					повышенную скорость полёта.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("скорость")
			if Global.stranica == 5:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с яблоком «Прыгучести» 
					появляется с пониженным шансом. 
					Такая птица взлетает еще выше, 
					что затрудняет игроку возможность
					допрыгнуть до неё.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("прыгучесть")
			if Global.stranica == 6:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с яблоком «Защиты» 
					появляется с маленьким шансом. 
					Такая птица получает иммунитет 
					к первому сильному ветру.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("защита")
			if Global.stranica == 7:
				$"Заголовок".text = str ("Типы птиц")
				$"Лабелы/Label".text = str ("- Птица с золотым яблоком 
					появляется с небольшим шансом. 
					Она будет стараться улетать от игрока 
					в противоположную сторону. 
					Чтобы поймать яблоко, 
					необходимо проявить хитрость.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("золотое")
				#выключает
				$"КраснаяПлашка".visible = false
				$"анимации/Все анимации в одной".visible = false
						
	if Global.Language == "EN": #английский язык
		if Global.razdel == "nachalo": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Getting to know the game")
				$"Лабелы/Label".text = str ("FALLING APPLES
					- An indie platformer in which the player
					needs to move around the location
					and use a basket to catch apples. ")
				#включает
				$"анимации/Все анимации в одной".play("1 стр")
				$"анимации/Все анимации в одной".visible = true
				#было видео
				
				#выключает
				$"КраснаяПлашка".visible = true
				$"анимация птиц".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Getting to know the game")
				$"Лабелы/Label".text = str ("- There will be problems on your way various obstacles 
				such as weather conditions, local inhabitants of the forest, as well 
				as checking the player's reaction for various game situations.")
				#выключает
				$"анимации/Все анимации в одной".visible = false
				$"КраснаяПлашка".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Getting to know the game")
				$"Лабелы/Label".text = str ("- Earn coins during the game.
				- Buy character upgrades.
				- Set new records.
				- Play for your pleasure.")
				#включает
				$"анимации/Все анимации в одной".play("3 стр")
				$"анимации/Все анимации в одной".visible = true
		if Global.razdel == "shop": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Improvements")
				$"Лабелы/Label".text = str ("- The coins you receive
					can be spent on various
					improvements in the game,
					adding a completely different
					gaming experience.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимации/Все анимации в одной".play("4 стр")
				$"анимации/Все анимации в одной".visible = true
				#выключает
				$"Лабелы/Label2".visible = false
				$"Лабелы/Label3".visible = false
				$JumpPlashka2.visible = false
				$"КраснаяПлашка22".visible = false
				$"ЧернаяПлашка22".visible = false
			#начинается описание улучшений
			if Global.stranica == 2:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("SPEED
					A characteristic that defines, 
					how fast the player is moving.
					
					100/125/150/175 units for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка22".visible = true
				$"ЧернаяПлашка22".visible = true
				#выключает
				$"КраснаяПлашка23".visible = false
				$JumpPlashka1.visible = false
				$"ЧернаяПлашка23".visible = false
				$"Лабелы/Label2".visible = false
				$"Лабелы/Label3".visible = false
				$"анимации/Все анимации в одной".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("JUMP
					A characteristic that determines
					how high the player is capable of jumping.
					
					80/125/170/215 units for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка23".visible = true
				$"ЧернаяПлашка23".visible = true
				#выключает
				$"КраснаяПлашка22".visible = false
				$"ЧернаяПлашка22".visible = false
				$"КраснаяПлашка24".visible = false
				$"ЧернаяПлашка24".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("HEALTH
					A key parameter that allows you to stay 
					in the game as long as possible.
					
					3/4/5/6 healths for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка24".visible = true
				$"ЧернаяПлашка24".visible = true
				#выключает
				$"КраснаяПлашка23".visible = false
				$"ЧернаяПлашка23".visible = false
				$"КраснаяПлашка25".visible = false
				$"ЧернаяПлашка25".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("INVULNERABILITY
					The period of time during which the player 
					protected from any kind of damage.
					
					4/5/6/8 seconds for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"КраснаяПлашка25".visible = true
				$"ЧернаяПлашка25".visible = true
				#выключает
				$"КраснаяПлашка24".visible = false
				$"ЧернаяПлашка24".visible = false
				$"ЧернаяПлашка26".visible = false
				$"КраснаяПлашка26".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("SHURT
					The player's skill, which allows you to do 
					a quick leap forward in the direction of the player.
					
					absent/20/15/10 seconds for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка26".visible = true
				$"КраснаяПлашка26".visible = true
				#выключает
				$"КраснаяПлашка25".visible = false
				$"ЧернаяПлашка25".visible = false
				$"ЧернаяПлашка27".visible = false
				$"КраснаяПлашка27".visible = false
			if Global.stranica == 7:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("DOUBLE JUMP
					The player's skill, which allows you to do one more jump. 
					Temporarily disables the player's ability to jump.
					
					absent/12/8/4 seconds for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка27".visible = true
				$"КраснаяПлашка27".visible = true
				#выключает
				$"ЧернаяПлашка26".visible = false
				$"КраснаяПлашка26".visible = false
				$"ЧернаяПлашка28".visible = false
				$"КраснаяПлашка28".visible = false
			if Global.stranica == 8:
				$"Заголовок".text = str ("Improvements: Description")	
				$"Лабелы/Label".text = str ("THE SECOND BASKET 
					It becomes possible to install an additional shopping cart 
					at a short distance for picking apples.
					
					absent/30/25/20 seconds for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка28".visible = true
				$"КраснаяПлашка28".visible = true
				#выключает
				$"ЧернаяПлашка27".visible = false
				$"КраснаяПлашка27".visible = false
				$"ЧернаяПлашка29".visible = false
				$"КраснаяПлашка29".visible = false
			if Global.stranica == 9:
				$"Заголовок".text = str ("Improvements: Description")
				$"Лабелы/Label".text = str ("BOX
					An item that appears in the game.
					It serves to collect and strategic storage of apples.
					
					absent/1/2/3 units for 0/1/2/3 level.")
				#включает
				$"Лабелы/Label".visible = true
				$"ЧернаяПлашка29".visible = true
				$"КраснаяПлашка29".visible = true
				#выключает
				$"ЧернаяПлашка28".visible = false
				$"КраснаяПлашка28".visible = false
		if Global.razdel == "stats": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Statistics")
				$"Лабелы/Label".text = str ("- View your achievements accumulated during the game, 
				which are presented in the form of collected statistics 
				for various actions performed.")
				#выключает
				$"ЧернаяПлашка29".visible = false
				$"КраснаяПлашка29".visible = false
				$"анимации/Все анимации в одной".visible = false
		if Global.razdel == "skins": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Appearance")
				$"Лабелы/Label".text = str ("- For the accumulated coins 
					you can purchase a new look
					for your character.
					- Change of appearance 
					does not affect the gaming experience.")
				#включает
				$"анимации/Все анимации в одной".play("5 стр")
				$"анимации/Все анимации в одной".visible = true
				
				#выключает
		if Global.razdel == "lvl": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("How to play")
				$"Лабелы/Label".text = str ("- You have to catch falling apples from a tree into a basket,
					while earning points and coins. 
					- With each caught apple, the game will become more complicated,
					making the gameplay more dynamic and interesting. 
					- By purchasing improvements, the player opens up 
					more opportunities to collect apples.")	
				#включает
				$"Лабелы/Label".visible = true
				#выключает
				$"Лабелы/Label3".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
				$"анимации/Все анимации в одной".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Management")
				#включает
				if Global.winda == true:
					$"Кнопки управления".visible = true
					$"Кнопки управления/Z".text = str ("- Use a shurt")
					$"Кнопки управления/X".text = str ("- Pushing the box.")
					$"Кнопки управления/C".text = str ("- Put the basket down.")
					$"Кнопки управления/ПРОБЕЛ".text = str ("- Use a jump / double jump.")
					$"Кнопки управления/СТРЕЛОЧКИ ЛЕВО И ПРАВО".text = str ("- Movement of the player to the left / right.")
				else:
					$"Кнопки управленияEN".visible = true
					$"Кнопки управленияEN/Z".text = str ("- Use a shurt")
					$"Кнопки управленияEN/X".text = str ("- Pushing the box.")
					$"Кнопки управленияEN/C".text = str ("- Put the basket down.")
					$"Кнопки управленияEN/ПРОБЕЛ".text = str ("- Use a jump / double jump.")
					$"Кнопки управленияEN/СТРЕЛОЧКИ ЛЕВО И ПРАВО".text = str ("- Movement of the player to the left / right.")
		
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false	
				$"Кнопки действий".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Action buttons")
				#включает
				$"Кнопки действий".visible = true
				$"Кнопки действий/рывок".text = str ("- Shows the ability to use a shurt.")
				$"Кнопки действий/ящик".text = str ("- Shows the ability to push the box.")
				$"Кнопки действий/корзинка".text = str ("- Shows the possibility to use the basket.")
				$"Кнопки действий/прыжок".text = str ("- Shows the ability to use 
					a jump / double jump.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
		if Global.razdel == "Interface": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Interface: Menu")
				$"Лабелы/Label3".text = str ("- When you click in the game 
 					the music will turn off / on.
 					- When you click in the game 
 					all sound effects will turn off / on.
 					- When pressed 
 					The «Help Book» will open / close.")
				#включает
				$"Лабелы/Label3".visible = true
				$"Иконки меню".visible = true
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Кнопки управления".visible = false
				$"Интерфейс параметры".visible = false
				$"Кнопки действий".visible = false
				$"Кнопки управления".visible = false
				$"Кнопки управленияEN".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Interface: Parameters")
				#включает
				$"Интерфейс параметры".visible = true
				$"Интерфейс параметры/счет".text = str ("- The player current score during one game.")
				$"Интерфейс параметры/рекорд".text = str ("- The player highest score of all time.")
				$"Интерфейс параметры/монета".text = str ("- Player coins.")
				$"Интерфейс параметры/хп".text = str ("- The player current score during one game.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Плашка2".visible = false
				$"Иконки меню".visible = false
				$"Лабелы/Label3".visible = false
				$"Эффекты".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Interface: Effects")
				#включает
				$"Эффекты".visible = true
				$"Эффекты/Скорость".text = str ("- Increased player speed.")
				$"Эффекты/Прыжок".text = str ("- Increased jump power.")
				$"Эффекты/Защита".text = str ("- A shield that blocks any damage once.")
				$"Эффекты/Неуяз".text = str ("- Invulnerability.")
				$"Эффекты/Ветер".text = str ("- The effect of the wind.")
				#выключает
				$"Лабелы/Label".visible = false
				$"Интерфейс параметры".visible = false
				$"Лабелы/Label3".visible = false

		if Global.razdel == "prepatstvia":	#раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Obstacles")
				$"Лабелы/Label".text = str ("- During the game you will there will be various obstacles,
					complicating the process of catching apples. 
					
					- There are 3 main obstacles:
					Strong wind / Hedgehog / Birds")
				#включает
				$"Лабелы/Label".visible = true
				#выключает
				$"Лабелы/Label3".visible = false
				$"Эффекты".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Obstacles: Strong wind")
				$"Лабелы/Label".text = str ("- Strong wind it will blow away objects 
 					in the same direction, what adds difficulty in catching apples.
					- The player will move with difficulty against
					the direction of the wind, and with increased speed in the direction. 
					- The player will hold the basket in his hands during the wind, 
					making it easier to catch apples.")
				
			if Global.stranica == 3:
				$"Заголовок".text = str ("Obstacles: Hedgehog")
				$"Лабелы/Label".text = str ("- After the end of the wind with some chance a hedgehog will appear,
					which will move around the location in a random direction.
					- When in contact with a hedgehog , the player will lose health, 
					and if the hedgehog catches a falling apple, it gets its property.
					- The hedgehog may appear with a random apple.
					- As soon as the wind starts, the hedgehog disappears.")
				#включает
				$"Лабелы/Label".visible = true
			
			if Global.stranica == 4:
				$"Заголовок".text = str ("Obstacles: Birds")
				$"Лабелы/Label".text = str ("- After the end of the strong wind with some probability birds will appear
				that will fly around the location in a random direction.
				- Upon contact with a bird , the player will lose health, 
				and if a bird catches a falling apple, it will receive its properties.
				- The bird may appear with a random apple.
				- As soon as the wind starts, the birds disappear.")
				#включает
				$"Лабелы/Label".visible = true
				#выключает
				$"анимация яблок".visible = false
		if Global.razdel == "apple": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- An common apple appears with an increased chance. 
					After catching this apple, the player 
					will receive points and coins. 
					By missing this apple, the player will lose health.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("простое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- A rotten apple appears with an increased chance. 
					After catching this apple, the player 
					will lose health and points. 
					By missing this apple, the player will receive points and coins.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("гнилое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- Apple of «Speed» appears with a reduced chance. 
					Catching this apple, the player will receive points, coins 
					and a temporary increase in speed. 
					By missing this apple, the player will lose health.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("скорость")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- Apple of «Jump» appears with a reduced chance. 
				Catching this apple, the player will receive points, coins 
				and a temporary increase in the strength of the jump. 
				By missing this apple, the player will lose health.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("прыгучесть")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- Apple of «Protection» appears with a small chance. 
					After catching this apple, the player will receive points, 
					coins and a shield that blocks any damage once. 
					If you catch this apple while already having an active shield,
					the player will restore his health and get even more points. 
					By missing this apple, the player will lose health.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("защита")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Types of apples")
				$"Лабелы/Label".text = str ("- Golden apple appears with a small chance. 
					Catching this apple, the player will get a lot of points, coins 
					and he will restore his health. 
					If you catch this apple, already having full health, 
					the player will get a lot of points.
					By missing this apple, the player will lose health.")
				#включает
				$"анимация яблок".visible = true
				$"анимация яблок".play("золотое")
				$"Лабелы/Label".visible = true
				#выключает
				$"Плашка2".visible = false
				$"КраснаяПлашка".visible = false
				$"анимация ёжиков".visible = false
		if Global.razdel == "ezh": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog without an apple 
					appears with an increased chance. 
					Such a hedgehog can catch apples,
					getting their properties.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("без яблока")
				#выключает
				$"Плашка2".visible = false
				$"анимация яблок".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with a common apple 
					appears with an increased chance. 
					Such a hedgehog cannot catch other apples.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("простое")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 3:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with the rotten apple
					does not appear. 
					Such a hedgehog immediately
					disappears from the location,
					and the player receives points and coins.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("гнилое")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 4:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with an apple of «Speed» 
					appears with a reduced chance. 
					Such a hedgehog gets 
					increased movement speed.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("скорость")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 5:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with an apple of «Jump»
					appears with a reduced chance. 
					Such a hedgehog gets the opportunity
					to jump with the player.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("прыгучесть")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 6:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with an apple of «Protection» 
					appears with a small chance. 
					Such a hedgehog gets immunity
					to the first strong wind.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("защита")
				#выключает
				$"Плашка2".visible = false
			if Global.stranica == 7:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with a golden apple 
					appears with a small chance. 
					Such a hedgehog appears 
					together with your friends.")
				#включает
				$"Лабелы/Label".visible = true
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("золотое")
			if Global.stranica == 8:
				$"Заголовок".text = str ("Types of hedgehogs")
				$"Лабелы/Label".text = str ("- Hedgehog with the basket does not appear. 
					With a small probability 
					you can hang a basket on a hedgehog without apples, 
					who will collect apples for you, 
					fallen on a hedgehog. Such apples will bring
					twice as many points and coins.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация ёжиков".visible = true
				$"анимация ёжиков".play("корзинка")
				#выключает
				$"анимация птиц".visible = false
		if Global.razdel == "bird": #раздел
			if Global.stranica == 1:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird without an apple 
					appears with an increased chance. 
					Such a bird can catch apples,
					obtaining their properties.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("без яблока")
				#выключает
				$"анимация ёжиков".visible = false
			if Global.stranica == 2:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with a common apple 
					appears with an increased chance. 
					Such a bird cannot catch
					other apples.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("простое")
			if Global.stranica == 3:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with the rotten apple does not appear. 
					Such a bird immediately
					disappears from the location,
					and the player receives points and coins.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("гнилое")
			if Global.stranica == 4:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with an apple of «Speed» 
					appears with a reduced chance. 
					Such a bird gets 
					increased flight speed.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("скорость")
			if Global.stranica == 5:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with an apple of «Jump»
					appears with a reduced chance. 
					Such a bird flies even higher, 
					which makes it difficult for the player to
					jump to it.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("прыгучесть")
			if Global.stranica == 6:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with an apple of «Protection» 
					appears with a small chance. 
					Such a bird is immune
					to the first strong wind.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("защита")
			if Global.stranica == 7:
				$"Заголовок".text = str ("Types of birds")
				$"Лабелы/Label".text = str ("- Bird with the golden apple 
					appears with a small chance. 
					She will try to fly away from the player 
					in the opposite direction. 
					To catch an apple,
					you need to be cunning.")
				#включает
				$"Лабелы/Label".visible = true	
				$"анимация птиц".visible = true
				$"анимация птиц".play("золотое")
				#выключает
				$"анимации/Все анимации в одной".visible = false
				$"КраснаяПлашка".visible = false

func _on_лево_книга_pressed() -> void:
	if Global.razdel == "nachalo":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "bird"
			Global.stranica = 7
			return
	if Global.razdel == "shop":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "nachalo"
			Global.stranica = 3
			return
	if Global.razdel == "stats":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "shop"
			Global.stranica = 9
			return
	if Global.razdel == "skins":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "stats"
			Global.stranica = 1
			return
	if Global.razdel == "lvl":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "skins"
			Global.stranica = 1
			return
	if Global.razdel == "Interface":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "lvl"
			if Global.winda == true:
				Global.stranica = 3
			else:
				Global.stranica = 2
			return
	if Global.razdel == "prepatstvia":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "Interface"
			Global.stranica = 3
			return
	if Global.razdel == "apple":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "prepatstvia"
			Global.stranica = 4
			return
	if Global.razdel == "ezh":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "apple"
			Global.stranica = 6
			return
	if Global.razdel == "bird":
		if Global.stranica >= 1:
			Global.stranica -= 1
		if Global.stranica == 0:
			Global.razdel = "ezh"
			Global.stranica = 8
			return


func _on_право_книга_pressed() -> void:
	if Global.razdel == "nachalo":
		if Global.stranica <= 3:
			Global.stranica += 1
		if Global.stranica == 4:
			Global.razdel = "shop"
			Global.stranica = 1
			return
	if Global.razdel == "shop":
		if Global.stranica <= 9:
			Global.stranica += 1
		if Global.stranica == 10:
			Global.razdel = "stats"
			Global.stranica = 1
			return
	if Global.razdel == "stats":
		if Global.stranica <= 1:
			Global.stranica += 1
		if Global.stranica == 2:
			Global.razdel = "skins"
			Global.stranica = 1
			return
	if Global.razdel == "skins":
		if Global.stranica <= 1:
			Global.stranica += 1
		if Global.stranica == 2:
			Global.razdel = "lvl"
			Global.stranica = 1
			return
	if Global.razdel == "lvl":
		if Global.winda == true:
			if Global.stranica <= 3:
				Global.stranica += 1
			if Global.stranica == 4:
				Global.razdel = "Interface"
				Global.stranica = 1
				return
		else:
			if Global.stranica <= 2:
				Global.stranica += 1
			if Global.stranica == 3:
				Global.razdel = "Interface"
				Global.stranica = 1
				return
	if Global.razdel == "Interface":
		if Global.stranica <= 3:
			Global.stranica += 1
		if Global.stranica == 4:
			Global.razdel = "prepatstvia"
			Global.stranica = 1
			return
	if Global.razdel == "prepatstvia":
		if Global.stranica <= 4:
			Global.stranica += 1
		if Global.stranica == 5:
			Global.razdel = "apple" #по новой страница открылась
			Global.stranica = 1
			return
	if Global.razdel == "apple":
		if Global.stranica <= 6:
			Global.stranica += 1
		if Global.stranica == 7:
			Global.razdel = "ezh"
			Global.stranica = 1
			return
	if Global.razdel == "ezh":
		if Global.stranica <= 8:
			Global.stranica += 1
		if Global.stranica == 9:
			Global.razdel = "bird"
			Global.stranica = 1
			return
	if Global.razdel == "bird":
		if Global.stranica <= 7:
			Global.stranica += 1
		if Global.stranica == 8:
			Global.razdel = "nachalo"
			Global.stranica = 1
			return
