PShader shader;
float inc = 0;

void setup(){
  size(640,360, P2D);
  shader = loadShader("random.glsl");
  
  noStroke();
}

void draw(){
  shader.set("time", inc);
  shader(shader);
  
  rect(0,0,width, height);
  
  inc+= 0.5;
}