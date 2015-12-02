//
//  Lembrete+Create.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "Lembrete+Create.h"
#import "Categoria+Create.h"


@implementation Lembrete(Create)

+ (Lembrete *)getLembreteWithName:(NSString *)descricao inManagedObjectContext:(NSManagedObjectContext *)context {
    
    Lembrete *lembrete = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lembrete"];
    request.predicate = [NSPredicate predicateWithFormat:@"descricao = %@", descricao];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"data" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *lembretes = [context executeFetchRequest:request error:&error];
    
    if (lembretes && [lembretes count]) {
        lembrete =lembretes[0];
    }
    
    return lembrete;
}

+ (Lembrete*)insertLembreteWithName:(NSString*)descricao andData:(NSDate*)data andCategoria:(Categoria*) categoria inManagedObjectContext:(NSManagedObjectContext*)context {
    
    Lembrete *lembrete = [Lembrete getLembreteWithName:descricao inManagedObjectContext:context];
    
    if (!lembrete) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lembrete"];
        request.predicate = [NSPredicate predicateWithFormat:@"descricao = %@", descricao];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"data" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *lembretes = [context executeFetchRequest:request error:&error];
        
        if (!lembretes || ([lembretes count] > 1)) {
            NSLog(@"[Lembrete+Create] Error: More than one lembrete found with same description. -  ( Erro description %@ )", [error description]);
        } else if (![lembretes count]) {
            
            Categoria *categoriaDB =[Categoria getCategoriaWithName:categoria.nome inManagedObjectContext:context];
            if(categoriaDB){
                
                lembrete = [NSEntityDescription insertNewObjectForEntityForName:@"Lembrete" inManagedObjectContext:context];
                lembrete.relationship_lembrete_categoria = categoria;
                lembrete.descricao = descricao;
                lembrete.data = data;
                
                NSError*error;
                [context save:&error];
                NSLog(@"[Lembrete+Create] Lembrete created with descricao %@", descricao);
            }
            else
            {
                NSLog(@"Categoria não encontrada");
            }
        } else {
            lembrete = [lembretes lastObject];
            NSLog(@"[Lembrete+Create] Lembrete already exists with descricao %@", descricao);
        }
    }
    return lembrete;
}

+ (NSArray *) allLembretesInManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Lembrete" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *lembretes = [context executeFetchRequest:fetchRequest error:&error];
    if (error){
        NSLog(@"Error querying: %@", error.localizedDescription);
    }
    return lembretes;
    
}

+ (NSArray *)getLembretesWithCategoriaNome:(NSString *)nome inManagedObjectContext:(NSManagedObjectContext *)context {
    
    NSMutableArray *lembretes;
    Categoria *categoria = [Categoria getCategoriaWithName:nome inManagedObjectContext:context];
    if(categoria){
        lembretes = [NSMutableArray arrayWithArray:[categoria.relationship_lembrete_categoria allObjects]];
    }
    else{
        NSLog(@"Cagtegoria não encontrada");
    }
    
    return lembretes;
    
}

+ (void) updateLembreteWithDescricao:(NSString*)descricao andData:(NSDate*)data andVisto:(NSNumber*)visto inManagedObjectContext:(NSManagedObjectContext*)context{
    
    Lembrete* lembrete;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lembrete"];
    request.predicate = [NSPredicate predicateWithFormat:@"descricao = %@", descricao];
    
    NSError *error = nil;
    NSArray *lembretes = [context executeFetchRequest:request error:&error];
    if ([lembretes count]) {
        lembrete = [context executeFetchRequest:request error:&error][0];
        
        [lembrete setDescricao:descricao];
        [lembrete setData:data];
        [lembrete setVisto:visto];
        
        NSError *saveError;
        
        if ([context hasChanges] && ![context save:&error]){
            NSLog(@"Saving changes to eventos failed: %@", saveError);
        } else {
            NSLog(@"Saving changes to eventos succesfully: %@", saveError);
        }
    };
    
    
}

@end
