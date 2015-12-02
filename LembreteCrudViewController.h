//
//  LembreteCrudViewController.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lembrete.h"

@interface LembreteCrudViewController : UITableViewController

@property (strong,nonatomic)Lembrete* selectedLembrete;
@property (strong,nonatomic)Categoria* selectedCategoria;

@property (weak, nonatomic) IBOutlet UITextField *txtLembrete;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpData;
@property (weak, nonatomic) IBOutlet UIButton *btnSalvar;
- (IBAction)btnSalvarClick:(id)sender;

@end
