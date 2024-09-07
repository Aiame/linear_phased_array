const int ARRAY_SIZE = 50;
int analogPin = A0;
int val = 0;
const uint8_t start_marker = 0x7E;
const uint8_t end_marker = 0x7F;
uint16_t timeArray[ARRAY_SIZE];
uint16_t valArray[ARRAY_SIZE];
int phase_num = 0;
long starttime;

int phases[19] = {-18,-15,-12,-9,-8,-6,-4,-3,-2,0,2,3,4,6,8,9,12,15,18};


const int delay2Time = 2;
const int delay4Time = 4;
const int delay12Time = 12; // Delay time in microseconds for 12-degree steering
const int delay3Time = 3; // Delay time in microseconds for 15-degree steering
const int delay18Time = 6; // Delay time in microseconds for 18-degree steering
const int cyclesPerElement = 2; // Number of cycles per element
const int pulseDuration = 24; // Duration of one cycle at 40kHz in microseconds
const int numElements = 4; // Number of elements in the phased array

void setPort(bytepattern, int delayTime) {
    PORTD = pattern ;
    delayMicroseconds(delayTime);
}

void test_delay0() {
    byte patterns[] = {
      B11111100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay12Time);
        }
    }
}

void test_delay2() {
    byte patterns[] = {
      B00011100, B00111100, B01111100, B11111100, B11111100,
      B11111100, B11101100, B11001100, B10001100, B00001100,
      B00001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay2Time);
        }
    }
}

void test_delay3() {
    byte patterns[] = {
      B00011100, B00111100, B01111100, B11111100, B11101100,
      B11001100, B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }
}

void test_delay4() {
    byte patterns[] = {
      B00011100, B00111100, B01111100, B11101100, B11001100,
      B10001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay4Time);
        }
    }
}

void test_delay6() {
    byte patterns[] = {
      B00011100, B00111100, B01101100, B11001100, B10011100,
      B00111100, B01101100, B11001100, B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay18Time);
        }
    }

}

void test_delay8() {
    byte patterns[] = {
      B00011100, B00011100, B00111100, B00101100, B01101100,
      B01001100, B11011100, B10011100, B10111100, B00101100,
      B01101100, B01001100, B11001100, B10001100, B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay4Time);
        }
    }

}

void test_delay9() {
    byte patterns[] = {
      B00011100, B00011100, B00011100, B00111100, B00101100,
      B00101100, B01101100, B01001100, B01011100, B11011100,
      B10011100, B10111100, B10101100, B00101100, B01101100,
      B01001100, B01001100, B11001100, B10001100, B10001100,
      B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }

}

void test_delay12() {
    byte patterns[] = {
      B00011100, B00101100, B01011100, B10101100, B01001100,
      B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay12Time);
        }
    }

}

void test_delay15() {
    byte patterns[] = {
        B00011100, B00011100, B00011100, B00011100, B00001100,
        B00101100, B00101100, B00101100, B00111100, B00011100,
        B01011100, B01011100, B01001100, B01101100, B00101100,
        B10101100, B10101100, B10001100, B11001100, B01001100,
        B01001100, B01001100, B00001100, B10001100, B10001100,
        B10001100, B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }

}

void test_delay18() {
    byte patterns[] = {
        B00011100, B00011100, B00001100, B00101100, B00111100, 
        B00011100, B01001100, B01101100, B00101100, B10001100, 
        B11001100, B01001100, B00001100, B10001100, B10001100, B00001100
    };

    int numPatterns = sizeof(patterns);
    

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay18Time);
        }
    }
    
}

void test_delaym2(){
  byte patterns[] = {
      B10001100, B11001100, B11101100, B11111100, B11111100,
      B11111100, B01111100, B00111100, B00011100, B00001100,
      B00001100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay2Time);
        }
    }

}

void test_delaym3(){
  byte patterns[] = {
      B10001100, B11001100, B11101100, B11111100, B01111100,
      B00111100, B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }
  
}

void test_delaym4(){
  byte patterns[] = {
      B10001100, B11001100, B11101100, B01111100, B00111100,
      B00011100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < cyclesPerElement; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay4Time);
        }
    }
}

void test_delaym6(){
  byte patterns[] = {
      B10001100, B11001100, B01101100, B00111100, B10011100,
      B11001100, B01101100, B00111100, B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay18Time);
        }
    }
  
}

void test_delaym8(){
  byte patterns[] = {
      B10001100, B10001100, B11001100, B01001100, B01101100,
      B00101100, B10111100, B10011100, B11011100, B01001100,
      B01101100, B00101100, B00111100, B00011100, B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay4Time);
        }
    }
}

void test_delaym9(){
  byte patterns[] = {
      B10001100, B10001100, B10001100, B11001100, B01001100,
      B01001100, B01101100, B00101100, B10101100, B10111100,
      B10011100, B11011100, B01011100, B01001100, B01101100,
      B00101100, B00101100, B00111100, B00011100, B00011100,
      B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }
  
}

void test_delaym12(){
  byte patterns[] = {
      B10001100, B01001100, B10101100, B01011100, B00101100,
      B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay12Time);
        }
    }
}

void test_delaym15(){
  byte patterns[] = {
        B10001100, B10001100, B10001100, B10001100, B00001100,
        B01001100, B01001100, B01001100, B11001100, B10001100,
        B10101100, B10101100, B00101100, B01101100, B01001100,
        B01011100, B01011100, B00011100, B00111100, B00101100,
        B00101100, B00101100, B00001100, B00011100, B00011100,
        B00011100, B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay3Time);
        }
    }
}

void test_delaym18(){
  byte patterns[] = {
        B10001100, B10001100, B00001100, B01001100, B11001100,
        B10001100, B00101100, B01101100, B01001100, B00011100,
        B00111100, B00101100, B00001100, B00011100, B00011100, B00001100
    };

    int numPatterns = sizeof(patterns);
    

    for (int cycle = 0; cycle < 1; cycle++) {
        for (int i = 0; i < numPatterns; i++) {
            setPort(patterns[i], delay18Time);
        }
    }
}

void phasearray(int delay_us)
{
    switch (delay_us)
    {
      case 0:test_delay0();break;
      case 2:test_delay2();break;
      case 3:test_delay3();break;
      case 4:test_delay4();break;
      case 6:test_delay6();break;
      case 8:test_delay8();break;
      case 9:test_delay9();break;
      case 12:test_delay12();break;
      case 15:test_delay15();break;
      case 18:test_delay18();break;
      case -2:test_delaym2();break;
      case -3:test_delaym3();break;
      case -4:test_delaym4();break;
      case -6:test_delaym6();break;
      case -8:test_delaym8();break;
      case -9:test_delaym9();break;
      case -12:test_delaym12();break;
      case -15:test_delaym15();break;
      case -18:test_delaym18();break;
      default:break;
    }
}

void setup() {
    DDRD = B11111100; // Set PORTD pins as outputs
    Serial.begin(115200); // Initialize serial communication for debugging
    starttime = micros();
}

void loop() {

  int phase = phases[phase_num%19];
  long ttt = micros();
  phasearray(phase);
  long st = micros();
  st += 60;

  long time;
  for(int i = 0; i < ARRAY_SIZE; i++){
    val = analogRead(analogPin);
    valArray[i] = val;
    time = micros();
    timeArray[i] = time-st;
  }

  for(int i = 0; i<50; i++){
  Serial.print(timeArray[i] + String(","));
  Serial.print(valArray[i] + String(","));
  }

  Serial.print(phase_num % 19);
  Serial.println();
  long mt = micros();

  phase_num += 1;
  delay(10);
  
}

