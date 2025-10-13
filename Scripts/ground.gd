extends StaticBody2D
class_name Ground
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var polygon_2d: Polygon2D = $Polygon2D

func _ready() -> void:
	copy_collision_now()

func copy_collision_now() ->void:
	collision_polygon_2d.polygon = polygon_2d.polygon
