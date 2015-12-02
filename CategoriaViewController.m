//
//  CategoriaViewController.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "CategoriaViewController.h"
#import "Categoria+Create.h"
#import "LembretesDB.h"
#import "CategoriaCell.h"
#import "LembretesViewController.h"
#import "LembreteCrudViewController.h"

@interface CategoriaViewController ()

@property(strong,nonatomic)NSMutableArray *categorias;

@end

@implementation CategoriaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    LembretesDB* lembreteDB = [LembretesDB sharedInstance];
    self.categorias = [[Categoria allCategoriasInManagedObjectContext:lembreteDB.context] mutableCopy];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LembretesDB* lembreteDB = [LembretesDB sharedInstance];
    //[lembreteDB persistDefaultCategorias];
    //[lembreteDB persistDefaultLembretes];
    
    [self.categorias removeAllObjects];
    self.categorias = [[Categoria allCategoriasInManagedObjectContext:[lembreteDB context]] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.categorias count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *eventCellIdentifier = @"CellCategoria";
    
    CategoriaCell *cell = (CategoriaCell *)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:eventCellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (indexPath.row < [self.categorias count]){
        Categoria *categoria = [self.categorias objectAtIndex:indexPath.row];
        
        cell.lblCategoria.text = categoria.nome;
        cell.lblQtdeLembretes.text = [NSString stringWithFormat:@"%lu lembrete(s)",[categoria.relationship_lembrete_categoria count]];
        [cell.imgCategoria setImage:[UIImage imageNamed:categoria.icone]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        
    Categoria* selectedCategoria = [self.categorias objectAtIndex:[indexPath row]];
    
    if([selectedCategoria.relationship_lembrete_categoria count]>0)
    {
        [self performSegueWithIdentifier:@"CategoriaToLembrete" sender:indexPath];
    }
    else{
        [self performSegueWithIdentifier:@"CategoriaToCrudLembrete" sender:indexPath];
        
    }
}


//commitEditingStyle: forRowAtIndexPath


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqual:@"CategoriaToLembrete"]){
        
        LembretesViewController* controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Categoria* selectedCategoria = [self.categorias objectAtIndex:[indexPath row]];
        controller.selectedCategoria = selectedCategoria;
    } else if([segue.identifier isEqual:@"CategoriaToCrudLembrete"]){
        LembreteCrudViewController * controller = (LembreteCrudViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Categoria* selectedCategoria = [self.categorias objectAtIndex:[indexPath row]];
        controller.selectedCategoria = selectedCategoria;
    }
    
}


@end
