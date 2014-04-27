//
//  EndGameScene.h
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface EndGameScene : CCScene {
    
}

@property (nonatomic, strong) CCLabelTTF *scoreLabel;

+ (EndGameScene *)sceneWithScore:(int)score;
- (id)init;

@end
