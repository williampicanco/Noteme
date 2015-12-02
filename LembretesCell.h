//
//  LembretesCell.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LembretesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblLembrete;
@property (weak, nonatomic) IBOutlet UILabel *lblData;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
- (IBAction)btnCheckClick:(id)sender;

@end
