//
//  LembreteViewController.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/14/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "LembretesViewController.h"
#import "Lembrete+Create.h"
#import "LembretesDB.h"
#import "LembretesCell.h"
#import "LembreteCrudViewController.h"
#import "AppDelegate.h"


@interface LembretesViewController ()

@property(strong,nonatomic)NSMutableArray *lembretes;
@property(strong,nonatomic)Lembrete* selectedLembrete;
@end

@implementation LembretesViewController

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
    
    self.lembretes = [Lembrete getLembretesWithCategoriaNome:self.selectedCategoria.nome inManagedObjectContext:[lembreteDB context]];
    
    [self.tableView reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.lembretes = [LembreteDB sharedInstance];
    
    LembretesDB* lembreteDB = [LembretesDB sharedInstance];
    
    [self.lembretes removeAllObjects];
    self.lembretes = [[Lembrete getLembretesWithCategoriaNome:self.selectedCategoria.nome inManagedObjectContext:[lembreteDB context]] mutableCopy];
    
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
    return [self.lembretes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *eventCellIdentifier = @"CellLembrete";
    LembretesCell *cell = (LembretesCell *)[tableView dequeueReusableCellWithIdentifier:eventCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:eventCellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (indexPath.row < [self.lembretes count]){
        Lembrete *lembrete = [self.lembretes objectAtIndex:indexPath.row];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:lembrete.data];
        
        cell.lblData.text =  dateString;
        cell.lblLembrete.text = lembrete.descricao;
    
        NSString* imgName;
        if([lembrete.visto isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            imgName =@"checkbox-checked.png";
        }else{
            imgName =@"checkbox-unchecked.png";
        }
        
        [cell.btnCheck setTitle:@"" forState:UIControlStateNormal];
        [cell.btnCheck setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [cell.btnCheck addTarget:self action:@selector(updateVistoLembreteToLembrete:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnCheck.tag = [indexPath row];
    }
    return cell;
}

-(void)updateVistoLembreteToLembrete:(id)sender{

    UIButton * button = (UIButton *)sender;
    NSLog(@"%lu",button.tag);
    Lembrete* lembrete = [self.lembretes objectAtIndex:button.tag];
    if([lembrete.visto isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [lembrete setVisto: [NSNumber numberWithBool:NO]];
    }
    else{
        [lembrete setVisto: [NSNumber numberWithBool:YES]];
    }
    
    LembretesDB* lembreteDB = [LembretesDB sharedInstance];
    NSError *saveError;
    [[lembreteDB context] save:&saveError];
    //[Lembrete updateLembreteWithDescricao:lembrete.descricao andData:lembrete.data andVisto:lembrete.visto inManagedObjectContext:[lembreteDB context]];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"LembretesDoCrud"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Lembrete* selectedLembrete = [self.lembretes objectAtIndex:[indexPath row]];
        LembreteCrudViewController * controller = (LembreteCrudViewController *)segue.destinationViewController;
        controller.selectedLembrete = selectedLembrete;
        controller.selectedCategoria = self.selectedCategoria;
    } else if([segue.identifier isEqualToString:@"AdicionarLembrete"]) {
        LembreteCrudViewController * controller = (LembreteCrudViewController *)segue.destinationViewController;
        controller.selectedCategoria = self.selectedCategoria;
    }
}

//william
/*- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: ( NSIndexPath *) indexPath
{
    
}
*/
- (IBAction)btnAdicionarClick:(id)sender {
    [self performSegueWithIdentifier:@"AdicionarLembrete" sender:sender];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedLembrete = [self.lembretes objectAtIndex:[indexPath row]];
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Lembrete * lembreteRemover = [self.lembretes objectAtIndex:indexPath.row];
        [self.lembretes removeObjectAtIndex:indexPath.row];
        //core data.
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        [context deleteObject:lembreteRemover];
        
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    //save no fim.
    //[LembretesDB save];
}


@end
