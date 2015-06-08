uniform sampler2D srcTex;
uniform float time;
uniform float amplitude;
uniform float frequency;

varying vec4 vertTexCoord;

void main(){
vec2 uv = vertTexCoord.xy;
vec4 tex = texture2D(srcTex, uv + vec2(sin(time+uv.y*frequency)*amplitude, 0.0));
	
gl_FragColor = vec4(tex);
}