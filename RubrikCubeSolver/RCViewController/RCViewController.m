//
//  RCViewController.m
//  RubrikCubeSolver
//
//  Created by 刘文景 on 13-9-1.
//  Copyright (c) 2013年 刘文景. All rights reserved.
//

#import "RCViewController.h"
#import "RCCubeManager.h"
@interface RCViewController()
{
    UILabel *_fpsLabel;
}
@end
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
    
    //enable FPS display 
#ifdef DEBUG
    CGRect rect;
    _frameCounter = 0;
    rect.size.height = 40;
    rect.size.width = 40;
    rect.origin.x = self.view.frame.size.width-50;
    rect.origin.y = self.view.frame.size.height-50;
    _fpsLabel = [[UILabel alloc] initWithFrame:rect];
    _fpsLabel.backgroundColor = [UIColor clearColor];
    _fpsLabel.textAlignment = NSTextAlignmentCenter;
    _fpsLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_fpsLabel];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(_fpstimeout) userInfo:nil repeats:YES];
#endif
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupOpenGL];
    [_cubeManager setVisibility:YES];
    [_cubeManager setCubeRotationSpeed:1];
    // first time need to clear the screen
    _clearScreen = YES;
}

-(void)_fpstimeout
{
    //clear counter
    _fpsLabel.text = [NSString stringWithFormat:@"%.0f",_frameCounter*10.0f];
    _frameCounter = 0;
}
@end
