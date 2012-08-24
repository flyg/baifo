//
//  MotionDetection.h
//  InvariantView
//
//  Created by Hong Liming on 8/17/12.
//
//

#import <Foundation/Foundation.h>

void MDInit();

void MDProcess(float pitch, float roll, float yaw);

int MDCurrentMotion();

bool MDMotionCompleted();