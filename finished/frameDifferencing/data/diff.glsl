
uniform sampler2D srcTex;

uniform sampler2D lastFrame;
varying vec4 vertTexCoord;

void main(){
	vec4 currentFrame = texture2D(srcTex, vertTexCoord.st);
	vec4 pastFrame = texture2D(lastFrame, vertTexCoord.st);
	
	//subtract the frames from each other
	gl_FragColor = vec4(vec3(currentFrame.rgb-pastFrame.rgb ), 1.0);
}