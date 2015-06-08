//vertTexCoord is set up by Processing
varying vec4 vertTexCoord;

void main(){
	
	//vertTexCoord.x goes between 0.0 - 1.0 on the x axis
	//vertTexCoord.y goes between 0.0 - 1.0 on the y axis
	
	gl_FragColor = vec4(vertTexCoord.x,vertTexCoord.y,1.0,1.0);
}