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

}

-(id) init{
    if(self = [super initWithImageNamed:@"Alien.png"]){
        speedModifier = 5.0;
        CGSize size = [[CCSprite spriteWithImageNamed:@"Globe.png"] contentSize];
        _globeRadius = size.width/2.0;
    }
    return self;
}

-(void)update:(CCTime)delta{
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
    float radians = self.rotation * (M_PI/180);
    
    float xDirection = sinf((float) radians)* speedModifier;
    float yDirection = cosf((float) radians)* speedModifier;
    
    float newX = self.position.x - xDirection;
    float newY = self.position.y - yDirection;
    
    self.position = ccp(newX, newY);
    
    CGPoint destinationPosition = ccp(winSize.width/2, winSize.height/2);
    
    float d = sqrtf((self.position.x - destinationPosition.x)*(self.position.x - destinationPosition.x) + (self.position.y - destinationPosition.y)*(self.position.y - destinationPosition.y) );
    

    

    if (_submerged && self.position.y <= winSize.height/2) {
        if (self.position.x >= winSize.width/2) {
            float offset = (self.position.x - winSize.width/2)*2;
            speedModifier = -5.5*((self.position.x-offset)/winSize.width/2);
        }else{
            speedModifier = -5.5*(self.position.x/winSize.width/2);
        }
    }else{
        if (_submerged && self.position.y > winSize.height/2) {
            if (self.position.x >= winSize.width/2) {
                float offset = (self.position.x - winSize.width/2)*2;
                speedModifier = 6.5*((self.position.x-offset)/winSize.width/2);
            }else{
                speedModifier = 6.5*(self.position.x/winSize.width/2);
            }
        }

    }
    
    if (d<=_globeRadius && !_submerged){
        speedModifier = 1.0;
        [self.parentGenerator.submergedAliens addObject:self];
        _submerged = YES;
    }else if(d>_globeRadius && _submerged){
        speedModifier = -4.0;
        _submerged = NO;
        [self performSelector:@selector(addToGarbage) withObject:nil afterDelay:2.0];
        
    }
    
    if (d < _globeRadius*.03) {
        NSLog(@"You Lost");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerLostNotification" object:nil];
    }
    
    
}

-(void)addToGarbage{
    [self.parentGenerator.aliensToRemove addObject:self];
}


@end
