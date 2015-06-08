//generates a normal map based on edge detection
uniform vec2 mouse;
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

    vec3 lightDir = vec3( vec2( mouse.x/res.x, 1.0-mouse.y/res.y)-(gl_FragCoord.xy / vec2(res.x,res.y)), 3.75 );
    lightDir.x *= res.x/res.y;

    float D = length(lightDir);

    vec3 N = normalize(color); //normal
    vec3 L = normalize(lightDir); //light direction
    vec3 H = normalize(L); //half normal

    vec4 lightColor = texture2D(tex, uv);
    vec3 falloff = vec3(1.0,3.0,20.5);

    //phong lighting equation
    vec3 diffuse = (lightColor.rgb * lightColor.a) * max(dot(N, L), 0.0);

    float shin = 300.0;
    float sf = max(0.0,dot(N,H));
    sf = pow(sf, shin);

    float attenuation = 1.0 / (falloff.x + (falloff.y*D) + (falloff.z * D * D) );

    //vec3 intensity =  (diffuse+sf ) * attenuation;
    //vec3 finalColor = (lightColor.rgb * intensity);


	gl_FragColor = vec4(vec3(attenuation),1.0);
}