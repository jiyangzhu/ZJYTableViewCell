//
//  ViewController.m
//  HelloWorld
//
//  Created by ZhuJiyang on 7/16/15.
//  Copyright (c) 2015 ZhuJiyang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView setSeparatorColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleForHeader = nil;
    switch (section) {
        case 0:
            titleForHeader = @"Default style";
            break;
        default:
            break;
    }
    return titleForHeader;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    ZJYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZJYTableViewCell alloc] initWithZJYStyle:ZJYTableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.title = @"Nothing";
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryNone;
            cell.isFirstCell = YES;
            break;
        case 1:
            cell.title = @"Remind text";
            cell.remindText = @"Warning!";
            cell.colorOfRemindText = [UIColor redColor];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            break;
        case 2:
            cell.title = @"Colored title and different left margin";
            cell.colorOfTitle = [UIColor greenColor];
            cell.leftMarginOfTitle = 0 * [[UIScreen mainScreen] scale];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            break;
        case 3:
            cell.title = @"Bigger title";
            cell.colorOfRemindText = [UIColor redColor];
            cell.fontOfTitle = [UIFont systemFontOfSize:15*[[UIScreen mainScreen] scale]];
            cell.accessoryTypeZJY = ZJYTableViewCellAccessoryDisclosureIndicator;
            cell.isLastCell = YES;
        default:
            break;
    }
    return cell;
}

@end
