//
//  ViewController.m
//  Gesture
//
//  Created by kunren10 on 2014/03/20.
//  Copyright (c) 2014年 Hajime Maeda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imStarView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 背景に画像をセットする
    UIImage *image  = [UIImage imageNamed:@"bg01"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    // タッチ / キーイベント許可設定 YES
    self.imStarView.userInteractionEnabled = YES;
    // アニメーションの開始
//    [self animateStart:self.imStarView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// アニメーション回転開始（要：QuartzCore.framework）
- (void)animateStart:(UIImageView *)imageView {
	
	// アニメーション設定
	// (種類(Z軸回転))
	CABasicAnimation *ani =
    [CABasicAnimation animationWithKeyPath:
     @"transform.rotation.z"];
	// (変化値)
	ani.fromValue = [NSNumber numberWithDouble:0.0];
	ani.toValue   = [NSNumber numberWithDouble:2.0 * M_PI];
	
	// (アニメーション時間(秒))
	ani.duration = 2.0;
	
	// (繰返し回数)
	ani.repeatCount = HUGE_VALF;	// 無限
	// アニメーション開始
	[imageView.layer addAnimation:ani forKey:@"ANIM01"];
}

// パン時
- (IBAction)panImage:(UIPanGestureRecognizer *)sender {
    
    //NSLog(@"%s", __func__);
    // 対象の座標を取得
    CGPoint posNow = sender.view.center; // 中央位置の座標
    // ドラック移動量の取得
    CGPoint posMov = [sender translationInView:self.view];
    // 対象の移動
    sender.view.center = CGPointMake(posNow.x + posMov.x,
                                      posNow.y + posMov.y);
    // ドラッグの移動量をクリア
    [sender setTranslation:CGPointZero inView:self.view];
}

// ピンチ時
- (IBAction)PinchImage:(UIPinchGestureRecognizer *)sender {
    
    // 伸縮
    sender.view.transform =
        CGAffineTransformMakeScale(sender.scale, sender.scale);
    
}

// 回転時
- (IBAction)RotationImage:(UIRotationGestureRecognizer *)sender {
    
    // 回転
    sender.view.transform =
        CGAffineTransformMakeRotation(sender.rotation);
    
}

@end
