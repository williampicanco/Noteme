//
//  Lembrete.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria;

@interface Lembrete : NSManagedObject

@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSNumber * visto;
@property (nonatomic, retain) Categoria *relationship_lembrete_categoria;

@end
