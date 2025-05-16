extends Control

# Путь к основной сцене
const MAIN_MENU_SCENE_PATH = "res://scenes/opening/opening.tscn"

# Загружаем скрипт db_handler.gd
var db_handler = DbHandler


# Узлы интерфейса
@onready var login_input = $UI_Container/Form/LoginInput
@onready var password_input = $UI_Container/Form/PasswordInput
@onready var message_label = $UI_Container/Form/MessageLabel
@onready var register_button = $UI_Container/Form/ButtonsContainer/RegisterButton
@onready var login_button = $UI_Container/Form/ButtonsContainer/LoginButton

func _ready() -> void:
	register_button.pressed.connect(_on_register_button_pressed)
	login_button.pressed.connect(_on_login_button_pressed)

func _on_register_button_pressed() -> void:
	var login = login_input.text.strip_edges()
	var password = password_input.text.strip_edges()

	if login.is_empty() or password.is_empty():
		message_label.text = "Логин или пароль не могут быть пустыми."
		return

	if DbHandler.register_player(login, password):
		DbHandler.login_player(login, password) # сразу логинимS
		message_label.text = "Регистрация успешна! Входим в игру..."
		get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)
	else:
		message_label.text = "Ошибка: Логин уже существует."

func _on_login_button_pressed() -> void:
	var login = login_input.text.strip_edges()
	var password = password_input.text.strip_edges()

	if login.is_empty() or password.is_empty():
		message_label.text = "Логин или пароль не могут быть пустыми."
		return

	if DbHandler.login_player(login, password):
		message_label.text = "Вход выполнен успешно!"
		print("ID игрока:", DbHandler.current_player_id)
		get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)
	else:
		message_label.text = "Ошибка: Неправильный логин или пароль."
