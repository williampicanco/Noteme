//
//  LembretesCell.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "LembretesCell.h"

@implementation LembretesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnCheckClick:(id)sender {
}
@end
