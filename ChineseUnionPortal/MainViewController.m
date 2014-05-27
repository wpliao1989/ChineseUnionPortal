//
//  MainViewController.m
//  ChineseUnionPortal
//
//  Created by wpliao on 2014/5/24.
//  Copyright (c) 2014年 ucsd. All rights reserved.
//

#import "MainViewController.h"
#import "CustomDataSource.h"
#import "MosaicLayout/Entities/MosaicData.h"
#import "MosaicLayout/Controllers/MosaicLayout.h"
#import "CALAgenda.h"

#define kDoubleColumnProbability 40
#define kColumnsiPadLandscape 5
#define kColumnsiPadPortrait 4
#define kColumnsiPhoneLandscape 3
#define kColumnsiPhonePortrait 2

@interface MainViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [(MosaicLayout *)self.collectionView.collectionViewLayout setDelegate:self];
    
    
    
//    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
//    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:1.0];
//
//    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
//    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
//    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
//    
//    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
//    
//    CAGradientLayer *headerLayer = [CAGradientLayer layer];
//    headerLayer.colors = colors;
//    headerLayer.locations = locations;
//    
//    [self.view.layer insertSublayer:headerLayer atIndex:0];
    
    // Create the colors
//    UIColor *darkOp =
//    [UIColor colorWithRed:0.62f green:0.4f blue:0.42f alpha:0.3];
//    UIColor *lightOp =
//    [UIColor colorWithRed:0.43f green:0.76f blue:0.07f alpha:0.3];
    
//    UIColor *darkOp =
//    [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:0.3];
//    UIColor *lightOp =
//    [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:0.3];
//    
//    // Create the gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    
//    // Set colors
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)lightOp.CGColor,
//                       (id)darkOp.CGColor,
//                       nil];
//    
//    // Set bounds
//    gradient.frame = self.view.bounds;
//    
//    // Add the gradient to the view
//    [self.view.layer insertSublayer:gradient atIndex:0];
    
    UIColor *background = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background2"]];
    self.view.backgroundColor = background;
}

#pragma mark - MosaicLayoutDelegate

-(float)collectionView:(UICollectionView *)collectionView relativeHeightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //  Base relative height for simple layout type. This is 1.0 (height equals to width)
    float retVal = 1.0;
    
    NSMutableArray *elements = [(CustomDataSource *)self.collectionView.dataSource elements];
    MosaicData *aMosaicModule = [elements objectAtIndex:indexPath.row];
    
    if (aMosaicModule.relativeHeight != 0){
        
        //  If the relative height was set before, return it
        retVal = aMosaicModule.relativeHeight;
        
    }else{
        
        BOOL isDoubleColumn = [self collectionView:collectionView isDoubleColumnAtIndexPath:indexPath];
        if (isDoubleColumn){
            //  Base relative height for double layout type. This is 0.75 (height equals to 75% width)
            retVal = 0.75;
        }
        
        /*  Relative height random modifier. The max height of relative height is 25% more than
         *  the base relative height */
        
        float extraRandomHeight = arc4random() % 25;
        retVal = retVal + (extraRandomHeight / 100);
        
        /*  Persist the relative height on MosaicData so the value will be the same every time
         *  the mosaic layout invalidates */
        
        aMosaicModule.relativeHeight = retVal;
    }
    
    return retVal;
}

-(BOOL)collectionView:(UICollectionView *)collectionView isDoubleColumnAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *elements = [(CustomDataSource *)self.collectionView.dataSource elements];
    MosaicData *aMosaicModule = [elements objectAtIndex:indexPath.row];
    
    if (aMosaicModule.layoutType == kMosaicLayoutTypeUndefined){
        
        /*  First layout. We have to decide if the MosaicData should be
         *  double column (if possible) or not. */
        
        NSUInteger random = arc4random() % 100;
        if (random < kDoubleColumnProbability){
            aMosaicModule.layoutType = kMosaicLayoutTypeDouble;
        }else{
            aMosaicModule.layoutType = kMosaicLayoutTypeSingle;
        }
    }
    
    BOOL retVal = aMosaicModule.layoutType == kMosaicLayoutTypeDouble;
    
    return retVal;
    
}

-(NSUInteger)numberOfColumnsInCollectionView:(UICollectionView *)collectionView{
    
    UIInterfaceOrientation anOrientation = self.interfaceOrientation;
    
    //  Set the quantity of columns according of the device and interface orientation
    NSUInteger retVal = 0;
    if (UIInterfaceOrientationIsLandscape(anOrientation)){
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            retVal = kColumnsiPadLandscape;
        }else{
            retVal = kColumnsiPhoneLandscape;
        }
        
    }else{
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            retVal = kColumnsiPadPortrait;
        }else{
            retVal = kColumnsiPhonePortrait;
        }
    }
    
    return retVal;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Did select item:%@", indexPath);
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"eventSegue" sender:self];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"storeSegue" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"calendarSegue" sender:self];
            break;
            
        case 3:
            [self performSegueWithIdentifier:@"soccerSegue" sender:self];
            break;
        
        case 4:
            [self performSegueWithIdentifier:@"basketballSegue" sender:self];
            break;
        
        case 5:
            [self performSegueWithIdentifier:@"contactSegue" sender:self];
            break;
            
        default:
            break;
    }
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
