//
//  NSDateBIAttributedStringTestCase.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 7/15/15.
//  Copyright © 2015 Bogdan Iusco. All rights reserved.
//

#import "NSDate+BIAttributedString.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface NSDateBIAttributedStringTestCase : XCTestCase

@property (nonatomic, strong) NSDictionary *calendarComponentsAttributes;
@property (nonatomic, strong) NSDictionary *suffixesAttributes;

@end

@implementation NSDateBIAttributedStringTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    
    UIFont *calendarComponentsFont = [UIFont fontWithName:@"Helvetica" size:20.0];
    UIFont *suffixesFont = [UIFont fontWithName:@"Helvetica" size:10.0];
    
    self.calendarComponentsAttributes = @{NSFontAttributeName : calendarComponentsFont,
                                          NSForegroundColorAttributeName : [UIColor blackColor]};
    self.suffixesAttributes = @{NSFontAttributeName : suffixesFont,
                                NSForegroundColorAttributeName : [UIColor blueColor],
                                NSBaselineOffsetAttributeName : @(10)};
}

- (void)tearDown {
    self.calendarComponentsAttributes = nil;
    self.suffixesAttributes = nil;
    [super tearDown];
}

#pragma mark - Tests

- (void)testYearStringWithAttributesAndDefaultFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testYearString = [date yearStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self BI_yearAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testYearString, attributedString, @"years are not equal");
    
}

- (void)testYearStringWithAttributesAndCustomFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testYearString = [date yearStringWithAttributes:self.calendarComponentsAttributes format:@"yy"];
    NSAttributedString *attributedString = [self BI_yearAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testYearString, attributedString, @"years are not equal");
}

- (void)testMonthStringWithAttributesAndDefaultFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testMonthString = [date monthStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self BI_monthAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testMonthString, attributedString, @"months are not equal");
}

- (void)testMonthStringWithAttributesAndCustomFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testMonthString = [date monthStringWithAttributes:self.calendarComponentsAttributes format:@"MMM"];
    NSAttributedString *attributedString = [self BI_monthAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testMonthString, attributedString, @"months are not equal");
}

- (void)testDayStringWithAttributesAndDefaultFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testDayString = [date dayStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self BI_dayAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testDayString, attributedString, @"days are not equal");
}

- (void)testDayStringWithAttributesAndCustomFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testDayString = [date dayStringWithAttributes:self.calendarComponentsAttributes format:@"EEE"];
    NSAttributedString *attributedString = [self BI_dayAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testDayString, attributedString, @"days are not equal");
}

- (void)testDaySuffixWithAttributes {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [self BI_fullDate];
    
    // test for 'th' suffixed day
    NSAttributedString *testDaySuffixString = [date daySuffixWithAttributes:self.suffixesAttributes];
    NSAttributedString *attributedString = [self BI_daySuperscriptAttributedString:@"th"];
    XCTAssertEqualObjects(testDaySuffixString, attributedString, @"day suffixes are not the same");
    
    // test for 'nd' suffixed day
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitCalendar fromDate:date];
    dateComponents.day = 22;
    date = [calendar dateFromComponents:dateComponents];
    testDaySuffixString = [date daySuffixWithAttributes:self.suffixesAttributes];
    attributedString = [self BI_daySuperscriptAttributedString:@"nd"];
    XCTAssertEqualObjects(testDaySuffixString, attributedString, @"day suffixes are not the same");
    
    // test for 'st' suffixed day
    dateComponents = [calendar components:NSCalendarUnitCalendar fromDate:date];
    dateComponents.day = 21;
    date = [calendar dateFromComponents:dateComponents];
    testDaySuffixString = [date daySuffixWithAttributes:self.suffixesAttributes];
    attributedString = [self BI_daySuperscriptAttributedString:@"st"];
    XCTAssertEqualObjects(testDaySuffixString, attributedString, @"day suffixes are not the same");
    
    // test for 'rd' suffixed day
    dateComponents = [calendar components:NSCalendarUnitCalendar fromDate:date];
    dateComponents.day = 23;
    date = [calendar dateFromComponents:dateComponents];
    testDaySuffixString = [date daySuffixWithAttributes:self.suffixesAttributes];
    attributedString = [self BI_daySuperscriptAttributedString:@"rd"];
    XCTAssertEqualObjects(testDaySuffixString, attributedString, @"day suffixes are not the same");
}

- (void)testHourStringWithAttributesAndDefaultFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testHourString = [date hourStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self BI_timeAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testHourString, attributedString, @"hours are not equal");
}

- (void)testHourStringWithAttributesAndCustomFormat {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testHourString = [date hourStringWithAttributes:self.calendarComponentsAttributes format:@"hh:mm"];
    NSAttributedString *attributedString = [self BI_timeAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testHourString, attributedString, @"hours are not equal");
}

- (void)testHourSuffixWithAttributes {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testHourSuffixString = [date hourSuffixWithAttributes:self.suffixesAttributes];
    NSAttributedString *attributedString = [self BI_timeSuperscriptAttributedString];
    XCTAssertEqualObjects(testHourSuffixString, attributedString, @"hour superscripts are not the same");
}

- (void)testCalendarComponentsWithAttributes {
    NSDate *date = [self BI_fullDate];
    NSAttributedString *testString = [date calendarComponentsWithAttributes:self.calendarComponentsAttributes format:@"yyyy '#' MMM '#' d"];
    NSAttributedString *attributedString = [self BI_calendarComponentsAttributedString];
    XCTAssertEqualObjects(testString, attributedString, @"components are not equal");
}

#pragma mark - Factory methods

- (NSUInteger)BI_defaultBaseFontSize {
    return 20.f;
}

- (NSUInteger)BI_defaultSuperscriptFontSize {
    return 10.f;
}

- (nonnull UIFont *)BI_defaultBaseFont {
    return [UIFont fontWithName:@"Helvetica" size:[self BI_defaultBaseFontSize]];
}

- (nonnull UIFont *)BI_defaultSuperscriptFont {
    return [UIFont fontWithName:@"Helvetica" size:[self BI_defaultSuperscriptFontSize]];
}

- (nonnull NSAttributedString *)BI_yearAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"2015" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_yearAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_monthAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"July" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_monthAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Jul" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_dayAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_dayAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Wed" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_daySuperscriptAttributedString:(NSString *)superscript {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultSuperscriptFont],
                                 NSForegroundColorAttributeName : [UIColor blueColor],
                                 NSBaselineOffsetAttributeName : @(10)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:superscript attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_timeAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"5:00" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_timeAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"05:00" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_timeSuperscriptAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultSuperscriptFont],
                                 NSForegroundColorAttributeName : [UIColor blueColor],
                                 NSBaselineOffsetAttributeName : @(10)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"pm" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_calendarComponentsAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"2015 # Jul # 15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)BI_spaceAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self BI_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@" " attributes:attributes];
    return attributedString;
}

- (nonnull NSDate *)BI_fullDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.year = 2015;
    dateComponents.month = 7;
    dateComponents.day = 15;
    dateComponents.hour = 17;
    dateComponents.minute = 0;
    return [calendar dateFromComponents:dateComponents];
}

@end
