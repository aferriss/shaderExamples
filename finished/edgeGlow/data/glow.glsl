uniform sampler2D srcTex;
uniform vec2 step;
uniform float time;

varying vec4 vertTexCoord;

vec2 offset[9];

float kernel[9];
float kernel2[9];

float x = 0.0;
float y = 0.0;

vec4 color = vec4(0.0);
vec4 sumX = vec4(0.0);
vec4 sumY = vec4(0.0);

void main(){

	vec2 uv = vertTexCoord.xy;
	
	//sample grid around pixel
	offset[0] = vec2(-step.x, -step.y); // top left
	offset[1] = vec2(0.0, -step.y); // top middle
	offset[2] = vec2(step.x, -step.y); // top right
	offset[3] = vec2(-step.x, 0.0); // middle left
	offset[4] = vec2(0.0, 0.0); //middle
	offset[5] = vec2(step.x, 0.0); //middle right
	offset[6] = vec2(-step.x, step.y); //bottom left
	offset[7] = vec2(0.0, step.y); //bottom middle
	offset[8] = vec2(step.x, step.y); //bottom right

	//horizontal offset
	kernel[0] = -1.0; kernel[1] = 0.0; kernel[2] = 1.0;
	kernel[3] = -2.0; kernel[4] = 0.0; kernel[5] = 2.0;
	kernel[6] = -1.0; kernel[7] = 0.0; kernel[8] = 1.0;

	//vertical offset
	kernel2[0] = -1.0; kernel2[1] = -2.0; kernel2[2] = -1.0;
	kernel2[3] = 0.0; kernel2[4] = 0.0; kernel2[5] = 0.0;
	kernel2[6] = 1.0; kernel2[7] = 2.0; kernel2[8] = 1.0;

	//calculate sobel
	for( int i = 0; i<9; i++){
		color = texture2D(srcTex, uv+offset[i]);
		sumX += color * kernel[i];

		color = texture2D(srcTex, uv+offset[i]);
		sumY += color * kernel2[i];
	}

	// convert textures to luma
	x = 0.2126*sumX.r + 0.7152*sumX.g + 0.0722*sumX.b;
	y = 0.2126*sumY.r + 0.7152*sumY.g + 0.0722*sumY.b;

	//square luma values to denoise
	float g = x*x + y*y;

	// add sobel result to srcTex
	vec4 glowTex = texture2D(srcTex, uv);
	
	// sine wave on the blue channel
	glowTex += vec4(g, g*0.5, g*(1.0+sin(time)/2.0), 1.0);

	gl_FragColor = glowTex;
}