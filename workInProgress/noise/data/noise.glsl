uniform float time;

varying vec4 vertTexCoord;

float rand2(vec2 co){
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float rand( float n ){
	return fract(sin(n)*43758.5453);
}

/*
float noise (vec2 uv) {
	vec3 x = vec3(uv, 0.0);
	vec3 p = floor(x);
	vec3 f = fract(x);

	float n = p.x + p.y * 57.0 ;

	return 
		mix( 
			mix( rand(n+0.0), rand(n+1.0),f.x),
			mix( rand(n+57.0), rand(n+58.0),f.x),
		f.y);
}
*/

float noise (vec2 uv) {
  vec3 x = vec3(uv, 0.0);
  vec3 p = floor(x);
  vec3 f = fract(x);

  f = f * f * (3.0 - 2.0 * f);
  float n = p.x + p.y * 57.0 + 113.0 * p.z;

return mix(mix(mix( rand(n+0.0), rand(n+1.0),f.x),
           mix( rand(n+57.0), rand(n+58.0),f.x),f.y),
           mix(mix( rand(n+113.0), rand(n+114.0),f.x),
           mix( rand(n+170.0), rand(n+171.0),f.x),f.y),f.z);

}


float perlin( vec2 uv){
	float n = 
	  noise(uv)*64.0 
	+ noise(uv*2.0)*32.0 
	+ noise(uv*4.0)*16.0 
	+ noise(uv*8.0)*8.0 
	+ noise(uv*16.0)*4.0 
	+ noise(uv*32.0)*2.0 
	+ noise(uv*64.0);

	return n / (1.0 + 2.0 + 4.0 + 8.0 + 16.0 + 32.0 + 64.0);
}

float fbm(vec2 P, int octaves, float lacunarity, float gain){
    float sum = 0.0;
    float amp = 1.0;
    vec2 pp = P;
     
    //int i;
     
    for(int i = 0; i < octaves; i+=1)
    {
        amp *= gain; 
        sum += amp * noise(pp);
        pp *= lacunarity;
    }
    return sum;
 
}

vec3 makeColored(vec2 p, float ff){
  vec2 q = p*10.15;

  vec2 on = vec2(0.0);
  float f = ff;

  //vec4 tex = texture2D(u_image, on.xy);
  vec3 col = vec3(0.0);

  col = mix(vec3(0.05, 0.04,0.03), vec3(0.0,0.03,0.1), f);
  col = mix(col, vec3(0.05, 0.02, 0.0), dot(on.r, on.g));
  col = mix(col, vec3(0.9,0.1, 0.4), 0.5*on.r*on.g);
  col = mix(col, vec3(0.9,0.9,0.3), 0.5*smoothstep(1.0,1.4,abs(on.g)+abs(on.r)));
  col = clamp(col*f*20.0,0.0,1.0);

  
  //col = clamp(tex.rgb*f*1.5,0.0,1.0);
  return col;

}


void main(){
	
	vec2 uv = vertTexCoord.xy; //tex coords

	int oct = 4;
	float lac = 3.3;
	float gain = 0.525;


	//float col = rand2(uv*time);

	//float nze = noise(uv*time);
	//float perl = perlin(uv*time);
	float b = fbm(uv*10.0, oct, lac, gain);
	float c = fbm(vec2(b, b), oct, lac, gain)*(time);
	float d = fbm(vec2(c, c), oct, lac, gain);
	float e = fbm((0.5+uv*10.0)*vec2(d, d), oct, lac, gain);
	float f = fbm(uv*10.0+e/ time, oct, lac, gain);

	float g = (b+c+d+e+f)/5.0;
	vec3 fc = makeColored(uv, mod(g*g, 1.0));
	gl_FragColor = vec4(fc,1.0);
}