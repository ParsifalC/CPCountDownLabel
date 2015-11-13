//
//  ViewController.m
//  CPCountDownLabel
//
//  Created by Parsifal on 15/11/9.
//  Copyright © 2015年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "CPCountDownLabel.h"

@interface ViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) CPCountDownLabel *countDownLabel;
@end

@implementation ViewController

#pragma mark - Life cycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demo";
    [self setupNavigationItems];
    [self setupSubviews];
}

#pragma mark - Initial methods
- (void)setupNavigationItems
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"样式"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(changeDisplayStyle:)];
}

- (void)setupSubviews
{
    CPCountDownLabel *countDownLabel = [[CPCountDownLabel alloc] initWithFrame:CGRectMake(0,
                                                                                          0,
                                                                                          self.view.bounds.size.width,
                                                                                          100)];
    countDownLabel.font = [UIFont boldSystemFontOfSize:20];
    countDownLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:countDownLabel];
    [countDownLabel startCountDownWithTotalTime:100];
    self.countDownLabel = countDownLabel;
    
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    resetBtn.frame = CGRectMake(0,
                                self.countDownLabel.frame.origin.y+self.countDownLabel.frame.size.height,
                                self.view.bounds.size.width,
                                40);
    [resetBtn setTitle:@"重新计时"
              forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor redColor]
                   forState:UIControlStateNormal];
    [resetBtn addTarget:self
                 action:@selector(resetTotalTime:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
}

#pragma mark - Action methods
- (void)resetTotalTime:(UIButton *)sender
{
    [self.countDownLabel startCountDownWithTotalTime:100];
}

- (void)changeDisplayStyle:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"样式"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"默认", @"中文", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.countDownLabel.style = kCountDownDefault;
    } else if (buttonIndex == 1) {
        self.countDownLabel.style = kCountDownCN;
    }
}
@end
