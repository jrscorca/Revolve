//
//  Alien.h
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@class AlienGenerator;
@interface Alien : CCSprite

@property (nonatomic, assign) CGPoint velocity;
@property (nonatomic, weak) AlienGenerator *parentGenerator;
@property (nonatomic, assign) float relative_rotation;
@property (nonatomic, assign) BOOL submerged;

@end
