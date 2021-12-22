//
//  HongBaoView.m
//  Lottie-Example
//
//  Created by xxx on 2021/9/9.
//  Copyright © 2021 Brandon Withrow. All rights reserved.
//

#import "HongBaoView.h"

@implementation HongBaoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)testClick:(id)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"点击命中" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"close" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }]];
    [[[[UIApplication sharedApplication]keyWindow]rootViewController] presentViewController:controller animated:YES completion:nil];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([[NSDate date] timeIntervalSinceReferenceDate] + 24*3600)];
        __weak UILabel *countLable = (UILabel *)[self viewWithTag:9999];
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSTimeInterval time = [newDate timeIntervalSinceDate:[NSDate date]];
                NSDate *displayDate = [NSDate dateWithTimeIntervalSince1970:time];
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"HH:mm:ss:S";
                NSString *dateStr = [formatter stringFromDate:displayDate];
                countLable.text = dateStr;
            }];
        } else {
            // Fallback on earlier versions
        }

    }
    return self;
}

- (void)dealloc
{
    NSLog(@"xxx");
}


@end
