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
    
    
    // Add a sprite
    CCSprite *background = [CCSprite spriteWithImageNamed:@"TheFinalFrontier.png"];
    background.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:background];
    
    
    CCSprite *FFFG = [CCSprite spriteWithImageNamed:@"FinalFrontierFG.png"];
    FFFG.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:FFFG];

    
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Retry ]" fontName:@"Verdana-Bold" fontSize:46.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.5f, 0.25f); // Top Right of screen
    backButton.color = [[CCColor alloc] initWithCcColor3b:ccc3(200, 200, 200)];
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    
    CCLabelTTF *title = [[CCLabelTTF alloc] initWithString:@"Planet Destroyed" fontName:@"Helvetica" fontSize:66];
    title.color = [[CCColor alloc] initWithCcColor3b:ccc3(200, 200, 200)];
    title.positionType = CCPositionTypeNormalized;
    title.position = ccp(0.5f, 0.90f);
    [self addChild:title];
    
    
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
    label.color = [[CCColor alloc] initWithCcColor3b:ccc3(200, 200, 200)];
    label.position = ccp(0.25f, 0.55f);
    [self addChild:label];
    
    CCLabelTTF *label2 = [[CCLabelTTF alloc] initWithString:@"HIGH SCORE" fontName:@"Helvetica" fontSize:46];
    label2.positionType = CCPositionTypeNormalized;
    label2.color = [[CCColor alloc] initWithCcColor3b:ccc3(200, 200, 200)];
    label2.position = ccp(0.75f, 0.55f);
    [self addChild:label2];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return self;
}

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[MainScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:1.0f]];
}

@end
