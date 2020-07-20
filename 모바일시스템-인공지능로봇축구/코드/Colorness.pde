float Colorness1(color c){

    float standard_r1 = red(0);
    float standard_g1 = green(0);
    float standard_b1 = blue(0);
  
    standard_r1 = red(trackColor[0]);
    standard_g1 = green(trackColor[0]);
    standard_b1 = blue(trackColor[0]);  
 
   float redValue = red(c);
   float greenValue = green(c);
   float blueValue = blue(c); 
   float ColorQuality = 0.0f;
 
   if(abs(standard_r1-redValue)<30&&abs(standard_g1-greenValue)<30&&abs(standard_b1-blueValue)<30){
       ColorQuality = 0.5f;
   } 
   return ColorQuality;
}


float Colorness2(color c){

    float standard_r2 = red(0);
    float standard_g2 = green(0);
    float standard_b2 = blue(0);
  
    standard_r2 = red(trackColor[1]);
    standard_g2 = green(trackColor[1]);
    standard_b2 = blue(trackColor[1]);  
 
    float redValue = red(c);
    float greenValue = green(c);
    float blueValue = blue(c);
    float ColorQuality = 0.0f;
    
    if(abs(standard_r2-redValue)<30&&abs(standard_g2-greenValue)<30&&abs(standard_b2-blueValue)<30){
      ColorQuality = 0.5f;
    }

    return ColorQuality;
}


float Colorness3(color c){

    float standard_r1 = red(0);
    float standard_g1 = green(0);
    float standard_b1 = blue(0);
    
    float standard_r2 = red(0);
    float standard_g2 = green(0);
    float standard_b2 = blue(0);
 
    standard_r1 = red(trackColor[0]);
    standard_g1 = green(trackColor[0]);
    standard_b1 = blue(trackColor[0]); 
    
    standard_r2 = red(trackColor[1]);
    standard_g2 = green(trackColor[1]);
    standard_b2 = blue(trackColor[1]); 

    float redValue = red(c);
    float greenValue = green(c);
    float blueValue = blue(c);
    float ColorQuality = 0.0f;
  
    if((abs(standard_r1-redValue)<30&&abs(standard_g1-greenValue)<30&&abs(standard_b1-blueValue)<30)||(abs(standard_r2-redValue)<30&&abs(standard_g2-greenValue)<30&&abs(standard_b2-blueValue)<30)){
        ColorQuality = 0.5f;
    }
    
    return ColorQuality;
}