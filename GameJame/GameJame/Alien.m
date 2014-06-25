//
//  Alien.m
//  GameJame
//
//  Created by Joshua Scorca on 4/26/14.
//  Copyright (c) 2014 Joshua Scorca. All rights reserved.
//

#import "Alien.h"
#import "SpaceDwellerGenerator.h"

@implementation Alien{

}

-(id) init{
    if(self = [super initWithImageNamed:@"AlienBasic.png"]){
        NSLog(@"Use initWithImageNamed:");
    }
    return self;
}

-(id)initWithImageNamed:(NSString *)imageName{
    if(self = [super initWithImageNamed:imageName]){
    
    }
    return self;
}

-(void)update:(CCTime)delta{
    [super update:delta];
}

-(void)updatePlayer:(CCTime)delta{
    [super updatePlayer:delta];
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CGPoint destinationPosition = ccp(winSize.width/2, winSize.height/2);
    float distance = sqrtf((self.position.x - destinationPosition.x)*(self.position.x - destinationPosition.x) + (self.position.y - destinationPosition.y)*(self.position.y - destinationPosition.y) );
    if (distance < _globeRadius*.03) {
        //NSLog(@"You Lost");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"playerLostNotification" object:nil];
    }
}

@end