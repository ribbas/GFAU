//opcode macros
#define MODE_OP     0x30
#define BUS8        0x00
#define BUS16       0x02
#define BUS32       0x04

#define GEN         0x00
#define ADD         0x08
#define MULT        0x10
#define DIV         0x18
#define LOG         0x20

#define EEE         0x00
#define EEP         0x01
#define EPE         0x02
#define EPP         0x03
#define PEE         0x04 //hehehehe
#define PEP         0x05
#define PPE         0x06
#define PPP         0x07

//bus info/config
#define BUS_SIZE    0x08
#define DATA_PINS   {17, 16, 3, 4, 5, 6, 7, 8}
#define INT         2
#define INTA        9
#define START       10
#define TCLK        11
#define READY       12
#define ERR         13
#define RST         15

const uint8_t data_pins[BUS_SIZE] = DATA_PINS;
const uint8_t bus_size = BUS_SIZE;
volatile uint8_t vec = 0;
volatile uint8_t err = 0;
volatile uint8_t intd = 0; //interrupt detected;
volatile uint8_t bus_mode = 0;
volatile uint8_t op_size = 0;

void setup() {
    op_size = 8;

    //data pins
    pinMode(0, OUTPUT);
    pinMode(1, OUTPUT);
    pinMode(3, OUTPUT);
    pinMode(4, OUTPUT);
    pinMode(5, OUTPUT);
    pinMode(6, OUTPUT);
    pinMode(7, OUTPUT);
    pinMode(8, OUTPUT);

    pinMode(INT, INPUT); //INT
    pinMode(INTA, OUTPUT); //INTA
    pinMode(START, OUTPUT); //START
    pinMode(TCLK, OUTPUT); //TCLK
    pinMode(READY, INPUT); //READY
    pinMode(ERR, INPUT); //ERR 
    pinMode(RST, OUTPUT); 
    pinMode(14, OUTPUT);  
    pinMode(A0, OUTPUT);  
    digitalWrite(TCLK, LOW);
    clearBus();
    attachInterrupt(digitalPinToInterrupt(INT), isr, RISING);
    delay(100);
    Serial.begin(9600);
    delay(100);
    setMode(BUS8);
}

volatile uint8_t serial_size = 0;

void loop() {

        //uint8_t a = Serial.read();
        //uint8_t serial_size = 0;
        char buf[20] = "";
        while(serial_size == 0){
            serial_size = Serial.available();
            delay(50);
        }
        Serial.readBytes(buf, serial_size);
        if(String(buf) == "rst\n"){
            rst();
            if(digitalRead(READY) == HIGH){
                Serial.println("Reset Successful");
            }
            vec = 0;
        }else if(String(buf) == "mode\n"){
            setMode(BUS8);
        }else if(String(buf) == "clk\n"){
            clk_blip();
        }else if(String(buf) == "testLog\n"){
            gLog(0xFF);   
        }else if(String(buf) == "testAdd\n"){
            writeUint8(0x99);
            add(0x0A, 0xF0, PPP);
        }else{
            writeUint8(0x05);
            gen(8, 0x8E);
            Serial.println("Gen Started");
        }    
        serial_size = 0;
}

void rst() {
    digitalWrite(RST, HIGH);
    clk_blip();
    digitalWrite(RST, LOW);
}

//swap bus direction to:
//0: INPUT
//ELSE: OUTPUT
void swapDirections(uint8_t i){
    if(i == 0){
        for(int i = 0; i < BUS_SIZE; i++){
            pinMode(data_pins[i], INPUT);
        }
    }else{
        for(int i = 0; i < BUS_SIZE; i++){
            pinMode(data_pins[i], OUTPUT);
            clearBus();
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
    swapDirections(0);
    for(uint8_t i = 0; i < 8; i++){
        ret |= (digitalRead(data_pins[i]) << i);
    }
    return ret;
}

void isr(){
    Serial.println("ISR Entered");
    clk_blip();
    vec = readUint8();
    err = digitalRead(ERR);
    intd = 1;
    digitalWrite(INTA, HIGH);
}

void setMode(uint8_t mode){
    mode &= 0x07; //clear all but bottom 3 bits;
    bus_mode = mode; //assign bus mode
    uint8_t op = MODE_OP | mode;
    writeUint8(op);
    start();
}

uint8_t gen(uint8_t size, uint16_t poly){
    uint8_t op = GEN;
    writeUint8(op);
    start();
    writeUint8(size & 0x0F);
    clk_blip();
    writeUint8(poly & 0xFF);
    clk_blip();
    while(intd == 0){}
    intd = 0;
    Serial.println("ISR Exited");
    clk_blip();
    digitalWrite(INTA, LOW);
}

uint8_t gLog(uint16_t opand){
    uint8_t opcode = LOG;
    writeUint8(opcode);
    delay(1);
    start();
    writeUint8(opand & 0x66);
    clk_blip();
    writeUint8(0x00);
    clk_blip();
    while(intd = 0){}
    intd = 0;
    Serial.println("ISR Exited");
    Serial.println(String(vec, HEX));
    clk_blip();
    digitalWrite(INTA, LOW);
    clk_blip();
}

uint8_t add(uint16_t op1, uint16_t op2, uint8_t conv){
    uint8_t operand = ADD | (conv & 0x07);
    writeUint8(operand);
    start();

    if(write2Ops(op1, op2)){
        return 0;
    }else{
        
        while(!intd){}
        intd = 0;
        Serial.println("ISR Exited");
        Serial.println(String(vec, HEX));
        clk_blip();
        digitalWrite(INTA, LOW);
        clk_blip();
    }
    
    return 0;
}

uint8_t write2Ops(uint16_t op1, uint16_t op2){
    if(bus_mode == 0){
        if((op_size & 0x0F) <= 8){
            Serial.println("uhh");
            writeUint8(op1 & 0x00FF);
            clk_blip();
            writeUint8(op2 & 0x00FF);
            clk_blip();
        }else if((op_size & 0x0F) > 8 && (op_size & 0x0F) < 13){
            writeUint8(op1 & 0xFF);
            clk_blip();
            writeUint8(((op1 >> 8) & 0x0F) | ((op2 << 4) & 0xF0));
            clk_blip();
            writeUint8(((op2 >> 4) & 0xFF));
            clk_blip();
        }else{
            writeUint8(op1 & 0xFF);
            clk_blip();
            writeUint8((op1 >> 8) & 0xFF);
            clk_blip();
            writeUint8(op2 & 0xFF);
            clk_blip();
            writeUint8((op2 >> 8) & 0xFF);
            clk_blip();
        }
        Serial.println("exiting correctly");
        return 0;
        
    }else{ //must be in bus_mode 0
        return 1;
    }
}

void start(){
    digitalWrite(START, HIGH);
    digitalWrite(TCLK, HIGH);
    digitalWrite(START, LOW);
    digitalWrite(TCLK, LOW);
}

void clk_blip(){
    digitalWrite(TCLK, HIGH);
    digitalWrite(TCLK, LOW);
}

void clearBus(){
    digitalWrite(START, LOW);
    digitalWrite(TCLK, LOW);
    digitalWrite(INTA, LOW);
    for(int i = 0; i < 8; i++){
        digitalWrite(data_pins[i], LOW);
    }
}

