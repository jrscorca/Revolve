//
//  MainScene.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright Joshua Scorca 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "MainScene.h"
#import "IntroScene.h"
#import "Alien.h"
#import "SpaceDwellerGenerator.h"
#import "EndGameScene.h"

#define ROTATION_RATE_MODIFIER 15.0

// -----------------------------------------------------------------------
#pragma mark - MainScene
// -----------------------------------------------------------------------

@implementation MainScene
{
    CCSprite *_heart;
    CCSprite *_heart2;
    CCSprite *_globe;
    CCSprite *_alien;
    CGPoint lastTouch;
    SpaceDwellerGenerator *spaceDwellerGenerator;
    float _rotationValue;
    int score;
    BOOL waitForStart;
    CCLabelTTF *tapToPlay;
    
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MainScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{

    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    waitForStart = YES;
    spaceDwellerGenerator = [[SpaceDwellerGenerator alloc] init];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    
    // Add a sprite
    CCSprite *background = [CCSprite spriteWithImageNamed:@"TheFinalFrontier.png"];
    background.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    NSLog(@"%f, %f", background.position.x, _globe.position.y);
    [self addChild:background];
    
    // Add a sprite
    _globe = [CCSprite spriteWithImageNamed:@"Planet.png"];
    _globe.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    NSLog(@"%f, %f", _globe.position.x, _globe.position.y);
    [self addChild:_globe];
    
    CCSprite *gradient = [CCSprite spriteWithImageNamed:@"Gradient.png"];
    gradient.position  = ccp(self.contentSize.width/2,gradient.contentSize.height/2);
    [self addChild:gradient];
    
    CCSprite *FFFG = [CCSprite spriteWithImageNamed:@"FinalFrontierFG.png"];
    FFFG.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:FFFG];
    
    
    
    
    
    
    /*
    CCNodeColor *equator = [CCNodeColor nodeWithColor:[CCColor colorWithRed:255.0f green:0.2f blue:0.2f alpha:0.4f]];
    equator.positionType = CCPositionTypeNormalized;
    equator.position = ccp(0.08f, 0.5f);
    [equator setContentSize:CGSizeMake(_globe.contentSize.width*.9, 4)];
    [self addChild:equator];
    */
    _heart = [CCSprite spriteWithImageNamed:@"Heart.png"];
    _heart.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    NSLog(@"%f, %f", _heart.position.x, _heart.position.y);
    [self addChild:_heart];
    /*
    _heart2 = [CCSprite spriteWithImageNamed:@"Heart2.png"];
    _heart2.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    NSLog(@"%f, %f", _heart2.position.x, _heart2.position.y);
    [self addChild:_heart2];

    */
    // Animate sprite with action
    //CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    //[_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    
    
    
    
    
    tapToPlay = [[CCLabelTTF alloc] initWithString:@"ROTATE PLANET"  fontName:@"Helvetica" fontSize:50];
    tapToPlay.positionType = CCPositionTypeNormalized;
    tapToPlay.position = ccp(0.5f, 0.1f);
    [self addChild:tapToPlay];
    
    CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:1.0];
    CCActionEaseIn *ease = [CCActionEaseIn actionWithAction:fadeIn rate:1.8];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:1.0];
    CCActionEaseOut *aa = [CCActionEaseOut actionWithAction:fadeOut rate:1.8];
    CCActionSequence *seq = [CCActionSequence actionOne:ease two:aa];
    
    CCActionRepeatForever *repeat = [CCActionRepeatForever actionWithAction:seq];
    
    
    [tapToPlay runAction:repeat];
    
    score = 0;

    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",score]];
    
    _scoreLabel = [[CCLabelTTF alloc] initWithAttributedString:aString];
    _scoreLabel.fontSize = 40;
    _scoreLabel.positionType = CCPositionTypeNormalized;
    _scoreLabel.position = ccp(0.5f, 0.95f);

    [self addChild:_scoreLabel];

    // done
    
    
    
	return self;
}

-(void)updateScore{
    score++;
    _scoreLabel.string = [NSString stringWithFormat:@"%d",score];
}

-(void)playerLost{
    int S =[[NSUserDefaults standardUserDefaults] integerForKey:@"scoreCount"];
    if(score > S){
        [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"scoreCount"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[CCDirector sharedDirector] replaceScene:[EndGameScene sceneWithScore:score]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:0.8f]];
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScore) name:@"updateScoreNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerLost) name:@"playerLostNotification" object:nil];
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateScoreNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"playerLostNotification" object:nil];
}


-(void)update:(CCTime)delta{
    if(waitForStart)return;
    
     Alien * alien = [spaceDwellerGenerator update:delta];
    if(alien){
        [self addChild:alien];
    }
    [spaceDwellerGenerator rotateSubmergedAliens:_rotationValue];
    _rotationValue = 0;
    
   // [self animateHeart];
    
}

-(void)animateHeart{
    _heart.visible = !_heart.visible;
    _heart2.visible = !_heart2.visible;
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    /*
    // Log touch location
    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    
    // Move our sprite to touch location
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    [_sprite runAction:actionMove];
     */
    lastTouch = touchLoc;
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLoc = [touch locationInNode:self];
    if(touchLoc.x < 0){
        lastTouch = touchLoc;
        NSLog(@"First time move");
        return;
    }
    
    float rotationValueX = [self rotateWithXValue:touch];
    float rotationValueY = [self rotateWithYValue:touch];
    
    _rotationValue = rotationValueX+rotationValueY;

    
    lastTouch = touchLoc;
    
    waitForStart = NO;
    [tapToPlay removeFromParent];

}

-(float)rotateWithXValue:(UITouch*)touch{
        CGPoint touchLoc = [touch locationInNode:self];
    if (lastTouch.x - touchLoc.x < 0 && touchLoc.y >= self.contentSize.height/2) {
        _globe.rotation += -(lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        return -(lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.x - touchLoc.x >= 0 && touchLoc.y < self.contentSize.height/2) {
        _globe.rotation += (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        return (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.x - touchLoc.x >= 0 && touchLoc.y >= self.contentSize.height/2) {
        _globe.rotation += -(lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        return -(lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.x - touchLoc.x < 0 && touchLoc.y < self.contentSize.height/2) {
        _globe.rotation += (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        return (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }
    return 0;
}

-(float)rotateWithYValue:(UITouch*)touch{
    CGPoint touchLoc = [touch locationInNode:self];
    if (lastTouch.y - touchLoc.y < 0 && touchLoc.x >= self.contentSize.width/2) {
        _globe.rotation += (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        return (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.y - touchLoc.y >= 0 && touchLoc.x < self.contentSize.width/2) {
        _globe.rotation += -(lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        return -(lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.y - touchLoc.y >= 0 && touchLoc.x >= self.contentSize.width/2) {
        _globe.rotation += (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        return (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;;
    }else if (lastTouch.y - touchLoc.y < 0 && touchLoc.x < self.contentSize.width/2) {
        _globe.rotation += -(lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        return -(lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;;
    }
    return 0;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
