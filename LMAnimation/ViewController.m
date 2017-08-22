//
//  ViewController.m
//  LMAnimation
//
//  Created by 凯东源 on 2017/8/22.
//  Copyright © 2017年 LM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) NSArray *array;

@end


#define kUp @"up"
#define kDown @"down"
#define kLeft @"left"
#define kRight @"right"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [super viewDidLoad];
    
    NSDictionary *dic0 = @{kUp : @(4), kDown : @(5), kLeft : @(3), kRight : @(1)};
    NSDictionary *dic1 = @{kUp : @(4), kDown : @(5), kLeft : @(0), kRight : @(2)};
    NSDictionary *dic2 = @{kUp : @(4), kDown : @(5), kLeft : @(1), kRight : @(3)};
    NSDictionary *dic3 = @{kUp : @(4), kDown : @(5), kLeft : @(2), kRight : @(0)};
    NSDictionary *dic4 = @{kUp : @(5), kDown : @(5), kLeft : @(3), kRight : @(1)};
    NSDictionary *dic5 = @{kUp : @(4), kDown : @(4), kLeft : @(3), kRight : @(1)};
    
    _array = @[dic0, dic1, dic2, dic3, dic4, dic5];
    
    
    self.imageV.userInteractionEnabled = YES;
    
    //添加手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageV addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageV addGestureRecognizer:rightSwipe];
    
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.imageV addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.imageV addGestureRecognizer:downSwipe];
}


static int _currImageIndex = 0;
static int _lastImageIndex = 0;
- (void)swipe:(UISwipeGestureRecognizer *)swipe {
    
    //转场代码与转场动画必须得在同一个方法当中.
    NSString *dir = nil;
    
    NSDictionary *dict = _array[_currImageIndex];
    int nextImageIndex = 0;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        nextImageIndex = [dict[kRight] intValue];
        dir = @"fromRight";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        nextImageIndex = [dict[kLeft] intValue];
        dir = @"fromLeft";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        
        nextImageIndex = [dict[kDown] intValue];
        dir = @"fromTop";
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        
        nextImageIndex = [dict[kUp] intValue];
        dir = @"fromBottom";
    }
    NSString *imageName = [NSString stringWithFormat:@"%d",nextImageIndex];
    self.imageV.image = [UIImage imageNamed:imageName];
    _lastImageIndex = _currImageIndex;
    _currImageIndex = nextImageIndex;
    
    //添加动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
    anim.type = @"cube";
    //设置转场的方向
    anim.subtype = dir;
    
    anim.duration = 0.5;
    //动画从哪个点开始
    //    anim.startProgress = 0.2;
    //    anim.endProgress = 0.3;
    
    [self.imageV.layer addAnimation:anim forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
