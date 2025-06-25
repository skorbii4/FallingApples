extends Node2D

@onready var zagolov = $"Заголовок"
@onready var texts = $"Текст"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.Language == "RU":
		zagolov.text = str ("Новости")
		texts.text = str ("В игре обновлено:
			1. Изменена стоимость приобретения внешнего вида.
				• Второй скин 200 -> 150 / Третий скин 350 -> 275 / Четвёртый скин 500 -> 350.
			2. Ускорена загрузка игры.
			3. Сделано более корректное сохранение результатов игры.
			4. Исправлена встречающаяся ошибка:
				• Появлялось несколько ёжиков одновременно, без золотого яблока.
			5. Уменьшена зона для сброса яблок у птиц
			6. Добавлено отображение управления перед началом игры.
			7. Создан блок «Новости».")
	else:
		zagolov.text = str ("News")
		texts.text = str ("In the game, the following updates have been made:
			1. The cost of acquiring skins has been changed:
				• Second skin: 200 -> 150 / Third skin: 350 -> 275 / Fourth skin: 500 -> 350.
			2. The game loading has been sped up.
			3. More accurate saving of game results has been implemented.
			4. Fixed a recurring bug:
				• Multiple hedgehogs appeared simultaneously without a golden apple.
			5. Reduced the area for dropping apples by the birds.
			6. Added control display before the start of the game.
			7. Created a «News» block.")
