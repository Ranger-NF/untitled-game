extends Control

@onready var build_grid_node: GridContainer = $CanvasLayer/VBoxContainer/CenterContainer/GridContainer
@onready var start_button_node: Button = $CanvasLayer/VBoxContainer/ControlPanel/StartButton

const GRID_CELL_TEXTURE: Texture2D = preload("res://UI/Builder/build_cell.svg")

var cell_id: int = 0 # Must be incremented (unique to each cell)

func _ready() -> void:
    start_button_node.pressed.connect(_on_building_finished)
    init_grid(2, 3)

func _on_building_finished()-> void:
    pass

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

func _on_build_cell_pressed(pressed_cell_node: CanvasItem, _pressed_cell_id: int) -> void:
    pressed_cell_node.modulate.r = 0
