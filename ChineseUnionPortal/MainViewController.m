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
