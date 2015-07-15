//
//  NSDate+BIAttributedString.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 7/15/15.
//  Copyright © 2015 Bogdan Iusco. All rights reserved.
//

#import "NSDate+BIAttributedString.h"

@implementation NSDate (BIAttributedString)

#pragma mark - Calendar components default format

- (nonnull NSAttributedString *)yearStringWithAttributes:(NSDictionary * __nonnull)attributes {
    return [self yearStringWithAttributes:attributes format:@"yyyy"];
}

- (nonnull NSAttributedString *)monthStringWithAttributes:(NSDictionary * __nonnull)attributes {
    return [self monthStringWithAttributes:attributes format:@"MMMM"];
}

- (nonnull NSAttributedString *)dayStringWithAttributes:(NSDictionary * __nonnull)attributes {
    return [self dayStringWithAttributes:attributes format:@"d"];
}

- (nonnull NSAttributedString *)hourStringWithAttributes:(NSDictionary * __nonnull)attributes {
    return [self hourStringWithAttributes:attributes format:@"h:mm"];
}

#pragma mark - Calendar components custom format

- (nonnull NSAttributedString *)yearStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format {
    return [self calendarComponentsWithAttributes:attributes format:format];
}

- (nonnull NSAttributedString *)monthStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format {
    return [self calendarComponentsWithAttributes:attributes format:format];
}

- (nonnull NSAttributedString *)dayStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format {
    return [self calendarComponentsWithAttributes:attributes format:format];
}

- (nonnull NSAttributedString *)hourStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format {
    return [self calendarComponentsWithAttributes:attributes format:format];
}

- (nonnull NSAttributedString *)calendarComponentsWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format {
    NSDateFormatter *dateFormatter = [self FM_dateFormatterWithFormat:format];
    NSMutableAttributedString *componentsString = [[NSMutableAttributedString alloc] initWithString:[dateFormatter stringFromDate:self] attributes:attributes];
    return componentsString;
}

#pragma mark - Suffixes

- (nonnull NSAttributedString *)daySuffixWithAttributes:(NSDictionary * __nonnull)attributes {
    NSAttributedString *attributedDaySuffix = [self FM_attributedString:[self FM_daySuffix] attributes:attributes];
    return attributedDaySuffix;
}

- (nonnull NSAttributedString *)hourSuffixWithAttributes:(NSDictionary * __nonnull)attributes {
    NSDateFormatter *dateFormatter = [self FM_dateFormatterWithFormat:@"a"];
    NSString *hourSuffix = [dateFormatter stringFromDate:self];
    NSAttributedString *attributedHourSuffix = [self FM_attributedString:hourSuffix attributes:attributes];
    return attributedHourSuffix;
}

#pragma mark - Private methods

- (nonnull NSDateFormatter *)FM_dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [NSLocale currentLocale];
        [dateFormatter setAMSymbol:@"am"];
        [dateFormatter setPMSymbol:@"pm"];
    });
    return dateFormatter;
}

- (nonnull NSString *)FM_daySuffix {
    NSInteger day = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
    switch (day) {
        case 1:
        case 21:
        case 31:
            return @"st";
            break;
        case 2:
        case 22:
            return @"nd";
            break;
        case 3:
        case 23:
            return @"rd";
            break;
        default:
            return @"th";
            break;
    }
}

- (nonnull NSAttributedString *)FM_attributedString:(NSString *)string attributes:(NSDictionary *)attributes {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string
                                                                                         attributes:attributes];
    return attributedString;
}

- (nonnull NSDateFormatter *)FM_dateFormatterWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [self FM_dateFormatter];
    NSString *dateFormat = [NSString stringWithFormat:format];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}


@end
