extends CanvasLayer

func _process(delta: float) -> void:
	$record.text = str(Global.hi_score)
	
	$score.text = str(Global.score)
	
	$money.text = str(Global.gold)
