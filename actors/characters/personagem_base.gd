extends CharacterBody2D
class_name PersonagemBase

enum Personagens {
	egg_boy = 0, hunter = 1, mask_racoon = 2,
	monkey_boxer_blue = 3, robot_comouflage = 4
}

var _ataque_selecionado: String = ""
var _prefixo_animacao: String = "_b"
var _pode_atacar: bool = true
var _atacando: bool = false

@export_category("Objetos")
@export var _animador: AnimationPlayer

@export_category("Variaveis")
@export var _textura: Sprite2D
@export var _personagem_selecionado: Personagens
@export var _codigo_personagem: Array[String]

func _ready():
	_textura.texture = load(
		'res://actors/characters/' + _codigo_personagem[_personagem_selecionado] + '/spritesheet.png'
	)

func _physics_process(delta: float) -> void:
	var direcao: Vector2 = Input.get_vector(
		"mover_e", "mover_d", "mover_c", "mover_b"
	)
	
	if Input.is_action_pressed("mover_e"):
		_prefixo_animacao = "_e"
		
	if Input.is_action_pressed("mover_d") :
		_prefixo_animacao = "_d"
		
	if Input.is_action_pressed("mover_b") and direcao.y != 0:
		_prefixo_animacao = "_b"
		
	if Input.is_action_pressed("mover_c") and direcao.y != 0:
		_prefixo_animacao = "_c"
	
	velocity = direcao * 64.0
	move_and_slide()
	
	if Input.is_action_just_pressed("ataque") and _pode_atacar:
		_ataque_selecionado = "ataque" + _prefixo_animacao
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
	
	elif Input.is_action_just_pressed("ataque_especial_1") and _pode_atacar:
		_ataque_selecionado = "ataque_especial_1"
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
		
	elif Input.is_action_just_pressed("ataque_especial_2") and _pode_atacar:
		_ataque_selecionado = "ataque_especial_2"
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
	
	_animar()

func _animar() -> void:
	if _atacando == true:
		_animador.play(_ataque_selecionado)
	
	elif velocity == Vector2.ZERO:
		_animador.play("parado" + _prefixo_animacao)
	
	elif velocity != Vector2.ZERO:
		_animador.play("andando" + _prefixo_animacao)


func _quando_animacao_terminar(_anim_name: StringName) -> void:
	if _anim_name.contains("ataque"):
		_atacando = false
		_pode_atacar = true
		set_physics_process(true)
