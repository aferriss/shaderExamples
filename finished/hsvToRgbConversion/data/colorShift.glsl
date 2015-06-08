uniform sampler2D srcTex;
uniform float time;

varying vec4 vertTexCoord;


//color conversion functions from Sam Hocevar
//http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl

vec3 rgb2hsv(vec3 c){
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = c.g < c.b ? vec4(c.bg, K.wz) : vec4(c.gb, K.xy);
    vec4 q = c.r < p.x ? vec4(p.xyw, c.r) : vec4(c.r, p.yzx);

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c){
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


void main(){
	vec2 uv = vertTexCoord.xy;
	vec4 tex = texture2D(srcTex, uv);

	//convert to hsv color space
	vec3 hsv = rgb2hsv(tex.rgb);

	//manipulate hue
	hsv.r += time;
	hsv.r = mod(hsv.r, 1.0);

	//convert back to rgb space
	vec3 rgb = hsv2rgb(hsv);
		
	gl_FragColor = vec4(rgb, 1.0);
}