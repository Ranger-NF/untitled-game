extends Control

@onready var build_grid_node: GridContainer = $CanvasLayer/CenterContainer/GridContainer

const GRID_CELL_TEXTURE: Texture2D = preload("res://UI/Builder/build_cell.svg")

var cell_id: int = 0 # Must be incremented (unique to each cell)

func _ready() -> void:
    init_grid(3, 2) # Rows x Cols

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

        var new_cell_node: TextureButton = TextureButton.new()
        new_cell_node.texture_normal = GRID_CELL_TEXTURE

        build_grid_node.add_child(new_cell_node)
