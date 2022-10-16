void drawSmallBox() { 
  pg.beginDraw();
  pg.ortho(-width/2, width/2, -height/2, height/2); // Same as ortho()
  pg.clear();
  pg.strokeWeight(3);
  pg.stroke(0);
  pg.fill(255);
  pg.translate(width-65, height-80);
  pg.rotateX(-rotations[0]);
  pg.rotateY(-rotations[1]);
  pg.rotateZ(-rotations[2]);
  pg.box(50);  
  pg.fill(255, 0, 0);
  pg.translate(-25, -25, 25.1);
  pg.rect(0, 0, 50, 50);
  pg.endDraw();
  cam.beginHUD();   
  image(pg, 0, 0);
  cam.endHUD();
}
