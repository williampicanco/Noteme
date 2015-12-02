//
//  Categoria+Create.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "Categoria+Create.h"

@implementation Categoria(Create)

+(Categoria *)getCategoriaWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context{
    
    Categoria *categoria = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Categoria"];
    request.predicate = [NSPredicate predicateWithFormat:@"nome = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *categorias = [context executeFetchRequest:request error:&error];
    
    if (categorias && [categorias count]) {
        categoria =categorias[0];
    }
    
    return categoria;
    
}

+(Categoria*)insertCategoriaWithName:(NSString*)name andIcon:(NSString*)icon inManagedObjectContext:(NSManagedObjectContext*)context{
    
    Categoria *categoria = [Categoria getCategoriaWithName:name inManagedObjectContext:context];
    
    if (!categoria) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Categoria"];
        request.predicate = [NSPredicate predicateWithFormat:@"nome = %@", name];
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nome" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *categorias = [context executeFetchRequest:request error:&error];
        
        if (!categorias || ([categorias count] > 1)) {
            NSLog(@"[Categoria+Create] Error: More than one categoria found with same name. -  ( Erro description %@ )", [error description]);
        } else if (![categorias count]) {
            
            categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categoria" inManagedObjectContext:context];
            categoria.nome = name;
            categoria.icone = icon;
            
            NSError*error;
            [context save:&error];
            NSLog(@"[Categoria+Create] Categoria created with name %@", name);
        } else {
            categoria = [categorias lastObject];
            NSLog(@"[Categoria+Create] Categoria already exists with name %@", name);
        }
    }
    return categoria;
}

+ (NSArray *) allCategoriasInManagedObjectContext:(NSManagedObjectContext *)context{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *categorias = [context executeFetchRequest:fetchRequest error:&error];
    if (error){
        NSLog(@"Error querying: %@", error.localizedDescription);
    }
    return categorias;
}

@end
