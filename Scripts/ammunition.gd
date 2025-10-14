extends RigidBody2D

#@onready var ground: Ground = get_node("../ground")
@export var ground: Ground

@onready var destruction_area_2d: Area2D = $Destruction_Area2D
@onready var polygon_2d: Polygon2D = null #$"../ground/Polygon2D"
#@onready var ground: Ground = $"../ground"




func _on_body_entered(body: Node) -> void:
	if body.get_groups().has("Ground") or body.get_groups().has("Enemy"):
		if ground is Ground:
			ground.update_polygon_2d(global_position)
			for overlap in destruction_area_2d.get_overlapping_bodies():
				if overlap.get_groups().has("Enemy"):
					overlap.queue_free()
				queue_free()
			
func update_polygon_2d(pos:Vector2)->void:
	var new_values = draw_circle_polygon(pos, 20 , 100)
	var res = Geometry2D.clip_polygons(polygon_2d.polygon, new_values)
	polygon_2d.polygon = res[0]
	call_deferred("copy_collision_now") #LLama a la funcion para actualizar los puntos de poligono
	
	
func draw_circle_polygon(pos: Vector2, points_nb: int, radius:float) -> PackedVector2Array:
	var points := PackedVector2Array()
	for i in range(points_nb+1):
		var point = deg_to_rad(i * 360.0 / points_nb)
		points.push_back(pos+ Vector2(cos(point), sin(point)) * radius)
	return points
