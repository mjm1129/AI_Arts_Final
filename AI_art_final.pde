// modules
  // camera (video library)
    import processing.video.*;
    // reference to the camera
    Capture camera;
  
  // runwayml library
    import com.runwayml.*;
    // reference to runway instance
    RunwayHTTP runway;
  
  // sound
    import ddf.minim.*;
    import ddf.minim.analysis.*;
    import ddf.minim.effects.*;
    import ddf.minim.signals.*;
    import ddf.minim.spi.*;
    import ddf.minim.ugens.*;
    Minim minim;
    
  // controlP5
    import controlP5.*;
    //create controlP5 instance
    ControlP5 cp5;
    

// resources
  // fonts
    PFont cheri;
    PFont all_caps;
    
  // images
    PImage logo;
    PImage character;
    PImage cameraImage;
    PImage resultImage;
    PImage queryImage;
    
    // button
    PImage upArrow;
    PImage leftArrow;
    PImage downArrow;
    PImage rightArrow;
    PImage enterKey;
    
    PImage retakeKey;
    
    PImage redoKey;
    
    PImage checkSign;
    
  // sounds
  AudioPlayer button_effect;
  AudioPlayer camera_shutter;
  AudioPlayer keyboard_effect;
  AudioPlayer[] soundFile = new AudioPlayer[22];
  
  // runway
    // The data coming in from Runway as a JSON Object {}
    JSONObject data;
    
    // datas
    int dataSize = 0;
    int whichFace = 0;
    int[] faceXArray = new int[100]; // in case
    int[] faceYArray = new int[100]; // in case
    int[] faceWArray = new int[100]; // in case
    int[] faceHArray = new int[100]; // in case

    
// variables that makes coding a bit easier
float halfWidth;
float halfHeight;

color mint = color(119, 195, 182);
//color mint = color(137, 179, 235);
//color dark_mint = color(86, 112, 147);
color dark_mint = color(86, 141, 132);
color light_gray = color(234, 233, 238);
color darker_gray = color(153, 153, 153);
color red = color(255, 0, 0);

int optionMode = -1;

// boolean variables
  // modes
  int modeNum = 4;
  int currentMode = 0;
  
  //------------------------------------------------------------------
  //started      | explanation_done | option_selected | camera_option |
  //0            | 1                | 2               | 3             |
  //------------------------------------------------------------------
  //image_option | profile          | music           |
  //3            | 4                | 6               |
  //---------------------------------------------------
  
  // others
    Boolean button_playing = false;
    Boolean keyboard_playing = false;
    Boolean prevBtnSound = false;
    Boolean otherOptionSound = false;
    
    // profile
    Boolean profile_done = false;
    Boolean faceClicked = false;
    Boolean profileImageAdjusted = false;
    Boolean musicArrayFilled = false;
    
    // for camera + file selection
    Boolean screenBtnOn = true;
    Boolean selected = false;     
    Boolean imageInputted = false;

// buttons
  // keys
  int keys_width = 50;
  int keys_height;
  
  // options
  int options_width = 400;
  int options_height = 50;
  
  float optionText_diff = 2 * options_height/3;
  
  // previous button
  int prev_button_width = 80;
  float prev_buttonX; 
  float prev_buttonY;
  
  // reset info button
  float reset_buttonX;
  float reset_buttonY;
  
  // rewind music button
  float rewind_buttonX;
  float rewind_buttonY;
  
  // next button
  int next_button_width = 150;
  float next_buttonX; 
  float next_buttonY;
  
  // option 1: camera
  float option1_X;
  float option1_Y;
  
  // option 2: select file
  float option2_X;
  float option2_Y;
  
  // play button
  int play_button_width = 200;
  float play_buttonX; 
  float play_buttonY;

void setup(){
  size(640, 480);
  halfWidth = width/2;
  halfHeight = height/2;
  
  frameRate(100);
  fill(255);
  
  // setup Runway
  runway = new RunwayHTTP(this);
  // disable automatic polling: request data manually when a new frame is ready
  runway.setAutoUpdate(false);
  
  // setup camera
  camera = new Capture(this,640,480);
  camera.start();
  
  // load images
  initializeKeys();
  
  character = loadImage("image/character.png");
  cameraImage = loadImage("image/camera.png");
  cameraImage.resize(cameraWidth, 0);
  
  logo = loadImage("image/logo.png");
  logo.resize(cameraWidth, 0);
  
  retakeKey = loadImage("image/retake.png");
  retakeKey.resize(cameraWidth, 0);
  
  redoKey = loadImage("image/key/redoKey.png");
  redoKey.resize(cameraWidth, 0);
  
  checkSign = loadImage("image/checkSign.png");
  checkSign.resize(checkBoxWidth, 0);
  
  // load fonts
  cheri = createFont("font/cheri.ttf", 32);
  all_caps = createFont("font/all_caps.ttf", 20);
  
  // load sounds
    minim = new Minim(this);
    
    button_effect = minim.loadFile("sound/button_sound.mp3");
    camera_shutter = minim.loadFile("sound/camera_shutter.mp3");
    keyboard_effect = minim.loadFile("sound/keyboard.mp3");
    for (int i = 1; i <= soundFile.length; i++){
      soundFile[i-1] = minim.loadFile("sound/sound" + i + ".mp3");
    }
    
  // load cp5
     //create a font
    
    cp5 = new ControlP5(this);
    //definetextField
    cp5.addTextfield("textValue")
       .setPosition(20,40)
       .setSize(200,40)
       .setFont(all_caps)
       .setFocus(true)
       .setColor(0)
       .setColorForeground(mint)
       .setColorActive(dark_mint)
       .setColorBackground(mint)
       ;
       
  samplesWidth = round((width - mouseWheelWidth - (samplesGap * (columns + 1))) / columns);
  
  samplePhotoX1[0] = samplesGap;
  samplePhotoX2[0] = samplePhotoX1[0] + samplesWidth;
  
  samplePhotoY1[0] = samplesGap;
  samplePhotoY1_orig[0] = samplesGap;
  samplePhotoY2[0] = samplePhotoY1[0] + samplesWidth;
  samplePhotoY2_orig[0] = samplePhotoY1_orig[0] + samplesWidth;
  
  // auto-set sample X1 & X2 pos
  for(int i = 1; i < columns; i++){
    samplePhotoX1[i] = samplePhotoX1[i-1] + samplesWidth + samplesGap;
    samplePhotoX2[i] = samplePhotoX1[i] + samplesWidth;
  }
  
  // auto-set sample Y1 & Y2 pos
  for(int i = 1; i < rows; i++){
    samplePhotoY1[i] = samplePhotoY1[i-1] + samplesWidth + samplesGap;
    samplePhotoY2[i] = samplePhotoY1[i] + samplesWidth;
    samplePhotoY1_orig[i] = samplePhotoY1[i];
    samplePhotoY2_orig[i] = samplePhotoY2[i];
    
  }
  
  bottomBar = 16 + options_height;
  
  fileAbleToMove = samplePhotoY2[rows - 1 ] - (height - samplesGap) + bottomBar;
  wheelAbleToMove = height - mouseWheelHeight;
  
  mouseWheelX = width - mouseWheelWidth;
  
  galleryIcon = loadImage("image/galleryIcon.png");
  galleryIcon.resize(samplesWidth, 0);
  
  for(int i = 0; i < num_of_samples; i++){
    println("sampleFile[" + i + "] = " + (i+1) + ".jpg");
    sampleFile[i] = loadImage("image/samples/" + (i+1) + ".jpg");
    sampleFace[i] = loadImage("image/sampleFace/" + (i+1) + ".png");
    
    sampleFace[i].resize(samplesWidth, 0);
  }
}

void draw(){  
  if (currentMode < 5){
    cp5.hide();
  }
  
  if (currentMode == 0){
    startup();
  } else if (currentMode == 1){
    projectExplanation();
  } else if (currentMode == 2){
    selection();
  } else if (currentMode == 3){
    useWebcam();
  } else if (currentMode == 4){
    if (!sampleSelected){
      fileSamples();
    } else {
      selectedQuery();
    }
  } else if (currentMode == 5 || currentMode == 6){
    makeProfile();
  }
  
  if (currentMode > 1){
    noStroke();
    
    if (screenBtnOn){
      drawPrevBtn();
    }
  }
}

void buttonEffect(Boolean on){
  if (on){
    if (!button_playing){
      button_playing = true;
      button_effect.play();
    }
  } else {
    button_effect.pause();
    button_effect.rewind();
    button_playing = false;
  }
}

void keyboardEffect(Boolean on){
  if (on){
    keyboard_effect.pause();
      keyboard_effect.rewind();
      keyboard_effect.play();
    //if (!keyboard_effect.isPlaying()){
    //  //keyboard_playing = true;
    //  keyboard_effect.play();
    //} else {
    //  keyboard_effect.pause();
    //  keyboard_effect.rewind();
    //  keyboard_effect.play(); 
    //}
  } 
  //else {
  //  keyboard_effect.pause();
  //  keyboard_effect.rewind();
  //  keyboard_playing = false;
  //}
}

// for debugging process
void mousePressed(){
  println();
  
  if (prevBtnHover()){
      previousBtn();
  } 
    
  // startup
  if (currentMode == 0){
    //modes[0] = true;
    buttonEffect(false);
    currentMode = 1;
  } 
  
  // explanation
  else if (currentMode == 1){
    if (pmouseX > next_buttonX && pmouseX < (next_buttonX + next_button_width) &&
    pmouseY > next_buttonY && pmouseY < (next_buttonY + options_height)){
      //modes[1] = true;
      buttonEffect(false);
      currentMode = 2;
    } 
  } 
  
  // selection
  else if (currentMode == 2){
      // camera
      if (pmouseX > option1_X && pmouseX < (option1_X + options_width) && 
          pmouseY > option1_Y && pmouseY < (option1_Y + options_height)){
            currentMode = 3;
            optionMode = 1;
            screenBtnOn = true;
      } 
      
      // selections
      else if (pmouseX > option2_X && pmouseX < (option2_X + options_width) && 
                pmouseY > option2_Y && pmouseY < (option2_Y + options_height)){
        currentMode = 4;
        optionMode = 2;
        screenBtnOn = true;
        
        
        //selectInput("Select an input image to process:", "inputImageSelected");
      }
      
    } 
    
    // camera
    else if (currentMode == 3){
      // camera icon
        if (!selected){
          if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
          pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
            camera_shutter.play();
            screenBtnOn = false;
            
          } else {
            camera_shutter.pause();
            camera_shutter.rewind();
          }
        } else {
          if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
          pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
            screenBtnOn = true;
            selected = false;
          } else {
            if (checkFace()){
              currentMode = 5;
            }
            
          }
        }

    }
    
    // select file
    else if (currentMode == 4){
      if (!sampleSelected){
        if(overWheel) { 
          locked = true; 
        } else {
          locked = false;
        }
        
        movedY = mouseY - mouseWheelY;
        //
        for(int y = 0; y < columns; y++){
    for(int x = 0; x < rows; x++){
      if (pmouseX >= samplePhotoX1[x] && pmouseX <= samplePhotoX2[x] &&
          pmouseY >= samplePhotoY1[y] && pmouseY <= samplePhotoY2[y]  && pmouseY < (height - bottomBar)){
            //fill(dark_mint);
            println("box[" + x + "][" + y + "] hovered");
            if ( x == 0 && y == 0){
              sampleSelected = true;
              // gallery
              selectInput("Select an input image to process:", "inputImageSelected");
            } 
            else {
              sampleSelected = true;
              queryImage = sampleFile[6*y + x - 1];
              
              screenBtnOn = true;
              selected = false;
              imageInputted = true;
              fileX = 0;
              fileY = 0;
              
              autoAdjustImage();
            }
          } 
      rect(samplePhotoX1[x], samplePhotoY1[y], samplesWidth, samplesWidth);
    }
  }
        //
      } else {
        //println(hoverMode);
        
        if (hoverMode == "up"){
          fileY -= 10;
          //movedY -= 10;
          
          keyboardEffect(true);
        } else if (hoverMode == "down"){
          fileY += 10;
          //movedY += 10;
          
          keyboardEffect(true);
        } else if (hoverMode == "left"){
          fileX -= 10;
          //movedX -= 10;
          
          keyboardEffect(true);
        } else if (hoverMode == "right"){
          fileX += 10;
          //movedX += 10;
          
          keyboardEffect(true);
        } else if (hoverMode == "enter"){
          hoverMode = "none";
          screenBtnOn = false;
          
          keyboardEffect(true);
        }
        
        if (imageInputted && !screenBtnOn && selected){
          if (pmouseX > cameraX && pmouseX < (cameraX + cameraWidth) &&
            pmouseY > cameraY && pmouseY < (cameraY + camera.height)){
              screenBtnOn = true;
              selected = false;
              imageInputted = false;
              fileX = 0;
              fileY = 0;
              
              sampleSelected = false;
            } else {
              if (checkFace()){
                currentMode = 5;
              }
              
            }
        }
      }
    }
    
    // profile
    else if (currentMode == 5){
      // if play button hovered
      if (playBtnHover()){
        if (playBtnMode == 1) {
          //println("mode 1 -> 2");
          playBtnMode = 2;
        } else {
          //println("mode 2 -> 1");
          playBtnMode = 1;
        }
      } 
      
      if (checkBoxHover() == 1){
        genderMode = 1;
        profile_done = true;
      } else if (checkBoxHover() == 2){
        genderMode = 2;
        profile_done = true;
      }
      
      if (resetBtnHover() && (cp5Pointer > 0 || cp5.get(Textfield.class,"textValue").getText() != "")){
        cp5Pointer = 0;
        for(int i = 0; i < userInfo.length; i++){
          userInfo[i] = "";
        }
        genderMode = -1;
        cp5.get(Textfield.class, "textValue").clear();
        println("reset info");
      }
      if (notePointer > 0 && playBtnMode == 1 && rewindBtnHover()){
        musicRewind();
        println("music rewind");
      }
    }
  
  // for debugging
    println(pmouseX, pmouseY);

}

void mouseDragged() {
  if (locked) {
    mouseWheelY = mouseY-movedY; 
  } 
  
  if (mouseWheelY <= 0){
    mouseWheelY = 0;
  } 
  
  else if ((mouseWheelY + mouseWheelHeight) >= height){
    mouseWheelY = height - mouseWheelHeight;
  }
    
}

void mouseReleased() {
  locked = false;
}

void keyPressed() {
  // file selection page
  if (currentMode == 4){
    if (keyCode == UP){
        fileY -= 10;
        //movedY -= 10;
        
        keyboardEffect(true);
      } else if (keyCode == DOWN){
        fileY += 10;
        //movedY += 10;
        
        keyboardEffect(true);
      } else if (keyCode == LEFT){
        fileX -= 10;
        //movedX -= 10;
        
        keyboardEffect(true);
      } else if (keyCode == RIGHT){
        fileX += 10;
        //movedX += 10;
        
        keyboardEffect(true);
      } else if (keyCode == ENTER){
        hoverMode = "none";
        screenBtnOn = false;
        
        keyboardEffect(true);
      }
  }
  
  // profile page
  else if (currentMode == 5 && keyCode == ENTER){
    if (cp5Pointer <= num_of_infos - 2){
      cp5Pointer++;
    } 
    
     if (cp5Pointer == num_of_infos - 1){
      cp5.hide();
    }
  }
  
  if (currentMode == 5 && profile_done && key == ' '){
    if (playBtnMode == 1) {
      //println("mode 1 -> 2");
      playBtnMode = 2;
    } else {
      //println("mode 2 -> 1");
      playBtnMode = 1;
    }
  }
    //println("pointer:", pointer);
  //println();
  //println(currentMode);
  //switchToMode();
}

void mouseMoved() {
  if (currentMode == 0        ){
    textSize(15);
    text("Click!", 248, 222);
    text("Click!", 379, 130);
    text("Click!", 414, 256);
  }
}
