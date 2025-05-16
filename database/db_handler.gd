extends Node
class_name DBHandler

# Импорт SQLite плагина
var db : SQLite = SQLite.new()
var current_player_id : int = -1

# Путь к базе данных (user:// - для записи данных)
var db_path : String = "res://database/data_base.db"

func _init() -> void:
	db.path = db_path
	
	if db.open_db():
		print("База данных успешно открыта по пути: ", db_path)
		create_tables()
		insert_default_achievements()
	else:
		push_error("Ошибка при открытии базы данных.")

func create_tables() -> void:
	db.query("""
	CREATE TABLE IF NOT EXISTS player (
		player_id INTEGER PRIMARY KEY AUTOINCREMENT,
		login TEXT NOT NULL UNIQUE,
		password TEXT NOT NULL
	);
	""")

	db.query("""
	CREATE TABLE IF NOT EXISTS records (
		record_id INTEGER PRIMARY KEY AUTOINCREMENT,
		player_id INTEGER NOT NULL,
		score INTEGER NOT NULL,
		date TEXT NOT NULL,
		FOREIGN KEY (player_id) REFERENCES player(player_id)
	);
	""")

	db.query("""
	CREATE TABLE IF NOT EXISTS game (
		game_id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		genre TEXT NOT NULL,
		release_date TEXT NOT NULL
	);
	""")

	db.query("""
	CREATE TABLE IF NOT EXISTS session (
		session_id INTEGER PRIMARY KEY AUTOINCREMENT,
		player_id INTEGER NOT NULL,
		start_time TEXT NOT NULL,
		end_time TEXT NOT NULL,
		FOREIGN KEY (player_id) REFERENCES player(player_id)
	);
	""")

	db.query("""
	CREATE TABLE IF NOT EXISTS achievement (
		achievement_id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		description TEXT NOT NULL
	);
	""")

	db.query("""
	CREATE TABLE IF NOT EXISTS player_achievement (
		player_id INTEGER NOT NULL,
		achievement_id INTEGER NOT NULL,
		date_unlocked TEXT NOT NULL,
		FOREIGN KEY (player_id) REFERENCES player(player_id),
		FOREIGN KEY (achievement_id) REFERENCES achievement(achievement_id),
		PRIMARY KEY (player_id, achievement_id)
	);
	""")
	
func insert_default_achievements():
	# Убедимся, что поле name уникальное
	db.query("CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_achievement_name ON achievement(name);")

	var achievements = [
		{"name": "First Blood", "description": "Убей 1 зомби"},
		{"name": "Zombie Slayer", "description": "Убей 10 зомби"},
		{"name": "Apocalypse Hero", "description": "Убей 100 зомби"}
	]

	for a in achievements:
		db.query("""
			INSERT OR IGNORE INTO achievement (name, description)
			VALUES ('%s', '%s');
		""" % [a["name"], a["description"]])

func update_total_score(points: int) -> void:
	if current_player_id == -1:
		print("Игрок не авторизован — очки не начисляются.")
		return

	# Проверяем, есть ли уже запись в таблице records
	db.query("SELECT score FROM records WHERE player_id = %d;" % current_player_id)

	if db.query_result.size() > 0:
		# Обновляем очки
		var current_score = db.query_result[0]["score"]
		var new_score = current_score + points
		db.query("UPDATE records SET score = %d, date = '%s' WHERE player_id = %d;" %
			[new_score, Time.get_datetime_string_from_system(), current_player_id])
	else:
		# Создаём новую запись, если игрока ещё нет
		db.query("INSERT INTO records (player_id, score, date) VALUES (%d, %d, '%s');" %
			[current_player_id, points, Time.get_datetime_string_from_system()])



func register_player(login: String, password: String) -> bool:
	if login.is_empty() or password.is_empty():
		return false

	db.query("""
	INSERT INTO player (login, password)
	VALUES ('%s', '%s');
	""" % [login, password])

	if db.error_message:
		print("Ошибка при регистрации: ", db.error_message)
		return false

	return true

func login_player(login: String, password: String) -> bool:
	db.query("""
	SELECT player_id FROM player 
	WHERE login = '%s' AND password = '%s';	
	""" % [login, password])

	if db.query_result.size() > 0:
		current_player_id = db.query_result[0]["player_id"]
		return true
	return false
func check_achievements(kills: int) -> void:
	if current_player_id == -1:
		print("Игрок не авторизован")
		return

	var kill_milestones = {
		1: "First Blood",
		10: "Zombie Slayer",
		100: "Apocalypse Hero"
	}

	for milestone_kills in kill_milestones.keys():
		if kills >= milestone_kills:
			var name = kill_milestones[milestone_kills]
			db.query("""
				SELECT achievement.achievement_id
				FROM achievement
				LEFT JOIN player_achievement 
				ON achievement.achievement_id = player_achievement.achievement_id
				AND player_achievement.player_id = %d
				WHERE achievement.name = '%s' AND player_achievement.achievement_id IS NULL;
			""" % [current_player_id, name])

			if db.query_result.size() > 0:
				var achievement_id = db.query_result[0]["achievement_id"]
				var now = Time.get_datetime_string_from_system()
				db.query("""
					INSERT INTO player_achievement (player_id, achievement_id, date_unlocked)
					VALUES (%d, %d, '%s');
				""" % [current_player_id, achievement_id, now])
				print("Ачивка получена: %s" % name)
