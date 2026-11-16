@tool
extends StaticBody3D
@export var size := Vector3(1, 1, 1) 

func _ready():
	if $MeshInstance3D.mesh:
		var new_mesh = $MeshInstance3D.mesh.duplicate()
		if new_mesh is BoxMesh:
			new_mesh.size = size
		$MeshInstance3D.mesh = new_mesh
	
	# You need to duplicate the shape too!
	if $CollisionShape3D.shape is BoxShape3D:
		var new_shape = $CollisionShape3D.shape.duplicate()
		new_shape.size = size
		$CollisionShape3D.shape = new_shape
