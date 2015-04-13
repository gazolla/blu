//
//  MainViewController.h
//  blu
//
//  Created by Sebastiao Gazolla Costa Junior on 12/04/15.
//  Copyright (c) 2015 Sebastiao Gazolla Costa Junior. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFBlunoManager.h"

@interface MainViewController : UIViewController<DFBlunoDelegate>
@property(strong, nonatomic) DFBlunoManager* blunoManager;
@property(strong, nonatomic) DFBlunoDevice* blunoDev;
@property(strong, nonatomic) NSMutableArray* aryDevices;
@property(strong, nonatomic) UIButton *btnConnection;

@end
