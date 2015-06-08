uniform sampler2D srcTex;
uniform float shift;
varying vec4 vertTexCoord;


void main(){
	vec2 uv = vertTexCoord.xy;
	vec4 rTex = texture2D(srcTex, vec2(uv.x-shift, uv.y));
	vec4 gTex = texture2D(srcTex, vec2(uv.x, uv.y));
	vec4 bTex = texture2D(srcTex, vec2(uv.x+shift, uv.y));

	vec4 color = vec4(rTex.r, gTex.g, bTex.b, 1.0);
		
	gl_FragColor = color;
}