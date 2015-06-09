uniform sampler2D srcTex;
uniform sampler2D blurTex;

varying vec4 vertTexCoord;


void main(){

	vec2 uv = vertTexCoord.xy;

	vec3 camColor = texture2D(srcTex, uv).rgb;
	vec3 blurColor = texture2D(blurTex, vec2(1.0)-uv).rgb;

	float avg = dot(blurColor, vec3(1.0))/3.0;

	//mix the cam and the blur according to the blur's avg brightness
	//not sure if this is the right way to do this
	vec3 bloom = mix(camColor, blurColor, clamp(avg*1.25, 0.0, 1.0));

	gl_FragColor = vec4(bloom, 1.0);
}