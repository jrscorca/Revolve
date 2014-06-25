//
//  SpaceDweller.m
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "SpaceDweller.h"


@implementation SpaceDweller{

}

-(id) init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)imageName{
    if(self = [super initWithImageNamed:imageName]){
        [self setup];
    }
    return self;
}

-(void)setup{
    CGSize size = [[CCSprite spriteWithImageNamed:@"Globe.png"] contentSize];
    _globeRadius = size.width/2.0;
    _vacuumTimer = 1;
    _initialInSpeedModifier = 0;
    _initialOutSpeedModifier = 0;
}

-(void)updatePosition:(CCTime)delta{
    //_vacuumTimer+=delta;
    
    //setup initial speed
    if (_initialInSpeedModifier == 0) {
        _initialInSpeedModifier = _inSpeedModifier;
    }
    if (_initialOutSpeedModifier == 0) {
        _initialOutSpeedModifier = _outSpeedModifier;
    }
    
    //find the direction the object should move
    float radians = self.rotation * (M_PI/180);
    
    float xDirection;
    float yDirection;
    if(fabs(_inSpeedModifier) >0){
        xDirection = sinf((float) radians)* _inSpeedModifier;
        yDirection = cosf((float) radians)* _inSpeedModifier;
    }else{
        xDirection = sinf((float) radians)* _outSpeedModifier;
        yDirection = cosf((float) radians)* _outSpeedModifier;
    }
    
    float newX = self.position.x - xDirection;
    float newY = self.position.y - yDirection;
    
    self.position = ccp(newX, newY);

}

-(void)updateSpeed:(CCTime)delta{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    //if the object is below the equator change it's spped modifier to negative
    if (_submerged && self.position.y <= winSize.height/2) {
        if (self.position.x >= winSize.width/2) {
            float offset = (self.position.x - winSize.width/2)*2;
            _outSpeedModifier = _initialOutSpeedModifier * ((self.position.x-offset)/winSize.width/2);
        }else{
            _outSpeedModifier = _initialOutSpeedModifier * (self.position.x/winSize.width/2);
            
        }
        _inSpeedModifier = 0;
        //check if the object is in the vacuum
        if([self checkVacuum:delta]){
            float logMod = log(_vacuumTimer)*20;
            _outSpeedModifier *= logMod;
        }
        
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

-(void)updateProperties:(CCTime)delta{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CGPoint destinationPosition = ccp(winSize.width/2, winSize.height/2);
    
    float distance = sqrtf((self.position.x - destinationPosition.x)*(self.position.x - destinationPosition.x) + (self.position.y - destinationPosition.y)*(self.position.y - destinationPosition.y) );
    
    if (distance<=_globeRadius && !_submerged){
        _inSpeedModifier = 6.0;
        _outSpeedModifier = 0;
        [self.parentGenerator.submergedAliens addObject:self];
        _submerged = YES;
    }else if(distance>_globeRadius && _submerged){
        _outSpeedModifier = _initialOutSpeedModifier;
        _inSpeedModifier = 0;
        _submerged = NO;
        _inVacuum = NO;
        _dead = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateScoreNotification" object:nil];
        [self performSelector:@selector(addToGarbage) withObject:nil afterDelay:2.0];
    }else if(_dead){
        _outSpeedModifier = _initialOutSpeedModifier;
        _inSpeedModifier = 0;
    }
}

-(void)updatePlayer:(CCTime)delta{
    //Override this function
}

-(void)update:(CCTime)delta{
    [self updatePosition:delta];
    [self updateSpeed:delta];
    [self updateProperties:delta];
    [self updatePlayer:delta];
}



-(BOOL)checkVacuum:(CCTime)delta{
    _vacuumTimer+=delta;
    float  positiveRotation = self.rotation;
    while (positiveRotation <0) {
        positiveRotation += 360;
    }
    if (fmod(positiveRotation, 360.0) >=160.0 && fmod(positiveRotation, 360.0) <=200.0){
        _inVacuum = YES;
    }else{
        _inVacuum = NO;
        _vacuumTimer = 1;
    }
    return _inVacuum;
}

-(void)addToGarbage{
    [self.parentGenerator.aliensToRemove addObject:self];
}

@end
