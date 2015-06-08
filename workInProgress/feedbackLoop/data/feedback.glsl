uniform sampler2D srcTex;
uniform vec2 step;
uniform float values[9];
varying vec4 vertTexCoord;

vec2 offset[9];
vec4 sum = vec4(0.0);
float kernelWeight = 0.0;
void main(){

	vec2 uv = vertTexCoord.xy;
	
	offset[0] = vec2(-step.x, -step.y); // top left
	offset[1] = vec2(0.0, -step.y); // top middle
	offset[2] = vec2(step.x, -step.y); // top right
	offset[3] = vec2(-step.x, 0.0); // middle left
	offset[4] = vec2(0.0, 0.0); //middle
	offset[5] = vec2(step.x, 0.0); //middle right
	offset[6] = vec2(-step.x, step.y); //bottom left
	offset[7] = vec2(0.0, step.y); //bottom middle
	offset[8] = vec2(step.x, step.y); //bottom right

	for(int i = 0; i<9; i++){
		//sample a 3x3 grid around each pixel and multiply by values
		vec4 color = texture2D(srcTex, uv + offset[i]);
		sum += color * values[i];
		kernelWeight += values[i];
	}

	// if sum of the kernel values is <= 0  set it to 1
	kernelWeight = kernelWeight <= 0.0 ? 1.0 : kernelWeight;

	//sum *= 0.5;
	//sum += 0.5;
		
	gl_FragColor = vec4(sum.rgb/kernelWeight, 1.0) ;//+0.005;
}