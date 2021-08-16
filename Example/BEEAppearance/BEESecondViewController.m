//
//  BEESecondViewController.m
//  BEEAppearance_Example
//
//  Created by mac on 2021/8/16.
//  Copyright © 2021 liuxc123. All rights reserved.
//

#import "BEESecondViewController.h"
#import "BEEAppearance.h"

@interface BEESecondViewController ()

@end

@implementation BEESecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Second View";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorColor  = BEEAppearanceColor(@"backgroundColor");
    
}

@end