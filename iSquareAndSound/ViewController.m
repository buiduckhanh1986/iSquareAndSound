//
//  ViewController.m
//  iSquareAndSound
//
//  Created by Bui Duc Khanh on 9/2/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;

@interface ViewController ()

@end

@implementation ViewController
{
    SystemSoundID sound;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // Dùng cho việc chạy âm thanh
    NSURL *urlSound = [[NSBundle mainBundle] URLForResource:@"sound" withExtension:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlSound, &sound);
    
    // Phần bài học vẽ khối vuông
    [self drawNestedSquares];
    
    [self performSelector:@selector(rotateAllSquares) withObject:nil afterDelay:2.0];
}

// Hàm vẽ các khối vuông
- (void) drawNestedSquares {
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat margin = 20;
    CGFloat recWidth = mainViewSize.width - margin * 2.0;
    
    CGPoint center = CGPointMake(mainViewSize.width * 0.5,
                                 mainViewSize.height * 0.5);
    
    for (int i = 0; i < 10; i++) {
        UIView* square = [self drawSquareByWidth: recWidth
                                       andRotate: (i % 2 != 0)
                                        atCenter: center];
        
        [self.view addSubview:square];
        
        recWidth = recWidth / sqrt(2);
    }
}


// Vẽ hình vuông theo tham số
- (UIView *) drawSquareByWidth: (CGFloat)w
                     andRotate: (BOOL)isRotate
                      atCenter:(CGPoint) center
{
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, w)];
    
    square.center = center;
    square.backgroundColor = isRotate ? [UIColor whiteColor] : [UIColor darkGrayColor];
    square.transform = isRotate ? CGAffineTransformMakeRotation(M_PI_4):CGAffineTransformIdentity;
    
    return square;
}


// Xoay các khối vuông
- (void) rotateAllSquares{
    // Chạy âm thanh cho vui
    AudioServicesPlayAlertSound(sound);
    
    // Rotate các khối vuông
    [UIView animateWithDuration:2.0 animations:^{
        for (int i = 0; i < self.view.subviews.count; i++)
        {
            ((UIView *)self.view.subviews[i]).transform = (i%2 == 0) ? CGAffineTransformMakeRotation(M_PI_4) : CGAffineTransformIdentity;
        }
    }];
}
@end
