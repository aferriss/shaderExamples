uniform vec2 resolution;
uniform float tileAmt;

varying vec4 vertTexCoord;

void main(){
	
	vec2 uv = vertTexCoord.xy; //tex coords

	uv.x *= resolution.x / resolution.y;//fix scale for square tiles

	float col = mod(floor(uv.x * tileAmt) + floor(uv.y * tileAmt), 2.0); //0 or 1
	
	gl_FragColor = vec4(vec3(col),1.0);
}