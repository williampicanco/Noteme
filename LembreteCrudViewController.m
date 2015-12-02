//
//  LembreteCrudViewController.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "LembreteCrudViewController.h"
#import "LembretesDB.h"
#import "Lembrete+Create.h"

@interface LembreteCrudViewController ()

@end

@implementation LembreteCrudViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.selectedLembrete)
    {
        self.txtLembrete.text = self.selectedLembrete.descricao;
        [self.dpData setDate:self.selectedLembrete.data];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (IBAction)btnSalvarClick:(id)sender {
    LembretesDB* lembreteDB = [LembretesDB sharedInstance];
    if (!self.selectedLembrete) {
        [Lembrete insertLembreteWithName:self.txtLembrete.text andData:self.dpData.date andCategoria:self.selectedCategoria inManagedObjectContext:lembreteDB.context];
    } else
    {//[Lembrete updateLembreteWithDescricao:self.txtLembrete.text andData:self.dpData.date andVisto:NO inManagedObjectContext:lembreteDB.context];
        self.selectedLembrete.descricao = self.txtLembrete.text;
        self.selectedLembrete.data = self.dpData.date;
        NSError*error;
        [[lembreteDB context]save:&error];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//
@end
