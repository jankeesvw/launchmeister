/* LED Blink, Teensyduino Tutorial #1
   http://www.pjrc.com/teensy/tutorial.html
 
   This example code is in the public domain.
*/

const int ledPin = 11;   // Teensy has LED on 11, Teensy++ on 6

int button1 = 0; 
int button2 = 0; 
int button3 = 0; 
int button4 = 0;
String output = "0000";
String previousOutput = "0000";

// the setup() method runs once, when the sketch starts

void setup() {
  // initialize the digital pin as an output.
  pinMode(ledPin, OUTPUT);
  pinMode(PIN_B0, INPUT_PULLUP);
  pinMode(PIN_B1, INPUT_PULLUP);
  pinMode(PIN_B2, INPUT_PULLUP);
  pinMode(PIN_B3, INPUT_PULLUP);
  Serial.begin(9600);
}

// the loop() methor runs over and over again,
// as long as the board has power

void loop() {
//  digitalWrite(ledPin, HIGH);   // set the LED on
//  delay(100);                  // wait for a second
//  digitalWrite(ledPin, LOW);    // set the LED off
//  delay(100);                  // wait for a second
//  if (digitalRead(PIN_B0)) {
    // do this if C2 is high
    //  digitalWrite(ledPin, LOW);
//  } else {
   //   digitalWrite(ledPin, HIGH);
    // do this if C2 is low
//  }
//  output = ""
  output = "";
  
  button1 = digitalRead(PIN_B0);
  button2 = digitalRead(PIN_B1);
  button3 = digitalRead(PIN_B2);
  button4 = digitalRead(PIN_B3);
//  Serial.println("Okay--");
//  Serial.println(button1);
//  Serial.println(button2);

  if(button1 == 0){
    output += "1";
  }else{
    output += "0";
  }
  if(button2 == 0){
    output += "1";
  }else{
    output += "0";
  }
  if(button3 == 0){
    output += "1";
  }else{
    output += "0";
  }
  if(button4 == 0){
    output += "1";
  }else{
    output += "0";
  }
  
//  if(button1 == 0 && button2 == 0 && button3 == 0 && button4 == 0){
//      digitalWrite(ledPin, HIGH);  
//    }else{
//      digitalWrite(ledPin, LOW);  
//    }
    
if(previousOutput != output){
  
    Serial.println(output);
    previousOutput = output;
}
  
//  if (button1 == H) {
//    if(digitalRead(PIN_B1)){
//      digitalWrite(ledPin, HIGH);  
//    }else{
//      digitalWrite(ledPin, LOW);  
//    }
//  }else{
//    digitalWrite(ledPin, LOW);
//  }
  delay(50);
  
}

