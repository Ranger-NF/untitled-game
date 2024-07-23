extends RigidBody2D

const LIFETIME: float = 2
const FORCE_MAGNITUDE: float = 250

var is_activated: bool = false

func _ready() -> void:
    $LifetimeTimer.timeout.connect(deactivate)

    await get_tree().create_timer(2.5).timeout
    activate()

func activate():
    is_activated = true
    add_constant_central_force(Vector2(0, -1 * FORCE_MAGNITUDE))
    $CPUParticles2D.emitting = true
    $LifetimeTimer.start(LIFETIME)

func deactivate():
    constant_force = Vector2.ZERO
    is_activated = false
    $CPUParticles2D.emitting = false
