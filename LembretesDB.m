//
//  LembretesDB.m
//  noteme
//
//  Created by ios on 14/02/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "LembretesDB.h"
#import "Categoria+Create.h"
#import "Lembrete+Create.h"
#import "CoreData/CoreData.h"

@interface LembretesDB ()

@property (strong, nonatomic, readonly) NSManagedObjectModel *model;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

@end

@implementation LembretesDB

@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize context = _context;


// singleton
static LembretesDB *instance;

+ (LembretesDB *) sharedInstance {
    if (instance == nil){
        instance = [[LembretesDB alloc]init];
    }
    return instance;
}


- (NSManagedObjectModel *)model {
    if (_model == nil){
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return _model;
}

- (NSPersistentStoreCoordinator *)coordinator {
    if (_coordinator == nil){
        _coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.model];
        
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        url = [url URLByAppendingPathComponent:@"noteme.sqlite"];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:nil];
    }
    return _coordinator;
}

- (NSManagedObjectContext *)context {
    if (_context == nil){
        _context = [[NSManagedObjectContext alloc] init];
        [_context setPersistentStoreCoordinator:[self coordinator]];
    }
    return _context;
}

-(void)persistDefaultCategorias{
    [Categoria insertCategoriaWithName:@"Compras" andIcon:@"icon-buy.png" inManagedObjectContext:[self context]];
    [Categoria insertCategoriaWithName:@"Compromissos" andIcon:@"icon-compromise.png" inManagedObjectContext:[self context]];
    [Categoria insertCategoriaWithName:@"Eventos" andIcon:@"icon-event.png" inManagedObjectContext:[self context]];
    [Categoria insertCategoriaWithName:@"Pagamentos" andIcon:@"icon-payment.png" inManagedObjectContext:[self context]];
    [Categoria insertCategoriaWithName:@"Outros" andIcon:@"icon-other.png" inManagedObjectContext:[self context]];
}

-(void)persistDefaultLembretes{
    NSDate* date = [NSDate date];
    Categoria * compras = [Categoria getCategoriaWithName:@"Compras" inManagedObjectContext:[self context]];
    Categoria * compromissos = [Categoria getCategoriaWithName:@"Compromissos" inManagedObjectContext:[self context]];
    Categoria * eventos = [Categoria getCategoriaWithName:@"Eventos" inManagedObjectContext:[self context]];
    Categoria * pagamentos = [Categoria getCategoriaWithName:@"Pagamentos" inManagedObjectContext:[self context]];
    Categoria * outros = [Categoria getCategoriaWithName:@"Outros" inManagedObjectContext:[self context]];
  
    [Lembrete insertLembreteWithName:@"Ir a bodega do 'Seu Chiquin'" andData:date andCategoria:compras inManagedObjectContext:[self context]];
    [Lembrete insertLembreteWithName:@"Frutas e Verduras" andData:date andCategoria:compras inManagedObjectContext:[self context]];
    [Lembrete insertLembreteWithName:@"Cerveja e Carne para Churrasco" andData:date andCategoria:compras inManagedObjectContext:[self context]];
    
    [Lembrete insertLembreteWithName:@"Encontrar as piriguetes no Butuquim." andData:date andCategoria:compromissos inManagedObjectContext:[self context]];
   
}

@end
