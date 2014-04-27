//
//  MainScene.h
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright Joshua Scorca 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface MainScene : CCScene

// -----------------------------------------------------------------------

@property (nonatomic, strong) CCLabelTTF *scoreLabel;

+ (MainScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end