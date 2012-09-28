
const int PIN_BUTTON_1 = PIN_B0;
const int PIN_BUTTON_2 = PIN_B1;
const int PIN_BUTTON_3 = PIN_B2;
const int PIN_BUTTON_4 = PIN_B3;

const int PIN_SWITCH_A = PIN_B7;
const int PIN_SWITCH_B = PIN_D0;

const int PIN_LED = PIN_D1;

const int ACTIVATION_DURATION = 3000;

int button1 = 0; 
int button2 = 0; 
int button3 = 0; 
int button4 = 0;
int switchA = 0; 
int switchB = 0;

int triggerTimer = 0;

String currentKeyCombo = "-1";
String lastKeyCombo = "-1";
String switchValue = "-1";

void setup() { 
  //led
  pinMode(PIN_LED, OUTPUT);

  //regular switches
  pinMode(PIN_BUTTON_1, INPUT_PULLUP);
  pinMode(PIN_BUTTON_2, INPUT_PULLUP);
  pinMode(PIN_BUTTON_3, INPUT_PULLUP);
  pinMode(PIN_BUTTON_4, INPUT_PULLUP);

  // A - B switch
  pinMode(PIN_SWITCH_A, INPUT_PULLUP);
  pinMode(PIN_SWITCH_B, INPUT_PULLUP);  

  // start serial output @ 9600 baud
  Serial.begin(9600);
}

void loop() {

  currentKeyCombo = "";

  button1 = digitalRead(PIN_BUTTON_1);
  button2 = digitalRead(PIN_BUTTON_2);
  button3 = digitalRead(PIN_BUTTON_3);
  button4 = digitalRead(PIN_BUTTON_4);

  switchA = digitalRead(PIN_SWITCH_A);
  switchB = digitalRead(PIN_SWITCH_B);

  switchValue = switchA == 0 ? "A" : "B";

  currentKeyCombo += button1 == 0 ? "1" : "0";
  currentKeyCombo += button2 == 0 ? "1" : "0";
  currentKeyCombo += button3 == 0 ? "1" : "0";
  currentKeyCombo += button4 == 0 ? "1" : "0";

  //ACTIVATION_DURATION
  if(currentKeyCombo == "0000"){
    triggerTimer = 0;
    lastKeyCombo = "-1";
    digitalWrite(PIN_LED, LOW);   
  }
  else{
    triggerTimer++;
    digitalWrite(PIN_LED, HIGH);    
  }

  if(triggerTimer > ACTIVATION_DURATION){

    triggerTimer = 0;
    if(currentKeyCombo == lastKeyCombo){
      // ignore if the user hold the key down
    }
    else{
      Serial.println(switchValue + currentKeyCombo);    
      lastKeyCombo = currentKeyCombo;       
    }

  }
}












