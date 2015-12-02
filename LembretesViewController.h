//
//  LembreteViewController.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categoria.h"

@interface LembretesViewController : UITableViewController

@property (strong,nonatomic)Categoria* selectedCategoria;
@property (weak, nonatomic) IBOutlet UIButton *btnAdicionar;
- (IBAction)btnAdicionarClick:(id)sender;
-(void)updateVistoLembreteToLembrete:(id)sender;
@end
