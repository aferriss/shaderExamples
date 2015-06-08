PShader shader;
float inc = 0;

void setup(){
 size(640,360, P2D);
 shader = loadShader("uniformsExample.glsl"); 
 noStroke();
}

void draw(){
  //set the value of the uniform variable time equal to inc
  shader.set("time", inc);
  inc+= 0.025;
  
  shader(shader);
  rect(0,0,width, height);
}
