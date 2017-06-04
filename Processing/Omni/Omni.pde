import processing.serial.*;

Serial myPort;  
String val; 

void setup()
{
  
  
  
  size(500,500);
  String portName = Serial.list()[3]; 
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) 
  {  
  val = myPort.readStringUntil('\n');         
  } 
//println(val); 
textAlign(CENTER);
text("serial: " +val,250,250);
}