
uniform sampler2D srcTex;

uniform sampler2D lastFrame;
varying vec4 vertTexCoord;

void main(){
	vec4 currentFrame = texture2D(srcTex, vertTexCoord.st);

	// make sure to flip the previous frame
	vec4 pastFrame = texture2D(lastFrame, vec2(vertTexCoord.s, 1.0 - vertTexCoord.t));
	
	//subtract the frames from each other
	gl_FragColor = vec4(abs(vec3(currentFrame.rgb-pastFrame.rgb )), 1.0);
}