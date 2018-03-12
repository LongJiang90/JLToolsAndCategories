//
//  JLViewController.m
//  JLToolsAndCategories
//
//  Created by 983220205@qq.com on 03/09/2018.
//  Copyright (c) 2018 983220205@qq.com. All rights reserved.
//

#import "JLViewController.h"
#import "JLToolsAndCategories.h"

@interface JLViewController ()

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *phoneNum = @"15523550589";
    BOOL isMobile = [JLTools isMobileNumber:phoneNum];
    NSLog(@"%@ %@一个电话",phoneNum,isMobile==YES?@"是":@"不是");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
