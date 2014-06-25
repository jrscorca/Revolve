//
//  AlienGenerator.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import "SpaceDwellerGenerator.h"
#import "Alien.h"
#import "RedAlien.h"
#import "PurpleAlien.h"
#import "BlackAlien.h"
#import "GreenAlien.h"

@implementation SpaceDwellerGenerator{
    CCTime timer;
    CGSize winSize;
    int scoreCount;
    CCTime rampUpTimer;
    int rateOfRed;
    int rateOfBlack;
    int rateOfGreen;
    int debugCount;
}

-(id)init{
    self = [super init];
    if(!self) return (nil);
    winSize =  [[CCDirector sharedDirector] viewSize];
    rateOfRed = 30;
    rateOfBlack = 30;
    rateOfGreen = 2;
    timer = 0;
    _spawnRate = .8;
    _allAliens = [[NSMutableArray alloc] init];
    _submergedAliens = [[NSMutableArray alloc] init];
    _aliensToRemove = [[NSMutableArray alloc] init];
    
    return self;
}

-(Alien*)update:(CCTime)delta{
    rampUpTimer+=delta;
    timer+= delta;
    [self removeAliens];
    if(timer >= _spawnRate){
        timer = 0;
        return [self spawnAlien];
    }
    
    if(rampUpTimer>10){
        debugCount++;
        if (rateOfRed <17) {
            _spawnRate = max(.01, _spawnRate-.01);
            rateOfRed = max(2, rateOfRed-1);
        }else if(rateOfBlack < 17){
            _spawnRate = max(.01, _spawnRate-.01);
            rateOfBlack = max(2, rateOfBlack-1);
        }else if(rateOfGreen < 17){
            _spawnRate = max(.01, _spawnRate-.01);
            rateOfGreen = max(2, rateOfGreen-1);
        }else{
            _spawnRate = max(.2, _spawnRate-.1);
            rateOfRed = max(14, rateOfRed-2);
        }

        rampUpTimer = 0;
        NSLog(@"%d", debugCount);
    }
    
    return nil;
}

-(void)removeAliens{
    
    for (Alien *alien in _aliensToRemove){
        [_submergedAliens removeObject:alien];
        [alien removeFromParent];
        scoreCount++;
        
    }
    [_aliensToRemove removeAllObjects];
}

-(Alien*)spawnAlien{
    Alien *alien;
    int randRed = arc4random() % rateOfRed;
    int randBlack = arc4random() % rateOfBlack;
    int randGreen = arc4random() % rateOfGreen;
    if(randRed%40 == 0){
        alien = [[RedAlien alloc] init];
    }else if(randBlack%40 == 0){
        alien = [[BlackAlien alloc] init];
    }else if(randGreen%40 == 0){
        alien = [[GreenAlien alloc] init];
    }else{
        alien = [[PurpleAlien alloc] init];
    }


    alien.parentGenerator = self;
    //use height? why not?
    int r = arc4random() % ((int)-((winSize.height-winSize.width)/2)+(int)(winSize.height));
    alien.position = ccp(r, winSize.height);

    //roation
    float distancex = fabsf((winSize.width)/2 - alien.position.x);
    float hyp = sqrtf(distancex*distancex + (winSize.height/2)*(winSize.height/2));
    float angle = asinf(distancex/hyp);
    
    //alien.rotation = 30;
    
    //alien.rotation += angle;
    float degrees = angle * (180/M_PI);
    
    if (alien.position.x >= winSize.width/2) {
        alien.rotation += (degrees);
    }else{
        alien.rotation -= (degrees);
    }
    
    float radians = alien.rotation*(M_PI/180.0);
    alien.relative_rotation = radians;
    
    [_allAliens addObject:alien];
    return alien;
}

-(void)rotateSubmergedAliens:(float)rotationValue{
    for (Alien *alien in _submergedAliens){
        if(!alien.submerged)continue;
        float radians = rotationValue*(M_PI/180.0);
        alien.anchorPoint = ccp(0.5f,0.5f);
        alien.rotation += rotationValue;
        //NSLog(@"%f", alien.rotation);
        
        float d = ccpDistance(alien.position, ccp(winSize.width/2, winSize.height/2));

        alien.relative_rotation+=radians;
        
        alien.position = ccpAdd(ccp(winSize.width/2, winSize.height/2), ccp(d * sinf(alien.relative_rotation), d * cosf(alien.relative_rotation)));
        
    }
    
    
    
    
}
/*
-(void)rotate{
    CGFloat x = cos(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.x)-rotationPoint_.x) - sin(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.x;
    CGFloat y = sin(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.x)-rotationPoint_.x) + cos(CC_DEGREES_TO_RADIANS(-angle_*t)) * ((startPosition_.y)-rotationPoint_.y) + rotationPoint_.y;
    
    [target_ setPosition:ccp(x, y)];
    [target_ setRotation: (startAngle_ + angle_ * t )];
    
}
*/
@end
