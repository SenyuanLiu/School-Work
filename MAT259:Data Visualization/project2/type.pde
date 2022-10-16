import controlP5.*;
ControlP5 cp5;
String searchT=" ", lowSearchT="";
String n = "tf";
void typeSetup() {
  cp5=new ControlP5(this);
  cp5.addTextfield("tf")
    .setPosition(1111, 1111)
    .setSize(1, 1)
    .setFocus(true)
    .setColor(color(0,100,100))
    ;
}
void type() {
  cam.beginHUD();
  fill(0,0,100);
  textSize(25);
  cp5.get(Textfield.class, "tf").setFocus(true);
  searchT=cp5.get(Textfield.class, "tf").getText();
  lowSearchT=searchT.toLowerCase();
  text(searchT, width/2-100, height-100);
  cam.endHUD();
}



void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
}
