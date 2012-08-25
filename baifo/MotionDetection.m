//
//  MotionDetection.m
//  InvariantView
//
//  Created by Hong Liming on 8/17/12.
//
//

#import "MotionDetection.h"

#define PI 3.1415926

int currentMotion = 0;

double buffer[360 / 5];

int lastpDeg;
int hit;

bool InMotion1(float pitch, float roll, float yaw)
{
    return (-0.2 < roll && roll < 0.2);
}

void ProcessMotion1(float pitch, float roll, float yaw)
{
    int pDeg = (int)(pitch * 180 / PI / 5) + 180 / 5;
    if (pDeg !=lastpDeg)
    {
        buffer[pDeg]++;
        if (buffer[pDeg]==2)
        {
            hit++;
        }
    }
    lastpDeg = pDeg;
}

bool IsMotion1Completed()
{
    return hit >= 30 / 5;
}


bool InMotion2(float pitch, float roll, float yaw)
{
    return (-0.2 < pitch && pitch < 0.2);
}

void ProcessMotion2(float pitch, float roll, float yaw)
{
    int pDeg = (int)(roll * 180 / PI / 5) + 180 / 5;
    if (pDeg !=lastpDeg)
    {
        buffer[pDeg]++;
        if (buffer[pDeg]==2)
        {
            hit++;
        }
    }
    lastpDeg = pDeg;
}

bool IsMotion2Completed()
{
    return hit >= 30 / 5;
}

void MDInit()
{
    currentMotion = 0;
    for (int i=0;i<360 / 5;i++)
    {
        buffer[i]=0;
    }
    hit = 0;
    lastpDeg = 0;
}


int InMotion(float pitch, float roll, float yaw)
{
    if(InMotion1(pitch, roll, yaw))
    {
        return 1;
    }
    else if(InMotion2(pitch, roll, yaw))
    {
        return 2;
    }
    else
    {
        return 0;
    }
}

bool IsInMotion(int motion, float pitch, float roll, float yaw)
{
    switch(motion)
    {
        case 1:
            return InMotion1(pitch, roll, yaw);
        case 2:
            return InMotion2(pitch, roll, yaw);
        default:
            return false;
    }
}

void ProcessMotion(float pitch, float roll, float yaw)
{
    switch(currentMotion)
    {
        case 1:
            ProcessMotion1(pitch, roll, yaw);
            break;
        case 2:
            ProcessMotion2(pitch, roll, yaw);
            break;
        default:
            break;
    }
}

void MDProcess(float pitch, float roll, float yaw)
{
    NSLog(@"pitch = %f, roll = %f, yaw = %f", pitch, roll, yaw);
    if (currentMotion == 0)
    {
        currentMotion = InMotion(pitch, roll, yaw);
        if (currentMotion>0)
        {
            ProcessMotion(pitch, roll, yaw);
        }
    }
    else
    {
        if (IsInMotion(currentMotion, pitch, roll, yaw))
        {
            ProcessMotion(pitch, roll, yaw);
        }
        else
        {
            MDInit();
        }
    }
}

int MDCurrentMotion()
{
    return currentMotion;
}

bool MDMotionCompleted()
{
    bool completed = false;
    switch(currentMotion)
    {
        case 1:
            completed = IsMotion1Completed();
            break;
        case 2:
            completed = IsMotion2Completed();
            break;
        default:
            completed = false;
            break;
    }
    if (completed)
    {
        MDInit();
    }
    return completed;
}