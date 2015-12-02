//
//  Categoria+Create.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Categoria.h"

@interface Categoria(Create)

+(Categoria*)insertCategoriaWithName:(NSString*)name andIcon:(NSString*)icon inManagedObjectContext:(NSManagedObjectContext*)context;
+ (NSArray *) allCategoriasInManagedObjectContext:(NSManagedObjectContext *)context;
+(Categoria *)getCategoriaWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;

@end
