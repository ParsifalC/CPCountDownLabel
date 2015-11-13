//
//  CPCountDownLabel.h
//  CPCountDownLabel
//
//  Created by Parsifal on 15/11/9.
//  Copyright © 2015年 Parsifal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^kCountDownCompletionBlock)(NSTimeInterval remainingTime);
typedef enum : NSUInteger {
    kCountDownDefault,
    kCountDownCN,
} kCountDownStyle;

@interface CPCountDownLabel : UILabel
@property (assign, nonatomic) kCountDownStyle style;

- (void)startCountDownWithTotalTime:(NSTimeInterval)totalTime;
- (void)stop;
- (void)setCompletionBlock:(kCountDownCompletionBlock)completionBlock;
@end
