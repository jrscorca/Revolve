//
//  RotationTest.h
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface RotationTest : CCNode
{
    CCSprite *star;
    CCSprite *planet;
    
    float dist_star_planet;
    float dist_planet_satellite;
    
    float relative_angle_star_planet;
    float relative_angle_planet_satellite;
}

@end