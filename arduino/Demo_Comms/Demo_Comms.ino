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


const uint8_t data_pins[BUS_SIZE] = DATA_PINS;
const uint8_t bus_size = BUS_SIZE;
volatile uint8_t vec;
volatile uint8_t err = 0;
volatile uint8_t bus_mode = 0;
volatile uint8_t op_size = 0;

void setup() {
    op_size = 13;

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
    pinMode(14, OUTPUT);  

    digitalWrite(TCLK, LOW);
    clearBus();
    attachInterrupt(digitalPinToInterrupt(INT), isr, RISING);
}

void loop() {

    setMode(BUS8);
    while(1){
        if(digitalRead(READY)){
            writeUint8(0x99); //trigger for dla
            add(0x1999, 0x1999, PPE);
        }
    }
    //    delay(1000);
     //   digitalWrite(A0, LOW);
     //   delay(1000);
    
    
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
        ret |= (digitalRead(data_pins[i]) >> i);
    }
    return ret;
}

void isr(){
    //vec = readUint8();
    //err = digitalRead(ERR);
    //digitalWrite(INTA, HIGH);
    //clk_blip();
    //digitalWrite(INTA, LOW);
}

void setMode(uint8_t mode){
    mode &= 0x07; //clear all but bottom 3 bits;
    bus_mode = mode; //assign bus mode
    uint8_t op = MODE_OP | mode;
    writeUint8(op);
    start();
}

uint8_t add(uint16_t op1, uint16_t op2, uint8_t conv){
    uint8_t operand = ADD | (conv & 0x03);
    writeUint8(operand);
    start();
    if(bus_mode == 0){
        if((op_size & 0x0F) < 8){
            writeUint8(op1 & 0xFF);
            clk_blip();
            writeUint8(op2 & 0xFF);
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
        swapDirections(0);
        delay(100);
        digitalWrite(14, HIGH);
        clk_blip();
        digitalWrite(14, LOW);
    }else{ //must be in bus_mode 0
        return 0;
    }
    return 0;
}

void write2Ops(uint32_t op1, uint32_t op2){
    
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


