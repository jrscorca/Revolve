//
//  Alien.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import "Alien.h"
#import "AlienGenerator.h"

@implementation Alien{
    float _globeRadius;
    float speedModifier;
    BOOL inVacuum;
    float vacuumModifier;
    float vacuumTimer;


}

-(id) init{
    if(self = [super initWithImageNamed:@"AlienBasic.png"]){
        _redAlienModifier = 1.0;
        speedModifier = 3.0*_redAlienModifier;
        CGSize size = [[CCSprite spriteWithImageNamed:@"Globe.png"] contentSize];
        _globeRadius = size.width/2.0;
        vacuumTimer = 1;
    }
    return self;
}

-(void)update:(CCTime)delta{
    vacuumTimer+=delta;
    
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
    float radians = self.rotation * (M_PI/180);
    
    float xDirection = sinf((float) radians)* speedModifier*_redAlienModifier;
    float yDirection = cosf((float) radians)* speedModifier*_redAlienModifier;
    
    float newX = self.position.x - xDirection;
    float newY = self.position.y - yDirection;
    
    self.position = ccp(newX, newY);
    
    CGPoint destinationPosition = ccp(winSize.width/2, winSize.height/2);
    
    float d = sqrtf((self.position.x - destinationPosition.x)*(self.position.x - destinationPosition.x) + (self.position.y - destinationPosition.y)*(self.position.y - destinationPosition.y) );
    

    

    if (_submerged && self.position.y <= winSize.height/2) {
        if (self.position.x >= winSize.width/2) {
            float offset = (self.position.x - winSize.width/2)*2;
            speedModifier = -3.0*((self.position.x-offset)/winSize.width/2);
        }else{
            speedModifier = -3.0*(self.position.x/winSize.width/2);
            
        }
        [self checkVacuum];
    }else{
        if (_submerged && self.position.y > winSize.height/2) {
            if (self.position.x >= winSize.width/2) {
                float offset = (self.position.x - winSize.width/2)*2;
                speedModifier = 6.0*((self.position.x-offset)/winSize.width/2)*_redAlienModifier;
            }else{
                speedModifier = 6.0*(self.position.x/winSize.width/2)*_redAlienModifier;
            }
        }

    }
    
    if (d<=_globeRadius && !_submerged){
        speedModifier = 6.0*_redAlienModifier;
        [self.parentGenerator.submergedAliens addObject:self];
        _submerged = YES;
    }else if(d>_globeRadius && _submerged){
        speedModifier = -4.0;
        _submerged = NO;
        inVacuum = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateScoreNotification" object:nil];
        [self performSelector:@selector(addToGarbage) withObject:nil afterDelay:2.0];
        
    }
    
    if (d < _globeRadius*.03) {
        //NSLog(@"You Lost");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerLostNotification" object:nil];
    }
    if (inVacuum) {
        float logMod = log(vacuumTimer)*20;
        speedModifier *= logMod;
    }
    
}

-(void)checkVacuum{
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    float  positiveRotation = self.rotation;
    while (positiveRotation <0) {
        positiveRotation += 360;
    }

    
    
    if (fmod(positiveRotation, 360.0) >=160.0 && fmod(positiveRotation, 360.0) <=200.0){
        inVacuum = YES;
    }else{
        inVacuum = NO;
        vacuumTimer = 1;
    }
}

-(void)addToGarbage{
    [self.parentGenerator.aliensToRemove addObject:self];
}





@end
