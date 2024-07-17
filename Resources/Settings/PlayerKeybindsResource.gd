class_name PlayerKeybindsResource
extends Resource


const UP: String = "up"
const DOWN: String = "down"
const LEFT: String = "left"
const RIGHT: String = "right"
const MENU: String = "menu"

@export var DEFAULT_UP_KEY = InputEventKey.new()
@export var DEFAULT_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MENU_KEY = InputEventKey.new()

var up_key = InputEventKey.new()
var down_key = InputEventKey.new()
var left_key = InputEventKey.new()
var right_key = InputEventKey.new()
var menu_key = InputEventKey.new()
