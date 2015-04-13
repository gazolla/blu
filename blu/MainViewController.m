//
//  MainViewController.m
//  blu
//
//  Created by Sebastiao Gazolla Costa Junior on 12/04/15.
//  Copyright (c) 2015 Sebastiao Gazolla Costa Junior. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connection:) name:@"connection" object:nil];
    
    self.blunoManager = [DFBlunoManager sharedInstance];
    self.blunoManager.delegate = self;
    self.aryDevices = [[NSMutableArray alloc] init];
    
    [self createButton];
    [self createSwitches];
    
}

-(void) createSwitches{
    
    for (int i = 1; i<5; i++) {
        UILabel *lblLed = [[UILabel alloc] initWithFrame:CGRectMake(50, 125+(50*i), 50, 50)];
        lblLed.text = [@"LED " stringByAppendingString:[NSString stringWithFormat:@"%d", i]];
        [self.view addSubview:lblLed];
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110, 135+(50*i), 0, 0)];
        mySwitch.tag = i;
        [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:mySwitch];
    }
    
    
}

- (void)changeSwitch:(id)sender{
    
    UISwitch *st = (UISwitch *) sender;
    
    NSString *str = [@"led"stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)st.tag]];
    if([sender isOn]){
                    if (self.blunoDev.bReadyToWrite) { str = [str stringByAppendingString:@"off"]; }
    } else{
        if (self.blunoDev.bReadyToWrite) { str = [str stringByAppendingString:@"on"]; }
    }
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
    
}

-(void) createButton{
    self.btnConnection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btnConnection addTarget:self action:@selector(connect:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnConnection setTitle:@"Connect" forState:UIControlStateNormal];
    self.btnConnection.frame = CGRectMake(10.0, 100.0, 160.0, 40.0);
    [self.view addSubview:self.btnConnection];
}

- (IBAction)connect:(id)sender{
    [self.blunoManager scan];
}

-(void) connection:(NSNotification*) notification{
    DFBlunoDevice* device = [self.aryDevices objectAtIndex:0];
    if (self.blunoDev == nil) {
             self.blunoDev = device;
            [self.blunoManager connectToDevice:self.blunoDev];
    }  else if ([device isEqual:self.blunoDev]) {
        if (!self.blunoDev.bReadyToWrite) {
            [self.blunoManager connectToDevice:self.blunoDev];
        }
    } else {
        if (self.blunoDev.bReadyToWrite) {
            [self.blunoManager disconnectToDevice:self.blunoDev];
            self.blunoDev = nil;
        }
        [self.blunoManager connectToDevice:device];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- DFBlunoDelegate

-(void)bleDidUpdateState:(BOOL)bleSupported{
    if(bleSupported){
        [self.blunoManager scan];
    }
}

-(void)didDiscoverDevice:(DFBlunoDevice*)dev{
    BOOL bRepeat = NO;
    for (DFBlunoDevice* bleDevice in self.aryDevices){
        if ([bleDevice isEqual:dev]){
            bRepeat = YES;
            break;
        }
    }
    if (!bRepeat){
        [self.aryDevices addObject:dev];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connection" object:nil];
}

-(void)readyToCommunicate:(DFBlunoDevice*)dev{
    self.blunoDev = dev;
      [self.btnConnection setTitle:@"Connected" forState:UIControlStateNormal];
}


-(void)didDisconnectDevice:(DFBlunoDevice*)dev{
      [self.btnConnection setTitle:@"Connect" forState:UIControlStateNormal];
}


-(void)didWriteData:(DFBlunoDevice*)dev{
    
}


-(void)didReceiveData:(NSData*)data Device:(DFBlunoDevice*)dev{
    //self.lbReceivedMsg.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
