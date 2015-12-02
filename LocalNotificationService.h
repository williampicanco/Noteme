//
//  LocalNotificationService.h
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationService : NSObject

+(void)scheduleNotificationWithName:(NSString*)name atDate:(NSDate*)date;
    
@end
