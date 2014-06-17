//
//  HYViewController.m
//  iOS7Tutorial
//
//  Created by Fruit Lee on 14-6-17.
//  Copyright (c) 2014年 Fruit Lee. All rights reserved.
//

#import "HYViewController.h"

@interface HYViewController () <UICollisionBehaviorDelegate> {
    UICollisionBehavior* _collision;
}

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    UIView *barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    self.animator = [[UIDynamicAnimator alloc]
                     initWithReferenceView:self.view];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [self.animator addBehavior:self.gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    _collision.collisionDelegate = self;
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x + barrier.frame.size.width,
                                    barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier" fromPoint:barrier.frame.origin toPoint:rightEdge];
    [self.animator addBehavior:_collision];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
    
    UIView *view = (UIView*)item;
    view.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.3 animations:^{
        view.backgroundColor = [UIColor grayColor];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
