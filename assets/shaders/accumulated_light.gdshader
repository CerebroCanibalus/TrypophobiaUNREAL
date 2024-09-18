/*
Re-implementation by "QJPG"
A SHADER IMPLEMENTATION for "celyk" Shader -> https://godotshaders.com/shader/notes-on-the-light-function/

*/

shader_type spatial;

render_mode ambient_light_disabled, specular_toon, cull_back;

uniform sampler2D diffuse_texture: filter_nearest;
uniform vec3 albedo: source_color = vec3(1.0, 1.0, 1.0);

void fragment() {
	vec4 color = texture(diffuse_texture, UV);
	
	ALBEDO = color.rgb * albedo;
	//ALPHA = color.a;
}

void light() {
	// light we wish to accumulate
	DIFFUSE_LIGHT += ALBEDO * ATTENUATION * LIGHT_COLOR * max(dot(LIGHT, NORMAL), 0.0);

	// assign the result
	SPECULAR_LIGHT = round(DIFFUSE_LIGHT * 3.0 - 0.5) / 8.0; // posterizes the final color

	// cancel all contribution of the diffuse_light variable
	SPECULAR_LIGHT -= DIFFUSE_LIGHT;
}