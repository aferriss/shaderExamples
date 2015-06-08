uniform sampler2D srcTex;
varying vec4 vertTexCoord;

void main(){

	vec4 tex = texture2D(srcTex, vertTexCoord.st);
	
	gl_FragColor = vec4(vec3(1.0)-tex.rgb, 1.0);
}