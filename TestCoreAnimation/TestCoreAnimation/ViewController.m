//
//  ViewController.m
//  TestCoreAnimation
//
//  Created by ysj on 16/1/20.
//  Copyright © 2016年 Harry. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = [[UIColor grayColor] CGColor];
    layer.frame = CGRectMake(10, 10, 40, 40);
    
    layer.cornerRadius = 5;
    [self.view.layer addSublayer:layer];
    
    self.layer = layer;
    
//    [self testBasicAnimation];
//    [self testGroupAnimation];
    [self testKeyFrameAnimation];
}

- (void)testKeyFrameAnimation{
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrame.values = @[[NSValue valueWithCGPoint:self.layer.frame.origin],
                        [NSValue valueWithCGPoint:CGPointMake(260, 10)],
                        [NSValue valueWithCGPoint:CGPointMake(120, 300)],
                        [NSValue valueWithCGPoint:self.layer.frame.origin]];
    
    keyFrame.keyTimes = @[[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:0.2],
                          [NSNumber numberWithFloat:0.5],
                          [NSNumber numberWithFloat:1.0]];
    
    keyFrame.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    keyFrame.repeatCount = 10;
    keyFrame.autoreverses = NO;
    keyFrame.duration = 4;
//    keyFrame.calculationMode = kCAAnimationLinear;
    [self.layer addAnimation:keyFrame forKey:@"keyFrane"];
}

- (void)testGroupAnimation{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
    animation1.fromValue = [NSValue valueWithCGPoint:self.layer.position];
    CGPoint toPoint = self.layer.position;
    toPoint.x += 180;
    animation1.toValue = [NSValue valueWithCGPoint:toPoint];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation2.fromValue = [NSNumber numberWithFloat:0.0];
    animation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation3.fromValue = [NSNumber numberWithFloat:1.0];
    animation3.toValue = [NSNumber numberWithFloat:2.5];
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation4.fromValue = [NSNumber numberWithFloat:0];
    animation4.toValue = [NSNumber numberWithFloat:1.0];
    animation4.duration = 0.5;
    animation4.repeatCount = 10;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.autoreverses = YES;//完成动画后逆向重复
    group.duration = 3.0;
    group.animations = [NSArray arrayWithObjects:animation1, animation2,animation3, animation4, nil];
    // PS:动画结束以后，他会返回到自己原来的frame，如果不想到原来frame我们需要设定,默认为kCAFillModeRemoved，需配合removedOnCompletion一起使用
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.layer addAnimation:group forKey:@"group"];
}

- (void)testBasicAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.layer.position];
    CGPoint toPoint = self.layer.position;
    toPoint.x += 180;
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    animation.duration = 2;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.layer addAnimation:animation forKey:@"move"];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
