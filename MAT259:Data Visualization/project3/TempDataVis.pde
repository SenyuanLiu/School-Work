import peasy.*;

CameraState state;
PeasyCam cam;

Table table, temperature;
String[][] city;
String[] date;
float[][] data;
PGraphics pg;
int mode = 0;
String time = "";
int speed = 5;
void setup() {
  size(1600, 983, P3D);
  //colorMode(HSB,360,100,100);
 

  cam = new PeasyCam(this, 1000);
  state = cam.getState();
  table = loadTable("city.csv", "header");
  temperature = loadTable("temperature.csv", "header");

  colorMode(HSB, 360, 100, 100);

  city = new String[3][27];
  data = new float[27][45252];
  date = new String[45252];

  //println(temperature.getRowCount() + " total rows in table");
  int i = 0;
  for (TableRow row : table.rows()) {

    city[0][i] = row.getString("City");
    city[1][i] = row.getString("Longitude");
    city[2][i] = row.getString("Latitude");
    i++;
  }

  int j = 0;
  for (TableRow row : temperature.rows()) {
    for (int k = 0; k<27; k++) {
      data[k][j] = (row.getFloat(city[0][k])-288)*10;
      date[j] = row.getString("datetime");
    }
    j++;
  }
}

int index = 1;
void draw() {
//push();
 textSize(20);
  //directionalLight(51, 102, 126, -1, 0, 0);
  float ratioX = 24;
  float ratioY = 34;
  background(0);
  push();
  translate(-width/2, -height/2, -200);

  pop();

  push();

  //float preY = Float.parseFloat(city[2][i-1])*ratioX;

  translate(width/2+1486, width/2+441, 0);
  for (int i = 0; i<city[0].length; i++) {
    fill(0, 10);
    push();
    translate(Float.parseFloat(city[1][i])*ratioX, (-1*Float.parseFloat(city[2][i]))*ratioY, data[i][index]);
    sphere(5);
    //ellipse(Float.parseFloat(city[1][i])*ratioX,(-1*Float.parseFloat(city[2][i]))*ratioY,20,20);
    pop();
    fill(255);
    text(city[0][i], Float.parseFloat(city[1][i])*ratioX, (-1*Float.parseFloat(city[2][i]))*ratioY, data[i][index]);
    fill(300, 100, 100);
    text(round(data[i][index]/10+288), Float.parseFloat(city[1][i])*ratioX, (-1*Float.parseFloat(city[2][i]))*ratioY, data[i][index]+50);


    float iX = Float.parseFloat(city[1][i])*ratioX;
    float iY = -1*Float.parseFloat(city[2][i])*ratioY;
    //println(360*noise(i),100*noise(i+200),100*noise(i+100));

    for (int j = 0; j<city[0].length; j++) {
      stroke(data[j][index], 60, 100);
      float jX = Float.parseFloat(city[1][j])*ratioX;
      float jY = -1*Float.parseFloat(city[2][j])*ratioY;

      line(iX, iY, data[i][index], jX, jY, data[j][index]);
    }
  }



  pop();
  if (frameCount%speed==0) {
    if(mode==0){
    index++;
    }else{
    index+=24;
    }
    
    if (index>=45252) {
      index=1;
    }
  }
 
  cam.feed();
   cam.beginHUD();
 
  fill(255);  
  textSize(20);
  if(mode==0){
  time = date[index] ;
  }else{
  time = date[index].split(" ")[0] ;
  }
  text("Date:"+time,100,50);
 
  if(mode==0){
   text("Time:HOUR",400,50);
  }else{
   text("Time:DAY",400,50);
  }
 fill(255);
  text("Speed Coltrol:",100,100);
   rect(310,90,speed*10,10);
   textSize(20);
    text("Russell Liu- Temperature Movement-Made in Processing 4.0.3",800,50);
  fill(221,81,69);
    cam.endHUD();
    
    if(mouseY<300){
    speed = (int)map(mouseX,width/4,width/2,1,30);
    }
    if(speed<=1){
    speed = 1;
    }
    
    
   
    
 
}

void mouseClicked(){
  if(mode ==0){
  mode=1;
  }else{
  
  mode = 0;}
  
  

}
