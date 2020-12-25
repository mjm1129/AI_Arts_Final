void selection(){
  background(mint);
  
  float overallHeight = 32 + 30 + options_height + 30 + options_height;
  String msg = "Select options";
  textFont(cheri);
  textSize(32);
  noStroke();
  text(msg, halfWidth, halfHeight - overallHeight/2);
  
  textSize(25);
  
  // option 1
  option1_X = halfWidth - options_width/2;
  option1_Y = halfHeight - overallHeight/2 + 30;
  
  // option 2
  option2_X = halfWidth - options_width/2;
  option2_Y = halfHeight - overallHeight/2 + options_height + 60;
  
  
  
  if (pmouseX > option1_X && pmouseX < (option1_X + options_width) && 
  pmouseY > option1_Y && pmouseY < (option1_Y + options_height)){
    fill(dark_mint);
    rect(option1_X, option1_Y, options_width, options_height, 7);
    
    fill(255);
    rect(option2_X, option2_Y, options_width, options_height, 7);
    text("Take new photo using camera", halfWidth, option1_Y + optionText_diff);
    
    fill(mint);
    text("Select from file", halfWidth, option2_Y + optionText_diff);
    fill(255);
    
    if (!prevBtnSound){
      buttonEffect(true);
      otherOptionSound = true;
    }
    
  } else if (pmouseX > option2_X && pmouseX < (option2_X + options_width) && 
  pmouseY > option2_Y && pmouseY < (option2_Y + options_height)){
    fill(dark_mint);
    rect(option2_X, option2_Y, options_width, options_height, 7);
    
    fill(255);
    rect(option1_X, option1_Y, options_width, options_height, 7);
    text("Select from file", halfWidth, option2_Y + optionText_diff);
    
    fill(mint);
    text("Take new photo using camera", halfWidth, option1_Y + optionText_diff);
    fill(255);
    
    if (!prevBtnSound){
      buttonEffect(true);
      otherOptionSound = true;
    }
    
  } else {
    fill(255);
    rect(option1_X, option1_Y, options_width, options_height, 7);
    rect(option2_X, option2_Y, options_width, options_height, 7);
    
    fill(mint);
    text("Take new photo using camera", halfWidth, option1_Y + optionText_diff);
    text("Select from file", halfWidth, option2_Y + optionText_diff);
    fill(255);
    
    if (!prevBtnSound){
      buttonEffect(false);
      otherOptionSound = false;
    }
  }
}
