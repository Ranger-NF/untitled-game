extends Control

signal exited_building_ui

@onready var build_grid_node: GridContainer = $CanvasLayer/VBoxContainer/CenterContainer/GridContainer
@onready var start_button_node: Button = $CanvasLayer/VBoxContainer/ControlPanel/StartButton

enum CONTRAPTIONS {
    BLOCK,
    BOOSTER
}

enum GRID_INFO {
    ROW,
    COL
}

const CONTRAPTION_SCENES: Dictionary = {
    CONTRAPTIONS.BLOCK: preload("res://Contraptions/Blocks/block.tscn"),
    CONTRAPTIONS.BOOSTER: preload("res://Contraptions/Boosters/booster.tscn")
}
const GRID_CELL_TEXTURE: Texture2D = preload("res://UI/Builder/build_cell.svg")

var current_grid_info: Dictionary = {
    GRID_INFO.ROW: 3,
    GRID_INFO.COL: 3
}

var cell_id: int = 0 # Must be incremented (unique to each cell)
var occupied_cell_ids: Array[int] = []

func _ready() -> void:
    start_button_node.pressed.connect(_on_building_finished)
    init_grid(current_grid_info.get(GRID_INFO.ROW), current_grid_info.get(GRID_INFO.COL))

func _on_building_finished()-> void:
    $CanvasLayer.hide()
    self.emit_signal("exited_building_ui")

func init_grid(num_of_rows: int, num_of_cols: int) -> void:
    build_grid_node.columns = num_of_cols

    var columns_populated: int = 0

    while columns_populated < num_of_cols:
        prepare_rows(num_of_rows)
        columns_populated += 1

func prepare_rows(num_of_rows: int):
    var current_row_num: int = 0

    while current_row_num < num_of_rows:
        current_row_num += 1

        var current_cell_id = cell_id
        cell_id +=1
        var new_cell_node: TextureButton = TextureButton.new()
        new_cell_node.texture_normal = GRID_CELL_TEXTURE

        build_grid_node.add_child(new_cell_node)
        new_cell_node.pressed.connect(_on_build_cell_pressed.bind(new_cell_node, current_cell_id))

func spawn_block(global_spawn_pos: Vector2):
    var new_block_instance: RigidBody2D = CONTRAPTION_SCENES.get(CONTRAPTIONS.BLOCK).instantiate()
    new_block_instance.freeze = true
    new_block_instance.global_position = global_spawn_pos

    self.exited_building_ui.connect(func(): new_block_instance.freeze = false)

    self.get_parent().add_child(new_block_instance)

func join_contraption():
    # For each occupied cell, find the nearest neighbour horizontally and vertically
    var current_row_num: int = 1


    # On each axis, add a pin joint between neightbours

func _on_build_cell_pressed(pressed_cell_node: BaseButton, pressed_cell_id: int) -> void:
    pressed_cell_node.disabled = true
    spawn_block(pressed_cell_node.global_position + (pressed_cell_node.size / 2))

    occupied_cell_ids.append(pressed_cell_id)
