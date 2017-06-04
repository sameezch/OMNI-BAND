import processing.serial.*;
Serial myPort;
String val;
/**
 *
 * DEPRECATED, use ScrollableList instead.
 * 
 * Control5 DropdownList
 * A dropdownList controller, extends the ListBox controller.
 * the most recently selected dropdownlist item is displayed inside
 * the menu bar of the DropdownList.
 *
 * find a list of public methods available for the DropdownList Controller 
 * at the bottom of this sketch's source code
 *
 *
 * by andreas schlegel, 2012
 * www.sojamo.de/libraries/controlp5
 */


import controlP5.*;

ControlP5 cp5;
Slider2D s;

DropdownList d1;
public int slider1 = 32;

int cnt = 0;
Chart myChart;
Slider slider;


void setup() {
  size(700, 400 );
  cp5 = new ControlP5(this);
  
 
  d1 = cp5.addDropdownList("myList-d1")
          .setPosition(50, 50)
          ;
          
  customize(d1); // customize the first list
  //Steup for the chart

  myChart = cp5.addChart("heartrate")
               .setPosition(300, 50)
               .setSize(200, 100)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);
 float s1 = (sin(frameCount*0.1)*10);
 System.out.println(s1);
 
 //Serial draw setup
  //size(500,500);
  //Hard Coded port number can cause crash if not correctly assigned to arduino
  String portName = Serial.list()[2]; 
  myPort = new Serial(this, portName, 9600);
 
}


void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setWidth(200);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("dropdown");
  
  for(int i = 0; i<Serial.list().length; i++){
  ddl.addItem(Serial.list()[i], i);
  }
  
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}



void keyPressed() {
  // some key events to change the properties of DropdownList d1
  if (key=='1') {
    // set the height of a pulldown menu, should always be a multiple of itemHeight
    d1.setHeight(210);
  } 
  else if (key=='2') {
    // set the height of a pulldown menu, should always be a multiple of itemHeight
    d1.setHeight(120);
  }
  else if (key=='3') {
    // set the height of a pulldown menu item, should always be a fraction of the pulldown menu
    d1.setItemHeight(30);
  } 
  else if (key=='4') {
    // set the height of a pulldown menu item, should always be a fraction of the pulldown menu
    d1.setItemHeight(12);
    d1.setBackgroundColor(color(255));
  } 
  else if (key=='5') {
    // add new items to the pulldown menu
    int n = (int)(random(100000));
    d1.addItem("item "+n, n);
  } 
  else if (key=='6') {
    // remove items from the pulldown menu  by name
    d1.removeItem("item "+cnt);
    cnt++;
  }
  else if (key=='7') {
    d1.clear();
  }
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

void draw() {
  background(128);
  
  //Draw for chart
  background(200);
  // unshift: add data from left to right (first in)
  //myChart.unshift("incoming", (sin(frameCount*0.1)*20));
  
  // push: add data from right to left (last in)
  myChart.unshift("incoming", (sin(frameCount*0.1)*10));
  
  float s1 = (sin(frameCount*0.1)*10);
  
  cp5.addSlider("Temperture")
     .setPosition(100,305)
     .setSize(200,20)
     .setRange(0,10)
     .setValue(s1)
     .plugTo(s1);
     
     ;
  
  
  
  
  //Serial text draw functions and hardcoded port loop
    if ( myPort.available() > 0) 
    {  
    val = myPort.readStringUntil('\n');         
    } 
  //println(val); 
  textAlign(CENTER);
  text("serial: " +val,250,250);
}