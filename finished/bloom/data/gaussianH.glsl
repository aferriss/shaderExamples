uniform sampler2D srcTex;
uniform vec2 step;

varying vec4 vertTexCoord;

// gaussian blur filter modified from Filip S. at intel 
// https://software.intel.com/en-us/blogs/2014/07/15/an-investigation-of-fast-real-time-gpu-based-image-blur-algorithms
vec3 GaussianBlur( sampler2D tex0, vec2 centreUV, vec2 pixelOffset ){                                                                                                                                                                    
	vec3 colOut = vec3( 0.0, 0.0, 0.0 );                                                                                                                                   
	                                                                                                                                                                  
	const int stepCount = 9;
	float gWeights[stepCount];
	    gWeights[0] = 0.10855;
	    gWeights[1] = 0.13135;
	    gWeights[2] = 0.10406;
	    gWeights[3] = 0.07216;
	    gWeights[4] = 0.04380;
	    gWeights[5] = 0.02328;
	    gWeights[6] = 0.01083;
	    gWeights[7] = 0.00441;
	    gWeights[8] = 0.00157;

	float gOffsets[stepCount];
	    gOffsets[0] = 0.66293;
	    gOffsets[1] = 2.47904;
	    gOffsets[2] = 4.46232;
	    gOffsets[3] = 6.44568;
	    gOffsets[4] = 8.42917;
	    gOffsets[5] = 10.41281;
	    gOffsets[6] = 12.39664;
	    gOffsets[7] = 14.38070;
	    gOffsets[8] = 16.36501;
	

	for( int i = 0; i < stepCount; i++ ){                                                                                                                                                                
	    vec2 texCoordOffset = gOffsets[i] * pixelOffset;                                                                                                           
	    vec3 col = texture2D( tex0, centreUV + texCoordOffset ).xyz + texture2D( tex0, centreUV - texCoordOffset ).xyz;                                                
	    colOut += gWeights[i] * col;                                                                                                                               
	}

	return colOut;                                                                                                                                                   
} 


void main(){

	vec2 uv = vertTexCoord.xy;
	vec3 blurredTex = GaussianBlur(srcTex, vec2(1.0-uv.x, uv.y), vec2(step.x*1.5, 0.0 ) );

	gl_FragColor = vec4(blurredTex, 1.0);
}