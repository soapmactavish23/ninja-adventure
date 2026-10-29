extends CharacterBody2D
class_name PersonagemBase

var _prefixo_animacao: String = "_b"
var _pode_atacar: bool = true
var _atacando: bool = false

@export_category("Objects")
@export var _animador: AnimationPlayer

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
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
	
	_animar()

func _animar() -> void:
	if _atacando == true:
		_animador.play("ataque" + _prefixo_animacao)
	
	elif velocity == Vector2.ZERO:
		_animador.play("parado" + _prefixo_animacao)
	
	elif velocity != Vector2.ZERO:
		_animador.play("andando" + _prefixo_animacao)


func _quando_animacao_terminar(_anim_name: StringName) -> void:
	if _anim_name.contains("ataque"):
		_atacando = false
		_pode_atacar = true
		set_physics_process(true)
