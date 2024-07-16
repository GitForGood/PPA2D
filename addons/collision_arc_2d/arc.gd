@tool


extends CollisionPolygon2D
class_name CollisionArc2D


@export_range(3,32) var arc_points: int = 7: 
	set(value):
		arc_points = max(value,3)
		_update_points(arc_points, arc_width_radians, arc_radius)

@export_range(0,TAU) var arc_width_radians: float = PI:
	set(value):
		arc_width_radians = clampf(value, 0, TAU)
		_update_points(arc_points, arc_width_radians, arc_radius)

@export var arc_radius: float = 10.0: 
	set(value):
		arc_radius = value
		_update_points(arc_points, arc_width_radians, arc_radius)


func _update_points(n_points: int, radians: float, radius: float):
	var points: Array[Vector2] = []
	points.resize(n_points+1)
	var base_radians: float = -radians/2
	var radians_divisor: float = n_points - 1
	for index in range(0,radians_divisor):
		var current_radians: float = base_radians + radians * index / radians_divisor
		var x = cos(current_radians) * radius
		var y = sin(current_radians) * radius
		points[index] = Vector2(x,y)
	points[radians_divisor] = points[0].reflect(Vector2.RIGHT)
	points[n_points] = Vector2.ZERO
	set_polygon(points)
