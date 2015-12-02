//
//  Lembrete+Create.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "Lembrete.h"
#import "Categoria.h"

@interface Lembrete(Create)

+ (Lembrete*)insertLembreteWithName:(NSString*)descricao andData:(NSDate*)data andCategoria:(Categoria*) categoria inManagedObjectContext:(NSManagedObjectContext*)context;
+ (NSArray *) allLembretesInManagedObjectContext:(NSManagedObjectContext *)context;
+ (Lembrete *)getLembreteWithName:(NSString *)descricao inManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSArray *)getLembretesWithCategoriaNome:(NSString *)nome inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void) updateLembreteWithDescricao:(NSString*)descricao andData:(NSDate*)data andVisto:(NSNumber*)visto inManagedObjectContext:(NSManagedObjectContext*)context;

@end
