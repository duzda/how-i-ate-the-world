extends StaticBody2D

func pop():
	self.get_parent().notify_removal()
	self.get_parent().remove_child(self)
