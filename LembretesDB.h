//
//  LembretesDB.h
//  noteme
//
//  Created by ios on 14/02/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LembretesDB : NSObject

+ (LembretesDB *)sharedInstance;
- (NSManagedObjectContext *)context;
-(void)persistDefaultCategorias;
-(void)persistDefaultLembretes;


@end
