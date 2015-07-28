//levels shader from:
// https://mouaif.wordpress.com/2009/01/28/levels-control-shader/

uniform sampler2D srcTex;
uniform vec3 levels;

varying vec4 vertTexCoord;

vec3 gammaCorrect(vec3 color, float gamma){
    return pow(color, vec3(1.0/gamma));
}

vec3 levelRange(vec3 color, float minInput, float maxInput){
    return min(max(color - vec3(minInput), vec3(0.0)) / (vec3(maxInput) - vec3(minInput)), vec3(1.0));
}

vec3 finalLevels(vec3 color, float minInput, float gamma, float maxInput){
    return gammaCorrect(levelRange(color, minInput, maxInput), gamma);
}

void main(){
	vec2 uv = vertTexCoord.xy;

	vec4 texture = texture2D(srcTex, uv) ;
	
	//need to normalize the input min and max so that they go between 0 - 1 instead of 0 - 255
    vec3 adjustedLevels = finalLevels(texture.rgb, levels.x/255.0, levels.y, levels.z/255.0);

	gl_FragColor = vec4(adjustedLevels,1.0);
}