import peasy.*;
PeasyCam cam;
Table table1;
int startYear = 2011;
int endYear = 2021;
ArrayList<Book> books = new ArrayList<Book>();
int nowYear=2010;
boolean check=false;
int myRetun=-1;
PGraphics pg;
float[] rotations;
float []yearX=new float[12];
float[]randoms;
boolean move=true;
boolean ifmove=false;
void setup() {
  fullScreen(P3D);
  //size(1920, 1080, P3D);
  typeSetup();
  pg = createGraphics(width, height, P3D);
  cam = new PeasyCam(this, 200);
  table1 = loadTable("title3.csv", "header");
  colorMode(HSB, 100, 100, 100);
  for (int i=0; i<yearX.length; i++) {
    yearX[i]=map(i, 0, yearX.length, -50, 50);
  }
  for (int i=0; i<table1.getRowCount(); i++) {
    TableRow row=table1.getRow(i);
    int myyear=row.getInt("year");
    int mymonth=row.getInt("month");
    String mytitle=row.getString("title");
    int sum=row.getInt("sum");
    float myTSLA=row.getFloat("TSLA");
    float ran1=random(0, 3);
    float ran2=random(0, 1);
    boolean myshow=false;
    Book newBook = new Book(myyear, mymonth, mytitle, sum, myTSLA, ran1, ran2, myshow);
    books.add(newBook);
  }
  //textAlign(LEFT, CENTER);
  randoms=new float[books.size()];
  for (int i=0; i<randoms.length; i++) {
    randoms[i]=random(-100, 100);
  }
}

void draw() {
  background(0, 0, 20);
  rotations = cam.getRotations();
  cam.setYawRotationMode();//仅仅水平旋转
  //在模型空间中面对摄像机所需的 x，y 和 z 旋转
  nowYear=myRetun+2011;
  for ( int i = 0; i < books.size(); i++) {
    books.get(i).check();
    if (books.get(i).fit) {//flase
      //continue;
      // }
      if ((books.get(i).year!=nowYear)&&(nowYear!=2010)) {
        books.get(i).show=false;
      } else {
        books.get(i).show=true;
      }
      float x, y, z;
      color c;
      float scales=0.01;
      float start_posx=randoms[i];
      float start_posy=randoms[i]/2.0;
      float offsetx=map(noise(frameCount/2*scales+start_posx), 0, 1, -10, 10);
      float offsety=map(noise(frameCount/2*scales+start_posy), 0, 1, -5, 5);
      float offsetz=map(noise(frameCount/3*scales+start_posy), 0, 1, -5, 5);
      if (move) {
        x =offsetx + map((books.get(i).year-2011)*12+books.get(i).month+books.get(i).ran1, 0, 132, -100, 100);//
        y =offsety + map(log(books.get(i).sum)+books.get(i).ran2, log(1), log(33), 50, -30);
        z =offsetz + map(1.5*log(books.get(i).TSLA), 0, 1.5*log(1144), -50, 50);
      } else {
        x = map((books.get(i).year-2011)*12+books.get(i).month+books.get(i).ran1, 0, 132, -100, 100);//
        y = map(log(books.get(i).sum)+books.get(i).ran2, log(1), log(33), 50, -30);
        z = map(1.5*log(books.get(i).TSLA), 0, 1.5*log(1144), -50, 50);
      }
      float h=map(x, -100, 100, 0, 100);
      c = color(h, 100, 100);

      float p_x = screenX(x, y, z);
      float p_y = screenY(x, y, z);

      float distanceObjectMouse = sq(p_x - mouseX) + sq(p_y-mouseY);


      if (distanceObjectMouse < 10) {
        pushMatrix();
        cam.beginHUD();
        textSize(20);
        //scale(0.2);
        translate(100, 50);
        fill(40, 100, 50);
        noStroke();
        rect(0, -20, textWidth(books.get(i).title)+100, 25);
        rect(0, 10, 180, 25);
        rect(0, 40, 180, 25);
        rect(0, 70, 180, 25);
        fill(0, 0, 100);
        text("Title  :  "+books.get(i).title, 10, 0, 0);
        text("Year  :  "+books.get(i).year+"/"+books.get(i).month, 10, 30, 0);
        text("Checkout   :  "+books.get(i).sum, 10, 60, 0);
        text("TSLA Price :  "+books.get(i).TSLA, 10, 90, 0);
        cam.endHUD();
        popMatrix();
      }
      if (distanceObjectMouse < 10) {
        strokeWeight(15);
      }
      if (books.get(i).show==true) {
        stroke(c);
      } else {
        stroke(0, 0, 80, 100);
      }
      if ((distanceObjectMouse > 10)) {
        if (books.get(i).sum<5) {
          strokeWeight(3);
        } else if (books.get(i).sum<10) {
          strokeWeight(6);
        } else {
          strokeWeight(10);
        }
      }
      point(x, y, z);
    }
  }



  drawLabels();
  if (nowYear==2010) {
    stroke(62, 100, 100, 150);
    //fill(0, 0, 90, 10);
    noFill();
    box(200, 100, 100);
  } else {
    strokeWeight(1);
    noFill();
    stroke(62, 100, 100, 150);
    box(200, 100, 100);
    strokeWeight(3);
    pushMatrix();
    translate(map(12*myRetun, 0, 132, -100, 100)+9, 0, 0);
    float h=map(myRetun, 0, 11, 0, 100);
    stroke(h, 100, 100, 150);
    noFill();
    box(200/132.0*12, 100, 100);
    popMatrix();
  }
  bar();
  drawSmallBox();
  type();
  drawButton();
}

void mouseClicked() {
  myRetun=-1;
  check=true;
  for (int i=0; i<11; i++) {
    if (check) {
      float x = 200/132.0*12*i-100;//10*i, 0, 0
      float y = 50;
      float z = 50;
      fill(0, 0, 100);
      stroke(0, 0, 100);
      float p_x = screenX(x, y, z);
      float p_y = screenY(x, y, z);
      ellipse(p_x, p_y, 10, 10);
      float dist = sq(p_x - mouseX) + sq(p_y-mouseY);
      if (dist<30) {
        myRetun= i;
        check=false;
      }
    }
  }

  pushMatrix();
  cam.beginHUD();
  float rx=100;
  float ry=height-200;
  float rw=100;
  float rh=100;
  if (mouseX>rx&&mouseX<rx+rw&&mouseY>ry&&mouseY<ry+rh) {
    move=!move;
  }
  cam.endHUD();
  popMatrix();
}
//
void drawLabels() {
  fill(62, 100, 100);
  stroke(62, 100, 100);
  textSize(20);
  pushMatrix();
  pushStyle();

  drawAxis();
  drawAxis2();
  drawAxis3() ;
  textSize(4);
  text("Checkout", -102, -58, -50);
  text("Year", 103, 58, -50);
  text("TSLA Price", -102, 58, 50);
  popMatrix();
  popStyle();
}

void drawAxis() {
  for (int i=0; i<12; i++) {
    //line(200/132.0*12*i-50, 0, -100, 200/132.0*12*i-50, 1, -100);
    pushMatrix();
    translate(200/132.0*12*i-100, 50, 50);

    ellipse(0, 0, 2, 2);
    popMatrix();
    pushMatrix();
    translate(200/132.0*12*i-100, 50, -50);

    popMatrix();
    pushMatrix();
    translate(200/132.0*12*i-100, -50, 50);

    popMatrix();
    pushMatrix();
    translate(200/132.0*12*i-100, -50, -50);

    popMatrix();
    textSize(2);
    text(2011+i, 200/132.0*12*i-2-100, 54, -50);
    text(2011+i, 200/132.0*12*i-2-100, 54, 50);
    text(2011+i, 200/132.0*12*i-2-100, -4-50, -50);
    text(2011+i, 200/132.0*12*i-2-100, -4-50, 50);
  }
}

void drawAxis2() {
  for (int i=0; i<12; i++) {
    float y=map(i, 0, 11, 50, -50);
    int t=int(map(y, 50, -50, 1, 33));
    pushMatrix();
    translate(-100, y, -50);

    popMatrix();
    pushMatrix();
    translate(-100, y, 50);

    popMatrix();
    pushMatrix();
    translate(100, y, -50);

    popMatrix();
    pushMatrix();
    translate(100, y, 50);

    popMatrix();
    textSize(2);

    text(t, -104, y, -50);
    text(t, -104, y, 50);
    text(t, 102, y, -50);
    text(t, 102, y, 50);
  }
}

void drawAxis3() {
  for (int i=0; i<12; i++) {
    float z=map(i, 0, 11, 50, -50);
    int t=int(map(z, 50, -50, 1144, 0));

    pushMatrix();
    translate(-100, -50, z);

    popMatrix();
    pushMatrix();
    translate(-100, 50, z);

    popMatrix();
    pushMatrix();
    translate(100, -50, z);

    popMatrix();
    pushMatrix();
    translate(100, 50, z);

    popMatrix();
    textSize(2);

    text(t, -102, -50, z);
    text(t, -102, 50, z);
    text(t, 102, -50, z);
    text(t, 102, 50, z);
  }
}
void bar() {
  for (int i=0; i<100; i++) {
    float y=map(i, 0, 100, -50, -10);
    stroke(i, 100, 100);
    strokeWeight(1);
    line(-120, y, 50, -110, y, 50);
  }
  textSize(3);
  for (int j=0; j<11; j++) {
    int year=int(map(j, 0, 10, 2011, 2021));
    float y=map(year, 2011, 2021, -50, -10);
    float h=map(j, 0, 11, 0, 100);
    fill(h, 100, 100);
    text(year, -130, y, 50);
  }
}


void drawButton() {
  pushMatrix();
  cam.beginHUD();
  textSize(30);
  float rx=100;
  float ry=height-200;
  float rw=100;
  float rh=100;

  if (move) {
    fill(40, 100, 50, 100);
    stroke(40, 100, 50);
    rect(rx, ry, rw, rh);
    fill(0, 0, 100);
    text("move", rx+13, ry+50);
  } else {
    fill(0, 100, 100, 100);
    stroke(0, 100, 100);
    rect(rx, ry, rw, rh);
    fill(0, 0, 100);
    text("static", rx+12, ry+50);
  }
  cam.endHUD();
  popMatrix();
}
