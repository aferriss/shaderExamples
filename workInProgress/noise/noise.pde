PShader shader;
float inc = 0;

void setup(){
  size(1280,640, P2D);
  shader = loadShader("noise.glsl");
  
  noStroke();
}

void draw(){
  shader.set("time", inc);
  shader(shader);
  
  rect(0,0,width, height);
  
  inc+= 0.005;
}