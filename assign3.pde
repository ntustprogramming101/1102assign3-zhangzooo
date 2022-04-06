final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int STAY = 0;
final int GO_RIGHT = 1;
final int GO_LEFT = 2;
final int GO_DOWN = 3;
int hogState = STAY;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg,groundhogIdle, lifeImg, stone1, stone2;
PImage groundhogDown, groundhogLeft, groundhogRight;
PImage []imgSoil;

float hogX;
float hogY;
float hogSpeed;
int lifeX=10;
int lifeY=10;
int lifeSpace=20;
int lifeWidth=50;
int frame=15;
int nbrSoil = 6;
boolean right= false;
boolean down= false;
boolean left= false;
int sceneY = 0;

// For debug function; DO NOT edit or remove this!
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  lifeImg=loadImage("img/life.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
  stone1=loadImage("img/stone1.png");
  stone2=loadImage("img/stone2.png");
  
  //hog
  hogX=320;
  hogY=80;
  hogSpeed=80.0;  
    
  //soil
  imgSoil=new PImage[nbrSoil];
    for (int i=0; i<nbrSoil; i++){
    imgSoil[i] = loadImage("img/soil"+i+".png");}
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

   
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{
    image(startNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;

		case GAME_RUN: // In-Game


//scenemove
  if (down) {
      pushMatrix();
      translate(0, sceneY);}

		// Background
		image(bg, 0, 0);

		// Sun
	  stroke(255,255,0);
	  strokeWeight(5);
	  fill(253,184,19);
	  ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil 
    for (int i=0; i<nbrSoil; i++){
      for(int m=0; m<8; m++){
        for(int n=0; n<24; n++){
    image(imgSoil[i],m*80,160+80*n+320*i);
  }}}
  
    //stone1-8
    for(int i=0; i<8; i++){
    image(stone1,80*i,160+80*i);
    }
    
    //stone9-16
    pushMatrix();
    translate(0,800);   
    
    for(int i=0; i<8; i++){
    int j=-i;
    image(stone1,80*6+80*i,80*i);   
    image(stone1,400+80*j,80*i);
    image(stone1,80+80*j,80*i);  }
    
    for(int i=0; i<6; i++){
    image(stone1,80*2+80*i,80*i);
    image(stone1,80*i,80*2+80*i);}
    
    for(int i=0; i<7; i++){
    int j=-i;
    image(stone1,640+80*j,80+80*i);}
    
    for(int i=0; i<3; i++){
    int j=-i;
    image(stone1,640+80*j,400+80*i);}
    
    for(int i=0; i<2; i++){
    image(stone1,80*i,80*6+80*i); }
    popMatrix();
    
    //stone17-24
    pushMatrix();
    translate(0,80*18);
    for(int i=0; i<8; i++){
      int j=-i;
      int a =80*7;
      image(stone1,a+80*j,80*i);   
      image(stone1,80*5+80*j,80*i);
      image(stone2,80*5+80*j,80*i);
      image(stone1,80*4+80*j,80*i);
      image(stone1,80*2+80*j,80*i);
      image(stone2,80*2+80*j,80*i);
      image(stone1,80+80*j,80*i);
      image(stone1,a+80*j,80+80*i);
      image(stone2,a+80*j,80+80*i);
      image(stone1,a+80*j,80*3+80*i);
      image(stone1,a+80*j,80*4+80*i);
      image(stone2,a+80*j,80*4+80*i);
      image(stone1,a+80*j,80*6+80*i);
      image(stone1,a+80*j,a+80*i);
      image(stone2,a+80*j,a+80*i);}  
    popMatrix();
    
   // Health UI   

    for(int i =0; i<playerHealth; i++){   
       image(lifeImg,lifeX+(lifeWidth+lifeSpace)*i,lifeY);} 
       
    //groundhog move    
switch(hogState){
  case GO_RIGHT:
  if(frame<15){
    image(groundhogRight,hogX,hogY);
    hogX+=hogSpeed/15.0;
    frame++;
    if(hogX>560){hogX=560;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break; 
  
  case GO_LEFT:
  if(frame<15){
    image(groundhogLeft,hogX,hogY); 
    hogX-=hogSpeed/15.0;
    frame++;
    if(hogX<=0){hogX=0;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break;
      
  case GO_DOWN:    
  if(frame<15){
    image(groundhogDown,hogX,hogY);
    hogY+=hogSpeed/15.0;
    frame++;
    if(hogY>=80*26){hogY=80*26;}}
  if(frame==15){image(groundhogIdle,round(hogX),round(hogY));}
  break;
  
  case STAY:
  frame=15;
  image(groundhogIdle,round(hogX),round(hogY));
  break;
}
    if (down) {popMatrix();}
	

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
	}



    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }

switch(keyCode){
    //down
    case DOWN:
    if(frame==15){
      down=true; 
      frame=0;
     
      sceneY-=80;
      hogState=GO_DOWN;}
      if(hogY>=80*26){hogState=STAY;}
    break;
    
    //right
    case RIGHT:
    if(frame==15){
      right=true;
      frame=0; 
      hogState=GO_RIGHT;}
      if(hogX>=560){hogState=STAY;}
    break;
    
    //left
      case LEFT:
      if(frame==15){
      left=true;
      frame=0;
      hogState=GO_LEFT;}
      if(hogX<=0){hogState=STAY;}
    break;
}
}

void keyReleased(){
}
