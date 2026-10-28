extends CharacterBody2D
class_name PersonagemBase

var _prefixo_animacao: String = "_b"

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
	_animar()

func _animar() -> void:
	if velocity == Vector2.ZERO:
		_animador.play("parado" + _prefixo_animacao)
	
	elif velocity != Vector2.ZERO:
		_animador.play("andando" + _prefixo_animacao)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
