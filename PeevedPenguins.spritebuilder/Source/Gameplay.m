//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Tevin Harris on 11/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay
{
    CCPhysicsNode * _physicsNode;
    CCNode * _catapultArm;
    CCNode * _levelNode;
    CCNode * _contentNode;
}

-(void)retry {
    //reload this level
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

     //is called whenn CCB file has completed loading
- (void)didLoadFromCCB
{
    //tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    //adding a level
    CCScene * level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
}

//called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [self launchPenguin];
}

- (void)launchPenguin {
    //loads  the Penguin.CCB we have set up in Spritebuilder
    CCNode * penguin = [CCBReader load:@"Penguin"];
    
    //ensure followed object is in visible area when starting
    self.position = ccp(0,0);
    CCActionFollow * follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
    
    
    
    //postion the penguin at the bowl of the catapult
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    //add the penguin to the physicsNode of this scene (because it has physics enabled
    [_physicsNode addChild:penguin];
    
    //manually add and apply a force to launch penguin
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
        
        
    
}


@end
