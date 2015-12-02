//
//  LocalNotificationService.m
//  noteme
//
//  Created by Francisco Evaldo Tomaz Jr on 2/15/14.
//  Copyright (c) 2014 PowerRangers. All rights reserved.
//

#import "LocalNotificationService.h"

@implementation LocalNotificationService

+(void)scheduleNotificationWithName:(NSString*) name atDate:(NSDate*) date{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = name;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [UIApplication sharedApplication].applicationIconBadgeNumber +=1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
