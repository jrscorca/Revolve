//
//  RotationTest.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import "RotationTest.h"

@implementation RotationTest

-(id) init
{
    if( (self=[super init]))
    {
        CGSize s = [[CCDirector sharedDirector] viewSize];
        
        star = [CCSprite spriteWithImageNamed:@"Icon.png"];
        planet = [CCSprite spriteWithImageNamed:@"Icon.png"];
        
        [self addChild: star];
        [self addChild:planet];
        
        star.position = ccp(s.width / 2.0f, s.height / 2.0f);
        planet.position = ccpAdd(star.position, ccp(100.0f, 0.0f));
        
        star.scale = 0.5f;
        planet.scale = 0.35f;
        
        dist_star_planet = ccpDistance(planet.position, star.position);
        
        relative_angle_star_planet = 0.0f;
        relative_angle_planet_satellite = 0.0f;
        
    }
    return self;
}

-(void) update:(CCTime)delta
{

    
    relative_angle_star_planet += 0.01f; // rads
    relative_angle_planet_satellite -= 0.01f;
    
    planet.position = ccpAdd(star.position, ccp(dist_star_planet * sinf(relative_angle_star_planet), dist_star_planet * cosf(relative_angle_star_planet)));

}

@end