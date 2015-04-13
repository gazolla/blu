String readString;
int led1 = 13;
int led2 = 12;
int led3 = 11;
int led4 = 10;

int speakerPin = 3;

void setup() {
    Serial.begin(115200);     //initial the Serial
    delay(150);
    pinMode (led1, OUTPUT); digitalWrite(led1,LOW);
    pinMode (led2, OUTPUT); digitalWrite(led2,LOW);
    pinMode (led3, OUTPUT); digitalWrite(led3,LOW);
    pinMode (led4, OUTPUT); digitalWrite(led4,LOW);
    pinMode (speakerPin, OUTPUT); digitalWrite(speakerPin,LOW);
    
    delay(150);
    digitalWrite(led1,HIGH);
    digitalWrite(led2,HIGH);
    digitalWrite(led3,HIGH);
    digitalWrite(led4,HIGH);
    digitalWrite(speakerPin,HIGH);

}

void loop()
{
    while(Serial.available())
    {
         delay(3);  
         char c = Serial.read();
         readString += c;     //send what has been received
    }
    
    readString.trim();
    
    if (readString.length() >0) {
         Serial.println(readString);
         
         if (readString == "led1on")  { digitalWrite(led1,HIGH); beep();}
         if (readString == "led1off") { digitalWrite(led1,LOW); beep();}
         if (readString == "led2on")  { digitalWrite(led2,HIGH); beep();}
         if (readString == "led2off") { digitalWrite(led2,LOW); beep();}
         if (readString == "led3on")  { digitalWrite(led3,HIGH); beep();}
         if (readString == "led3off") { digitalWrite(led3,LOW); beep();}
         if (readString == "led4on")  { digitalWrite(led4,HIGH); beep();}
         if (readString == "led4off") { digitalWrite(led4,LOW); beep();}
         
         readString="";
    }
}

void beep(){
    digitalWrite(speakerPin, HIGH);
    delay(25);
    digitalWrite(speakerPin, LOW);
    delay(25);
    digitalWrite(speakerPin, HIGH);
}

