//
//  CalendarViewController.m
//  ChineseUnionPortal
//
//  Created by wpliao on 2014/5/27.
//  Copyright (c) 2014年 ucsd. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarIOS7/CALAgenda.h"
#import "NSDate+Agenda.h"

@interface CalendarViewController ()

- (void)scrollToDate:(NSDate *)date;

@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendarScrollDirection = UICollectionViewScrollDirectionVertical;
    //self.agendaDelegate = self;
    NSDateComponents *components = [NSDateComponents new];
    components.month = 1;
    components.day = 1;
    components.year = 2014;
    NSDate *fromDate = [[NSDate gregorianCalendar] dateFromComponents:components];
    components.month = 12;
    components.day = 31;
    NSDate *toDate = [[NSDate gregorianCalendar] dateFromComponents:components];
    [self setFromDate:fromDate];
    [self setToDate:toDate];
    
    //self.agendaVc.events = [self fakeEvents];
    self.dayStyle = CALDayCollectionViewCellDayUIStyleIOS7;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self scrollToDate:[NSDate date]];
}

- (void)scrollToDate:(NSDate *)date {
    NSInteger numberOfMonth = [NSDate numberOfMonthFromDate:self.fromDate toDate:[NSDate date]];
    NSIndexPath *indexPathForCurrentMonth = [NSIndexPath indexPathForRow:0 inSection:numberOfMonth];
    [self.calendarCollectionView scrollToItemAtIndexPath:indexPathForCurrentMonth
                                        atScrollPosition:UICollectionViewScrollPositionBottom
                                                animated:NO];
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
