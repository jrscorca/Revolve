//
//  EndGameScene.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright 2014 Joshua Scorca. All rights reserved.
//

#import "EndGameScene.h"
#import "MainScene.h"

@implementation EndGameScene

+ (EndGameScene *)sceneWithScore:(int)score
{
    return [[self alloc] initWithScore:score];
}
-(id)initWithScore:(int)currentScore{
    self = [super init];
    if (!self) return (nil);
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Retry ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",currentScore]];
    
    _scoreLabel = [[CCLabelTTF alloc] initWithAttributedString:aString];
    _scoreLabel.fontSize = 40;
    _scoreLabel.positionType = CCPositionTypeNormalized;
    _scoreLabel.position = ccp(0.25f, 0.5f);
    [self addChild:_scoreLabel];
    
    int score = [[NSUserDefaults standardUserDefaults] integerForKey:@"scoreCount"];
    
    CCLabelTTF *highScoreLabel = [[CCLabelTTF alloc] initWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Verdana-Bold" fontSize:40];
    highScoreLabel.positionType = CCPositionTypeNormalized;
    highScoreLabel.position = ccp(0.75f, 0.5f);
    [self addChild:highScoreLabel];
    
    
    CCLabelTTF *label = [[CCLabelTTF alloc] initWithString:@"SCORE" fontName:@"Helvetica" fontSize:46];
    label.positionType = CCPositionTypeNormalized;
    label.position = ccp(0.25f, 0.55f);
    [self addChild:label];
    
    CCLabelTTF *label2 = [[CCLabelTTF alloc] initWithString:@"HIGH SCORE" fontName:@"Helvetica" fontSize:46];
    label2.positionType = CCPositionTypeNormalized;
    label2.position = ccp(0.75f, 0.55f);
    [self addChild:label2];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return self;
}

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MainScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

@end
