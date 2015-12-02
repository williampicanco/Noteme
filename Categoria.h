//
//  Categoria.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lembrete;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * icone;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *relationship_lembrete_categoria;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addRelationship_lembrete_categoriaObject:(Lembrete *)value;
- (void)removeRelationship_lembrete_categoriaObject:(Lembrete *)value;
- (void)addRelationship_lembrete_categoria:(NSSet *)values;
- (void)removeRelationship_lembrete_categoria:(NSSet *)values;

@end
