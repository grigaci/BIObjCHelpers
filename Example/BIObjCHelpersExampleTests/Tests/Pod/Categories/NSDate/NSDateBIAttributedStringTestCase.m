//
//  NSDateBIAttributedStringTestCase.m
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 7/15/15.
//  Copyright © 2015 Bogdan Iusco. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+BIAttributedString.h"

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
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testYearString = [date yearStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self FM_yearAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testYearString, attributedString, @"years are not equal");
    
}

- (void)testYearStringWithAttributesAndCustomFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testYearString = [date yearStringWithAttributes:self.calendarComponentsAttributes format:@"yy"];
    NSAttributedString *attributedString = [self FM_yearAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testYearString, attributedString, @"years are not equal");
}

- (void)testMonthStringWithAttributesAndDefaultFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testMonthString = [date monthStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self FM_monthAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testMonthString, attributedString, @"months are not equal");
}

- (void)testMonthStringWithAttributesAndCustomFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testMonthString = [date monthStringWithAttributes:self.calendarComponentsAttributes format:@"MMM"];
    NSAttributedString *attributedString = [self FM_monthAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testMonthString, attributedString, @"months are not equal");
}

- (void)testDayStringWithAttributesAndDefaultFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testDayString = [date dayStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self FM_dayAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testDayString, attributedString, @"days are not equal");
}

- (void)testDayStringWithAttributesAndCustomFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testDayString = [date dayStringWithAttributes:self.calendarComponentsAttributes format:@"EEE"];
    NSAttributedString *attributedString = [self FM_dayAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testDayString, attributedString, @"days are not equal");
}

- (void)testDaySuffixWithAttributes {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testDaySuffixString = [date daySuffixWithAttributes:self.suffixesAttributes];
    NSAttributedString *attributedString = [self FM_daySuperscriptAttributedString];
    XCTAssertEqualObjects(testDaySuffixString, attributedString, @"day suffixes are not the same");
}

- (void)testHourStringWithAttributesAndDefaultFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testHourString = [date hourStringWithAttributes:self.calendarComponentsAttributes];
    NSAttributedString *attributedString = [self FM_timeAttributedStringWithDefaultFormat];
    XCTAssertEqualObjects(testHourString, attributedString, @"hours are not equal");
}

- (void)testHourStringWithAttributesAndCustomFormat {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testHourString = [date hourStringWithAttributes:self.calendarComponentsAttributes format:@"hh:mm"];
    NSAttributedString *attributedString = [self FM_timeAttributedStringWithCustomFormat];
    XCTAssertEqualObjects(testHourString, attributedString, @"hours are not equal");
}

- (void)testHourSuffixWithAttributes {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testHourSuffixString = [date hourSuffixWithAttributes:self.suffixesAttributes];
    NSAttributedString *attributedString = [self FM_timeSuperscriptAttributedString];
    XCTAssertEqualObjects(testHourSuffixString, attributedString, @"hour superscripts are not the same");
}

- (void)testCalendarComponentsWithAttributes {
    NSDate *date = [self FM_fullDate];
    NSAttributedString *testString = [date calendarComponentsWithAttributes:self.calendarComponentsAttributes format:@"yyyy '#' MMM '#' d"];
    NSAttributedString *attributedString = [self FM_calendarComponentsAttributedString];
    XCTAssertEqualObjects(testString, attributedString, @"components are not equal");
}

#pragma mark - Factory methods

- (NSUInteger)FM_defaultBaseFontSize {
    return 20.f;
}

- (NSUInteger)FM_defaultSuperscriptFontSize {
    return 10.f;
}

- (nonnull UIFont *)FM_defaultBaseFont {
    return [UIFont fontWithName:@"Helvetica" size:[self FM_defaultBaseFontSize]];
}

- (nonnull UIFont *)FM_defaultSuperscriptFont {
    return [UIFont fontWithName:@"Helvetica" size:[self FM_defaultSuperscriptFontSize]];
}

- (nonnull NSAttributedString *)FM_yearAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"2015" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_yearAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_monthAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"July" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_monthAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Jul" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_dayAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_dayAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Wed" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_daySuperscriptAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultSuperscriptFont],
                                 NSForegroundColorAttributeName : [UIColor blueColor],
                                 NSBaselineOffsetAttributeName : @(10)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"th" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_timeAttributedStringWithDefaultFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"5:00" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_timeAttributedStringWithCustomFormat {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"05:00" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_timeSuperscriptAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultSuperscriptFont],
                                 NSForegroundColorAttributeName : [UIColor blueColor],
                                 NSBaselineOffsetAttributeName : @(10)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"pm" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_calendarComponentsAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"2015 # Jul # 15" attributes:attributes];
    return attributedString;
}

- (nonnull NSAttributedString *)FM_spaceAttributedString {
    NSDictionary *attributes = @{NSFontAttributeName : [self FM_defaultBaseFont],
                                 NSForegroundColorAttributeName : [UIColor blackColor]};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@" " attributes:attributes];
    return attributedString;
}

- (nonnull NSDate *)FM_fullDate {
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
