uniform sampler2D srcTex;
uniform vec2 step;

varying vec4 vertTexCoord;

void main(){

	vec2 uv = vertTexCoord.xy;
	float dx = 10.0*step.x;
	float dy = 10.0*step.y;

	vec2 coord = vec2(dx*floor(uv.x/dx), dy*floor(uv.y/dy));
	vec4 tex = texture2D(srcTex, coord);

	gl_FragColor = vec4(tex.rgb, 1.0);
}