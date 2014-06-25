//
//  GreenAlien.m
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "GreenAlien.h"


@implementation GreenAlien{
    int _rotationValue;
}
-(id) init{
    if(self = [super initWithImageNamed:@"Alien.png"]){
        _inSpeedModifier = IN_SPEED_MODIFIER_GREEN;
        _outSpeedModifier = OUT_SPEED_MODIFIER_GREEN;
        int rand = arc4random() % 2;
        if(rand==0){
            _rotationValue = -1.0;
        }else{
            _rotationValue = 1.0;
        }
    }
    return self;
}

-(void)update:(CCTime)delta{
    CGSize winSize =  [[CCDirector sharedDirector] viewSize];
    [super update:delta];
    if(self.submerged){
    float radians = _rotationValue*(M_PI/180.0);
    self.anchorPoint = ccp(0.5f,0.5f);
    self.rotation += _rotationValue;
    //NSLog(@"%f", alien.rotation);
    
    float d = ccpDistance(self.position, ccp(winSize.width/2, winSize.height/2));
    
    self.relative_rotation+=radians;
    
    self.position = ccpAdd(ccp(winSize.width/2, winSize.height/2), ccp(d * sinf(self.relative_rotation), d * cosf(self.relative_rotation)));
    }
}
@end
