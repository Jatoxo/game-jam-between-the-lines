shader_type canvas_item;

uniform float amplitude = 10.0;
uniform float speed = 1.0;

void vertex() {
    float t = TIME * speed;

    VERTEX += vec2(
        cos(t),
        sin(t)
    ) * amplitude;
}