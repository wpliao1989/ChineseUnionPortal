//
//  EventViewController.m
//  ChineseUnionPortal
//
//  Created by wpliao on 2014/5/27.
//  Copyright (c) 2014年 ucsd. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *subTitles;
@property (nonatomic, strong) NSArray *images;

@end

@implementation EventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.names = @[@"Beach Party", @"BBQ", @"Movie Night"];
    self.subTitles = @[@"Alchohol only", @"Juicy meat", @"XMen - Days of Future Past"];
    self.images = @[@"beach", @"bbq", @"xmen"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.names[indexPath.row];
    cell.detailTextLabel.text = self.subTitles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
