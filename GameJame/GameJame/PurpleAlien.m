//
//  PurpleAlien.m
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "PurpleAlien.h"


@implementation PurpleAlien
-(id) init{
    if(self = [super initWithImageNamed:@"AlienBasic.png"]){
        _inSpeedModifier = IN_SPEED_MODIFIER_PURPLE;
        _outSpeedModifier = OUT_SPEED_MODIFIER_PURPLE;
    }
    return self;
}

@end
