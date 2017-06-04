import processing.serial.*;
Serial port;
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

// Dependancy Import and Variable Decleration
import controlP5.*;

ControlP5 cp5;
DropdownList d1;

int cnt = 0;


// Setup Loop
void setup() {
  size(700, 400 );
  cp5 = new ControlP5(this);
  
  d1 = cp5.addDropdownList("myList-d1")
          .setPosition(100, 100)
          ;
          
  customize(d1); // customize the first list
}


// Drop Down List UI Elements
void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("dropdown");
  
  for(int i = 0; i<Serial.list().length; i++){
  ddl.addItem(Serial.list()[i], i);
  }
  
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

// Key Press Handling Method If Statment Loop
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


// Select Port Method
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
}