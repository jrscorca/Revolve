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

#define ROTATION_RATE_MODIFIER 50.0

// -----------------------------------------------------------------------
#pragma mark - MainScene
// -----------------------------------------------------------------------

@implementation MainScene
{
    CCSprite *_globe;
    CCSprite *_alien;
    CGPoint lastTouch;
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
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Add a sprite
    _globe = [CCSprite spriteWithImageNamed:@"Globe.png"];
    _globe.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    NSLog(@"%f, %f", _globe.position.x, _globe.position.y);
    [self addChild:_globe];
    
    
    // Add a sprite
    _alien = [CCSprite spriteWithImageNamed:@"Alien.png"];
    _alien.position  = ccp(100,100);
    NSLog(@"%f, %f", _alien.position.x, _alien.position.y);
    [self addChild:_alien];
    
    // Animate sprite with action
    //CCActionRotateBy* actionSpin = [CCActionRotateBy actionWithDuration:1.5f angle:360];
    //[_sprite runAction:[CCActionRepeatForever actionWithAction:actionSpin]];
    
    // Create a back button
    /*
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
     */

    // done
	return self;
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
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}


-(void)update:(CCTime)delta{
    //[super update:delta];
    
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
    
    [self rotateWithXValue:touch];
    [self rotateWithYValue:touch];
    

    
    lastTouch = touchLoc;
    


}

-(void)rotateWithXValue:(UITouch*)touch{
        CGPoint touchLoc = [touch locationInNode:self];
    if (lastTouch.x - touchLoc.x < 0 && touchLoc.y >= self.contentSize.height/2) {
        //rotate clockwise
        _globe.rotation -= (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        NSLog(@"Rotate Clockwise");
    }else if (lastTouch.x - touchLoc.x >= 0 && touchLoc.y < self.contentSize.height/2) {
        //rotate clockwise
        NSLog(@"Rotate Clockwise");
        _globe.rotation += (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.x - touchLoc.x >= 0 && touchLoc.y >= self.contentSize.height/2) {
        //rotate counter-clockwise
        NSLog(@"Rotate Counter-Clockwise");
        _globe.rotation -= (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.x - touchLoc.x < 0 && touchLoc.y < self.contentSize.height/2) {
        //rotate counter-clockwise
        _globe.rotation += (lastTouch.x - touchLoc.x)/ROTATION_RATE_MODIFIER;
        NSLog(@"Rotate Counter-Clockwise");
    }
}

-(void)rotateWithYValue:(UITouch*)touch{
    CGPoint touchLoc = [touch locationInNode:self];
    if (lastTouch.y - touchLoc.y < 0 && touchLoc.x >= self.contentSize.width/2) {
        //rotate clockwise
        _globe.rotation += (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        NSLog(@"Rotate Clockwise");
    }else if (lastTouch.y - touchLoc.y >= 0 && touchLoc.x < self.contentSize.width/2) {
        //rotate clockwise
        NSLog(@"Rotate Clockwise");
        _globe.rotation -= (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.y - touchLoc.y >= 0 && touchLoc.x >= self.contentSize.width/2) {
        //rotate clockwise
        NSLog(@"Rotate Clockwise");
        _globe.rotation += (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
    }else if (lastTouch.y - touchLoc.y < 0 && touchLoc.x < self.contentSize.width/2) {
        //rotate counter-clockwise
        _globe.rotation -= (lastTouch.y - touchLoc.y)/ROTATION_RATE_MODIFIER;
        NSLog(@"Rotate Counter-Clockwise");
    }
    
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
