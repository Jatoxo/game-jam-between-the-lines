shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 100.0) = 20.0;
uniform float speed : hint_range(0.0, 10.0) = 2.0;

void vertex() {
    float wave = sin(TIME * speed) + 1.0;

    // UV.y is 0 at the top and 1 at the bottom.
    // Convert that to -1 at top, +1 at bottom.
    float direction = UV.y * 2.0 - 1.0;

    VERTEX.y += direction * amplitude * wave;
}