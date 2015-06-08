//uniforms are supplied by your sketch
uniform float time;

void main(){
	// a number oscillating between 0 to 1
	float pulse = (sin(time)+1.0)/2.0;
	
	gl_FragColor = vec4(0.0,0.0,pulse,1.0);
}