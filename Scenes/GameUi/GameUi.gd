extends Control
class_name GameUI

@onready var level_num: Label = $MC/VB/HB/LevelNum
@onready var time: Label = $MC/VB/HB2/MovesNum
@onready var best_num: Label = $MC/VB/HB3/BestNum
@onready var hb_3: HBoxContainer = $MC/VB/HB3
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var record: Label = $NinePatchRect/MarginContainer/VBoxContainer/VBoxContainer2/Record
@onready var moves: Label = $NinePatchRect/MarginContainer/VBoxContainer/VBoxContainer2/Moves

var _time:float=0.0
var _score:int=0

func _process(delta: float) -> void:
	_time+=delta
func incrementMoves(moves:int)->void:
	_score=moves

func gameOver(movesTaken:int,newRecord:bool)->void:
	moves.text="You took %d moves"%_score
	nine_patch_rect.visible=true
