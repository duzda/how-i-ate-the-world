extends Node2D

var count: int

func _ready():
	self.count = self.get_child_count()


func notify_removal():
	self.count -= 1
	
	if self.count <= 0:
		print("end game")
