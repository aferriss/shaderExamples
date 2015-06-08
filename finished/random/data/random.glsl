uniform float time;

varying vec4 vertTexCoord;

//common glsl rand function of unknown origin
float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(){
	
	vec2 uv = vertTexCoord.xy; //tex coords

	float col = rand(uv*time);
	
	gl_FragColor = vec4(vec3(col),1.0);
}