PShader shader;
PImage img;

int nbrRows = 360/3;
int nbrCols = 640/3;
int gSize = 3;
int u = 0;
int v = 0;
float deltaV = 1.0 / nbrCols;
float deltaU = 1.0/ nbrRows;

void setup(){
  size(640,360, P2D);
  shader = loadShader("rgbShift.glsl");
  img = loadImage("img.jpg");
  shader.set("srcTex", img);

  noStroke();
}

void draw(){  
  shader.set("shift", map(mouseX, 0, width, -0.2,0.2));
  shader(shader);
  //rect(0,0,width, height);
  //stroke(255);
  //fill(0);
  
  for(int y = 0; y < nbrRows - 1; y++){
   beginShape(QUAD_STRIP);
   texture(img);  // we are using a texture
   u = 0;  // init horz text pos
   for(int x = 0; x < nbrCols; x ++){
      vertex(x * gSize, y * gSize, u, v);
      vertex(x * gSize, y * gSize + gSize, u, v + deltaV);
      u += deltaU;
   }
   v += deltaV;
   endShape();
}
}