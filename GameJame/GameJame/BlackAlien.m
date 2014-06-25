//
//  BlackAlien.m
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "BlackAlien.h"


@implementation BlackAlien
-(id) init{
    if(self = [super initWithImageNamed:@"AlienB&W.png"]){
        _inSpeedModifier = IN_SPEED_MODIFIER_BLACK;
        _outSpeedModifier = OUT_SPEED_MODIFIER_BLACK;
    }
    return self;
}

-(void)updateSpeed:(CCTime)delta{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    //if the object is below the equator change it's spped modifier to negative
    if (_submerged && self.position.y <= winSize.height/2) {
        if([self checkVacuum:delta]){
            _outSpeedModifier = _initialOutSpeedModifier;
            _inSpeedModifier = 0;
            float logMod = log(_vacuumTimer)*20;
            _outSpeedModifier *= logMod;
        }else if (self.position.x >= winSize.width/2) {
            float offset = (self.position.x - winSize.width/2)*2;
            _inSpeedModifier = _initialInSpeedModifier * ((self.position.x-offset)/winSize.width/2);
            _outSpeedModifier = 0;
        }else{
            _inSpeedModifier = _initialInSpeedModifier * (self.position.x/winSize.width/2);
            _outSpeedModifier = 0;
        }
        
        //check if the object is in the vacuum

        
        //if the object is above the equator change it's spped modifier to negative
    }else if (_submerged && self.position.y > winSize.height/2) {
        if (self.position.x >= winSize.width/2) {
            float offset = (self.position.x - winSize.width/2)*2;
            _inSpeedModifier = _initialInSpeedModifier * ((self.position.x-offset)/winSize.width/2);
        }else{
            _inSpeedModifier = _initialInSpeedModifier * (self.position.x/winSize.width/2);
        }
        _outSpeedModifier = 0;
    }
    
}
@end
