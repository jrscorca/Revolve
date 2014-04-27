//
//  AlienGenerator.h
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Alien;
@interface AlienGenerator : NSObject

@property (nonatomic, assign) float spawnRate;
@property (nonatomic, strong) NSMutableArray* allAliens;
@property (nonatomic, strong) NSMutableArray* submergedAliens;
@property (nonatomic, strong) NSMutableArray* aliensToRemove;

-(Alien*)update:(CCTime)delta;
-(void)rotateSubmergedAliens:(float)rotationValue;

@end
