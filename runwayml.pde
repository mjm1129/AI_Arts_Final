int hoveredImage = 0;

float[] dataAnalysis(int index){
  float[] temporaryArray = new float[4];
  
  // access boxes and labels JSON arrays within the result
  JSONArray results = data.getJSONArray("results");
  
  // save resultsize
  dataSize = results.size();
  
  JSONArray result = results.getJSONArray(index);
  
  float x = result.getFloat(0)*width;
  float y = result.getFloat(1)*height;
  float x2 = result.getFloat(2)*width;
  float y2 = result.getFloat(3)*height;
  float w = x2 - x;
  float h = (y2 - y);
  
  temporaryArray[0] = x;
  temporaryArray[1] = y;
  temporaryArray[2] = w;
  temporaryArray[3] = h;
  
  //println(x, y, w, h);
  
  return temporaryArray;
}

// A function to display the captions
void drawCaptions() {
  // if no data is loaded yet, exit
  if(data == null){
    return;
  }
  //println(data);
  // access boxes and labels JSON arrays within the result
  JSONArray results = data.getJSONArray("results");
  
  // save resultsize
  dataSize = results.size();
  
  // for each array element
  //println(results.size());

  for(int i = 0 ; i < results.size(); i++){
    float x = dataAnalysis(i)[0];
    float y = dataAnalysis(i)[1];
    float w = dataAnalysis(i)[2];
    float h = dataAnalysis(i)[3];
    
    // JSONObject result = results.getJSONObject(i);
    //JSONArray result = results.getJSONArray(i);
    
    //String className = result.getString("class");
    //JSONArray box = result.getJSONArray("bbox");
    // extract values from the float array
    //int x = box.getInt(0);
    //int y = box.getInt(1);
    //int w = box.getInt(2);
    
    //int h = box.getInt(3);
    //float x = result.getFloat(0)*width;
    //float y = result.getFloat(1)*height;
    //float x2 = result.getFloat(2)*width;
    //float y2 = result.getFloat(3)*height;
    //float w = x2 - x;
    //float h;
    //if (currentMode == 4){
    //  h = (y2 - y) * 2;
    //} else {
      //h = (y2 - y);
    //}
    // display bounding boxes
    stroke(mint);
    strokeWeight(3);
    
    if (whichFace == i && checkFace()){
      fill(dark_mint, 125);
    } else {
      noFill();
    }
    //fill(0, 255, 0);
    rect(x, y, w, h);
    fill(255, 0, 0);
    //text(className,x,y);
    
    //println(x, y, w, h);
    
    faceXArray[i] = round(x);
    faceYArray[i] = round(y);
    faceWArray[i] = round(w);
    faceHArray[i] = round(h);
  }
}

// A function to detect whether the face is clicked
boolean checkFace(){
  faceClicked = false;
  for(int i = 0; i < dataSize; i++){
    if (pmouseX > (faceXArray[i]) && pmouseX < (faceXArray[i]+faceWArray[i]) &&
    pmouseY > (faceYArray[i]) && pmouseY < (faceYArray[i]+faceHArray[i])){
      faceClicked = true;
      whichFace = i;
      break;
    }
  }
  
  return faceClicked;
}

void sendFrameToRunway(){
  PImage result_image = loadImage("image/result.png").get(0,0,600,400);
  // query Runway with webcam image 
  
  runway.query(result_image);
}

// this is called when new Runway data is available
void runwayDataEvent(JSONObject runwayData){
  // point the sketch data to the Runway incoming data 
  data = runwayData;
}
