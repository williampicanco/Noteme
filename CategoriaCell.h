//
//  CategoriaCell.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgCategoria;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoria;
@property (weak, nonatomic) IBOutlet UILabel *lblQtdeLembretes;

@end
