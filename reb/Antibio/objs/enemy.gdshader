shader_type canvas_item;
uniform float Dir = 1.0;
void fragment() {
	vec2 mov = vec2(UV.x-(TIME*Dir),UV.y);
	vec4 dna = texture(TEXTURE,mov);
	COLOR = dna;
}
