//
//  SpaceDweller.h
//  GameJame
//
//  Created by Joshua Scorca on 6/19/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpaceDwellerGenerator.h"

@interface SpaceDweller : CCSprite {
    float _inSpeedModifier;
    float _outSpeedModifier;
    float _globeRadius;
    BOOL _submerged;
    float _initialOutSpeedModifier;
    float _initialInSpeedModifier;
    BOOL _inVacuum;
    float _vacuumTimer;
    BOOL _dead;
    
}

@property (nonatomic, weak) SpaceDwellerGenerator *parentGenerator;
@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, assign) float relative_rotation;
@property (nonatomic, assign) BOOL submerged;

-(void)updatePosition:(CCTime)delta;
-(void)updateSpeed:(CCTime)delta;
-(void)updateProperties:(CCTime)delta;
-(void)updatePlayer:(CCTime)delta;
-(BOOL)checkVacuum:(CCTime)delta;

@end
