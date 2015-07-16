//uniforms are supplied by your sketch
uniform sampler2D srcTex;
uniform sampler2D disTex;

uniform float amt;

varying vec4 vertTexCoord;

void main(){

	
	vec4 distort = texture2D(disTex, vertTexCoord.st);

	//use webcam color to distort texture coordinates
	vec2 offset = vec2(distort.y - distort.x, distort.x - distort.z)*amt;
	vec2 coord = offset+vertTexCoord.st;

	vec4 tex = texture2D(srcTex, coord);
	
	gl_FragColor = tex;
}