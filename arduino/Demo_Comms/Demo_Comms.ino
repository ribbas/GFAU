void setup() {
    // put your setup code here, to run once:

    //data pins
    pinMode(0, INPUT);
    pinMode(1, INPUT);
    pinMode(3, INPUT);
    pinMode(4, INPUT);
    pinMode(5, INPUT);
    pinMode(6, INPUT);
    pinMode(7, INPUT);
    pinMode(8, INPUT);

    pinMode(9, OUTPUT); //INTA
}

void loop() {
  // put your main code here, to run repeatedly:

}

//swap bus direction to:
//0: INPUT
//ELSE: OUTPUT
void swapDirection(int i){
    if(i = 0){
        pinMode(0, INPUT);
        pinMode(1, INPUT);
        pinMode(3, INPUT);
        pinMode(4, INPUT);
        pinMode(5, INPUT);
        pinMode(6, INPUT);
        pinMode(7, INPUT);
        pinMode(8, INPUT);
    }else{
        pinMode(0, OUTPUT);
        pinMode(1, OUTPUT);
        pinMode(3, OUTPUT);
        pinMode(4, OUTPUT);
        pinMode(5, OUTPUT);
        pinMode(6, OUTPUT);
        pinMode(7, OUTPUT);
        pinMode(8, OUTPUT);
    }
}

