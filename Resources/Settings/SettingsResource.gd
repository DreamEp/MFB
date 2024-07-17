class_name DefaultSettingsResource
extends Resource

const NAME_WINDOW_MODE_INDEX: String = "window_mode_index"
const NAME_RESOLUTION_INDEX: String = "resolution_index"
const NAME_MASTER_VOLUME: String = "master_volume"
const NAME_MUSIC_VOLUME: String = "music_volume"
const NAME_SFX_VOLUME: String = "sfx_volume"
const NAME_AUTO_AIM_STATE: String = "auto_aim_state"

const DEFAULT_WINDOW_MODE_INDEX: int = 1
const DEFAULT_RESOLUTION_INDEX: int = 1
const DEFAULT_MASTER_VOLUME: float = 50.0
const DEFAULT_MUSIC_VOLUME: float = 50.0
const DEFAULT_SFX_VOLUME: float = 50.0
const DEFAULT_AUTO_AIM_STATE: bool = false

var window_mode_index: int = 0
var resolution_index: int = 0
var master_volume: float = 0.0
var music_volume: float = 0.0
var sfx_volume: float = 0.0
var auto_aim_state: bool = false
