//generates a normal map based on edge detection
uniform vec2 mouse;
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
	float mult = 0.01;
	float dX = tr*mult + 2.0*r*mult + br*mult -tl*mult - 2.0*l*mult - bl*mult;
    float dY = bl*mult + 2.0*b*mult + br*mult -tl*mult - 2.0*t*mult - tr*mult;

    //color like a normal map
    vec3 color = normalize(vec3(dX,dY,1.0/300.0));

    color *=0.5;
    color +=0.5;

    //color /= 2.0;
    //color += 1.0;

    vec3 lightDir = vec3( vec2( mouse.x / res.x, 1.0-mouse.y / res.y) - (uv.xy / res ), 0.1 );
    //lightDir.x *= res.x/res.y;

    float D = length(lightDir.xyz);
    float DD = 1.0-length(lightDir.xy);

    vec3 N =  normalize(color)  ;
    vec3 L = normalize(lightDir); //light direction
    vec3 H = normalize(lightDir); //half normal

    vec4 lightColor = texture2D(tex, uv);

    vec3 falloff = vec3(0.02,0.5,1.5);

    //phong lighting equation
    vec3 diffuse = (lightColor.rgb * lightColor.a) * max(dot(N, L), 0.0) ;

    float shin = 300.0;
    float sf = max(0.0,dot(N,H));
    sf = pow(sf, shin);


	gl_FragColor = vec4(vec3(diffuse+sf),1.0);
}