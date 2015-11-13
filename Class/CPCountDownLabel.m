//
//  CPCountDownLabel.m
//  CPCountDownLabel
//
//  Created by Parsifal on 15/11/9.
//  Copyright © 2015年 Parsifal. All rights reserved.
//

#import "CPCountDownLabel.h"

@interface CPCountDownLabel()
@property (assign, nonatomic) NSTimeInterval totalTime;
@property (assign, nonatomic) NSTimeInterval remainingTime;
@property (strong, nonatomic) NSTimer *timer;
@property (copy, nonatomic) kCountDownCompletionBlock completionBlock;
@end

@implementation CPCountDownLabel

#pragma mark - Life Cycle methods
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.textAlignment = NSTextAlignmentCenter;
}

- (void)dealloc
{
    if (!_timer) {
        [_timer invalidate];
    }
}

#pragma mark - Util methods
- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime
{
    [self.timer invalidate];
    self.totalTime = totalTime;
    self.remainingTime = totalTime;
    self.text = @(totalTime).stringValue;
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
    [self.timer fire];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
    if (self.completionBlock) {
        self.completionBlock(self.remainingTime);
    }
}

- (void)countDown
{
    self.text = [self displayTimeForTimeInterval:self.remainingTime];
    self.remainingTime--;
    if (self.remainingTime<=0) {
        self.remainingTime = 0;
        [self stop];
    }
}

- (NSString *)displayTimeForTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *timeString = @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [self formatterForStyle:self.style];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    timeString = [formatter stringFromDate:date];
    return timeString;
}

- (NSDateFormatter *)formatterForStyle:(kCountDownStyle)style
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    switch (style) {
        case kCountDownCN:
            [formatter setDateFormat:@"HH时mm分ss秒"];
            break;
        default:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
    }
    
    return formatter;
}

@end
