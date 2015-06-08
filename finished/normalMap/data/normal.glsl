//generates a normal map based on edge detection

uniform float normalAmt;
uniform vec2 res;
uniform sampler2D tex;
varying vec4 vertTexCoord;

vec2 texelWidth = 1.0/res; 

void main(){

	vec2 uv = vertTexCoord.xy; //tex coords

	float step = 1.0;
    float tl = abs(texture2D(tex, uv + texelWidth * vec2(-step, -step)).x);   // top left
    float  l = abs(texture2D(tex, uv + texelWidth * vec2(-step,  0.0)).x);   // left
    float bl = abs(texture2D(tex, uv + texelWidth * vec2(-step,  step)).x);   // bottom left
    float  t = abs(texture2D(tex, uv + texelWidth * vec2( 0.0, -step)).x);   // top
    float  b = abs(texture2D(tex, uv + texelWidth * vec2( 0.0,  step)).x);   // bottom
    float tr = abs(texture2D(tex, uv + texelWidth * vec2( step, -step)).x);   // top right
    float  r = abs(texture2D(tex, uv + texelWidth * vec2( step,  0.0)).x);   // right
    float br = abs(texture2D(tex, uv + texelWidth * vec2( step,  step)).x);   // bottom right

    //edge detect
	float mult = 0.25;
	float dX = tr*mult + 2.0*r*mult + br*mult -tl*mult - 2.0*l*mult - bl*mult;
    float dY = bl*mult + 2.0*b*mult + br*mult -tl*mult - 2.0*t*mult - tr*mult;

    //color like a normal map
    vec3 color = normalize(vec3(dX,dY,1.0/normalAmt));

    color *=0.5;
    color +=0.5;

	gl_FragColor = vec4(vec3(color),1.0);
}