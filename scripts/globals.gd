extends Node

var player: CharacterBody3D
var playerCamera: Callable

func in_front_of_player(scale: Vector3 = Vector3(4,4,4)) -> Vector3:
	var camera: Camera3D = playerCamera.call()
	return player.position + Vector3(0,camera.position.y,0) + (-camera.get_global_transform().basis.z * scale)
