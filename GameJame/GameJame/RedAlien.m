//
//  RedAlien.m
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "RedAlien.h"


@implementation RedAlien
-(id) init{
    if(self = [super initWithImageNamed:@"Alien2.png"]){
        _inSpeedModifier = IN_SPEED_MODIFIER_RED;
        _outSpeedModifier = OUT_SPEED_MODIFIER_RED;
    }
    return self;
}
@end
