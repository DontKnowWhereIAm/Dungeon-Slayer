//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_flash_amount;

void main()
{
    vec4 base_color = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
	if (base_color.a < 0.1) {
        discard;
    } else {
        vec4 flash_color = vec4(1.0, 0.0, 0.0, 1.0); // Red color
        gl_FragColor = mix(base_color, flash_color, u_flash_amount);
    }
}
