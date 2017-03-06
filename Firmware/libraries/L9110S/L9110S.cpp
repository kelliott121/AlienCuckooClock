#include "Arduino.h"
#include "L9110S.h"



#define PWM_RESOLUTION 255



//void analogWrite(uint8_t channel, uint32_t duty)
//{
//  ledcWrite(channel, duty);
//}



L9110S::L9110S(uint8_t A_IA, uint8_t A_IB, uint8_t B_IA, uint8_t B_IB)
{
	_currentSpeedLeft = 0;
	_currentSpeedRight = 0;
	_motionState = STOPPED;

	//ledcAttachPin(A_IA, 0);
	_A_IA = A_IA;
	//ledcAttachPin(A_IB, 1);
	_A_IB = A_IB;
	//ledcAttachPin(B_IA, 2);
	_B_IA = B_IA;
	//ledcAttachPin(B_IB, 3);
	_B_IB = B_IB;
	
	//ledcSetup(0, 12000, 8); // 12 kHz PWM, 8-bit resolution
	//ledcSetup(1, 12000, 8);
	//ledcSetup(2, 12000, 8);
	//ledcSetup(3, 12000, 8);

	pinMode(_A_IA, OUTPUT);
	pinMode(_A_IB, OUTPUT);
	pinMode(_B_IA, OUTPUT);
	pinMode(_B_IB, OUTPUT);
}


void L9110S::forward(uint8_t speed)
{
	setTargetSpeed(-(int16_t)speed, -(int16_t)speed);
}


void L9110S::backward(uint8_t speed)
{
	setTargetSpeed(((int16_t)speed), ((int16_t)speed));
}


void L9110S::turnLeft(uint8_t speed)
{
	setTargetSpeed(((int16_t)speed), -(int16_t)speed);
}


void L9110S::turnRight(uint8_t speed)
{
	setTargetSpeed(-(int16_t)speed, ((int16_t)speed));
}


void L9110S::motorAForward(uint8_t speed)
{
	digitalWrite(_A_IA, LOW);
    analogWrite(_A_IB, speed);
}


void L9110S::motorABackward(uint8_t speed)
{
	digitalWrite(_A_IB, LOW);
	analogWrite(_A_IA, speed);
}


void L9110S::motorBForward(uint8_t speed)
{
	digitalWrite(_B_IA, LOW);
	analogWrite(_B_IB, speed);	
}


void L9110S::motorBBackward(uint8_t speed)
{
	digitalWrite(_B_IB, LOW);
	analogWrite(_B_IA, speed);	
}


void L9110S::setTargetSpeed(int16_t speedLeft, int16_t speedRight)
{
	_targetSpeedLeft = speedLeft;
	_targetSpeedRight = speedRight;
}


void L9110S::update(void)
{
	if (_motionState == MOVING)
	{
		if ((_currentSpeedLeft != _targetSpeedLeft) ||
			(_currentSpeedRight != _targetSpeedRight))
		{
			_motionState = STOPPING;
			Serial.println("STOPPING");
		}
	}
	else if (_motionState == STOPPING)
	{
		if (_currentSpeedLeft < 0)
		{
			_currentSpeedLeft += SPEED_INC;
		}
		else if (_currentSpeedLeft > 0)
		{
			_currentSpeedLeft -= SPEED_INC;
		}
		
		if (_currentSpeedRight < 0)
		{
			_currentSpeedRight += SPEED_INC;
		}
		else if (_currentSpeedRight > 0)
		{
			_currentSpeedRight -= SPEED_INC;
		}
		
		if ((_currentSpeedLeft == 0) && (_currentSpeedRight == 0))
		{
			_motionState = STOPPED;
			_stopDelay = STOP_DELAY;
			Serial.println("STOPPED");
		}
	}
	else if (_motionState == STOPPED)
	{
		if ((_currentSpeedLeft == _targetSpeedLeft) &&
			(_currentSpeedRight == _targetSpeedRight))
		{
			// Do nothing
		}
		else if (_stopDelay > 0)
		{
			_stopDelay--;
		}
		else
		{
			_motionState = ACCELERATING;
			Serial.println("ACCELERATING");
		}
	}
	else if (_motionState = ACCELERATING)
	{
		// Move the current speed toward the target speed
		if (_currentSpeedLeft < _targetSpeedLeft)
		{
			_currentSpeedLeft += SPEED_INC;
		}
		else if (_currentSpeedLeft > _targetSpeedLeft)
		{
			_currentSpeedLeft -= SPEED_INC;
		}
		
		if (_currentSpeedRight < _targetSpeedRight)
		{
			_currentSpeedRight += SPEED_INC;
		}
		else if (_currentSpeedRight > _targetSpeedRight)
		{
			_currentSpeedRight -= SPEED_INC;
		}
		
		if ((_currentSpeedLeft == _targetSpeedLeft) &&
		   (_currentSpeedRight == _targetSpeedRight))
		{
			_motionState = MOVING;
			Serial.println("MOVING");
		}
	}
	
	// Set the new speeds
	if (_currentSpeedLeft < 0)
	{
		motorABackward(abs(_currentSpeedLeft));
	}
	else
	{
		motorAForward(abs(_currentSpeedLeft));
	}
	
	if (_currentSpeedRight < 0)
	{
		motorBBackward(abs(_currentSpeedRight));
	}
	else
	{
		motorBForward(abs(_currentSpeedRight));
	}
}


