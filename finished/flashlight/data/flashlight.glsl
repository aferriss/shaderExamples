uniform vec2 mouse;
uniform vec2 res;
uniform sampler2D tex;
varying vec4 vertTexCoord;


void main(){
	
	vec2 uv = vertTexCoord.xy; //tex coords
	vec4 texture = texture2D(tex, uv);

	vec2 sphere =  vec2(mouse.x,1.0-mouse.y) - (gl_FragCoord.xy / res);
	sphere.x *= res.x/res.y; // fix sphere size

	float d = length(sphere*2.0); 

	gl_FragColor = texture * vec4(vec3(1.5-d),1.0);
}