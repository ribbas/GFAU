#define DATA_PINS   {17, 16, 3, 4, 5, 6, 7, 8}
#define OE      9
#define WR      10

volatile uint8_t serial_size = 0;
static int data_pins[8] = DATA_PINS;

void setup() {
    swapDirections(0);
    pinMode(OE, OUTPUT);
    pinMode(WR, OUTPUT);
    Serial.begin(9600);
    delay(100);
}

void loop() {
    char buf[20] = "";
    
    while(serial_size == 0){
        serial_size = Serial.available();
        delay(50);
    }
    Serial.readBytes(buf, serial_size);
    delay(50);
    if(String(buf).substring(0, 2) == "wr"){
        uint8_t x = String(buf).substring(2).toInt();
        Serial.print("Writing ");
        Serial.println(String(x));
        wr(x);
    }else{
        Serial.println(String(rd()));
    }
    serial_size = 0;
}

void wr(uint8_t data) {
    swapDirections(1);
    digitalWrite(OE, LOW);
    writeUint8(data);
    digitalWrite(WR, HIGH);
    digitalWrite(WR, LOW);
    swapDirections(0);
}

uint8_t rd(){
    
    digitalWrite(OE, HIGH);
    return readUint8();
}
    
//swap bus direction to:
//0: INPUT
//ELSE: OUTPUT
void swapDirections(uint8_t i){
    if(i == 0){
        for(int i = 0; i < 8; i++){
            pinMode(data_pins[i], INPUT);
        }
    }else{
        for(int i = 0; i < 8; i++){
            pinMode(data_pins[i], OUTPUT);
        }
    }
}

void writeUint8(uint8_t input){ 
    swapDirections(1);
    for(uint8_t i = 0; i < 8; i++){
        digitalWrite(data_pins[i], (input >> i) & 0x01);
    }   
}

uint8_t readUint8(){
    uint8_t ret = 0;
    for(uint8_t i = 0; i < 8; i++){
        ret |= (digitalRead(data_pins[i]) << i);
    }
    return ret;
}
