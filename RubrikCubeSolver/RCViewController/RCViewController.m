//
//  RCViewController.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCViewController.h"
#import "RCCubeManager.h"
@implementation RCViewController
//@synthesize cubeManager;

+ (id)alloc
{
    //View Contrller Alloc
    RCViewController *viewController = [super alloc];
    
    // cubeManager alloc
    RCCubeManager *cubeManager = [RCCubeManager alloc];
    viewController.cubeManager = cubeManager;
    return viewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //init self
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    RCAssert(self, @"init error");
    
    //init cubeManager
    self.cubeManager = [self.cubeManager init];
    RCAssert(self.cubeManager, @"cubeManager init error");
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupOpenGL];
    [_cubeManager setVisibility:YES];
}
@end
