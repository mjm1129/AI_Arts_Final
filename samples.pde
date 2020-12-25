int num_of_samples = 35;

int samplesWidth;
float samplesGap = 5;

int rows = 6;
int columns = 6;

float[] samplePhotoX1 = new float[columns];
float[] samplePhotoX2 = new float[columns];
float[] samplePhotoY1 = new float[rows];
float[] samplePhotoY2 = new float[rows];

float[] samplePhotoY1_orig = new float[rows];
float[] samplePhotoY2_orig = new float[rows];

float mouseWheelWidth = 30;
float mouseWheelHeight = 300;

float mouseWheelX;
float mouseWheelY;
float movedY = 0.0; 

float fileAbleToMove;
float wheelAbleToMove;

float bottomBar;

Boolean overWheel = false;
Boolean locked = false;

Boolean sampleSelected = false;

PImage[] sampleFile = new PImage[num_of_samples];
PImage[] sampleFace = new PImage[num_of_samples];
PImage galleryIcon;
PImage currentFace;

int sampleIndex = 0;

void fileSamples(){
  background(mint);
  noStroke();
  
  sampleIndex = 0;
  
  if (pmouseX > mouseWheelX && pmouseY > mouseWheelY && pmouseY < (mouseWheelY + mouseWheelHeight)){
    overWheel = true;
  } else {
    //fill(light_gray);
    overWheel = false;
  }

  if (overWheel || locked){
    fill(dark_mint);
    for (int i = 0; i < rows; i++){
        samplePhotoY1[i] = samplePhotoY1_orig[i] - (mouseWheelY / wheelAbleToMove * fileAbleToMove);
        samplePhotoY2[i] = samplePhotoY2_orig[i] - (mouseWheelY / wheelAbleToMove * fileAbleToMove);
      }
  } else {
    fill(light_gray);
  }
  rect(mouseWheelX, mouseWheelY, mouseWheelWidth, mouseWheelHeight, 7);
  
  fill(255);
   for(int y = 0; y < columns; y++){
    for(int x = 0; x < rows; x++){
      if (pmouseX >= samplePhotoX1[x] && pmouseX <= samplePhotoX2[x] &&
          pmouseY >= samplePhotoY1[y] && pmouseY <= samplePhotoY2[y] && pmouseY < (height - bottomBar)){
            fill(light_gray, 80);
            //println("box[" + x + "][" + y + "] hovered");
          } else {
            noFill();
            //println("outside box");
          }
      
      //println(sampleIndex, samplesWidth);
      
      if (sampleIndex != 0){
        
        image(sampleFace[sampleIndex-1], samplePhotoX1[x], samplePhotoY1[y]);
      } else {
        image(galleryIcon, samplePhotoX1[x], samplePhotoY1[y]);
      }
      
      rect(samplePhotoX1[x], samplePhotoY1[y], samplesWidth, samplesWidth);
      sampleIndex++;
    }
  }
  
  fill(mint);
  rect(0, height - bottomBar, mouseWheelX, bottomBar);
}
