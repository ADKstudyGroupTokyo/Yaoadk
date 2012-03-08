/*
  CapacitiveSense.h v.03 - Capacitive Sensing Library for 'duino / Wiring
  Copyright (c) 2008 Paul Bagder  All rights reserved.
*/

// ensure this library description is only included once
#ifndef CapSense_h
#define CapSense_h

// include types & constants of Wiring core API
//Kenichi Yoshida 2010/02/01
//#include <WProgram.h>
#include <Arduino.h>

// library interface description
class CapSense
{
  // user-accessible "public" interface
  public:
  
  // variables
    int error;
	unsigned long  leastTotal;
	unsigned int   loopTimingFactor;
	unsigned long  CS_Timeout_Millis;
    unsigned long  CS_AutocaL_Millis;
    unsigned long  lastCal;
    unsigned long  total;

	uint8_t sBit;   // send pin's ports and bitmask
	uint8_t sPort;
	volatile uint8_t *sReg;
	volatile uint8_t *sOut;
	
	uint8_t rBit;    // receive pin's ports and bitmask 
	uint8_t rPort;
	volatile uint8_t *rReg;
	volatile uint8_t *rIn;
	volatile uint8_t *rOut;
  
  // methods
    CapSense(uint8_t sendPin, uint8_t receivePin);
    long capSenseRaw(uint8_t samples);
    long capSense(uint8_t samples);
	void set_CS_Timeout_Millis(unsigned long timeout_millis);
	void reset_CS_AutoCal();
    void set_CS_AutocaL_Millis(unsigned long autoCal_millis);
  // library-accessible "private" interface
  private:
      int SenseOneCycle(void);

};

#endif