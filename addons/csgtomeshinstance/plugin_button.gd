# Button to activate the painting and show the paint panel

@tool
extends Button

class_name PluginButton

var root :Node
var csg :CSGShape3D

# Show button in UI, untoggled
func show_button(root: Node, csg :CSGShape3D):
	self.root = root
	self.csg = csg
	show()

# Hide button in UI, untoggled
func hide_button():
	hide()

func _on_PluginButton_pressed() -> void:
	convert_csg_to_meshinstance()

func convert_csg_to_meshinstance():
	var mesh_instance = MeshInstance3D.new()
	var csg_mesh = csg.get_meshes()[1]
	var csg_transform = csg.global_transform
	var csg_name = csg.name
	mesh_instance.mesh = csg_mesh
	csg.get_parent().add_child(mesh_instance)
	csg.get_parent().remove_child(csg)
	mesh_instance.owner = root
	mesh_instance.global_transform = csg_transform
	mesh_instance.name = csg_name
