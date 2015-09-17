//
//  DXPhotoBrowser-DXSimplePhotoTests.m
//  DXPhotoBrowser-DXSimplePhotoTests
//
//  Created by kaiwei.xkw on 09/16/2015.
//  Copyright (c) 2015 kaiwei.xkw. All rights reserved.
//

@import XCTest;
#import <DXPhotoBrowser.h>
#import <DXSimplePhoto.h>

@interface Tests : XCTestCase

@end

@implementation Tests {
    NSArray *_simplePhotos;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSArray *imageURLs = @[@"http://1.png", @"http://2.png", [NSURL URLWithString:@"http://www.3.com/1.png"]];
    _simplePhotos = [DXSimplePhoto photosWithImageURLs:imageURLs];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTAssert(_simplePhotos.count == 3, @"count right");
    XCTAssert([[_simplePhotos valueForKey:@"imageURL"] count] == 3, @"count right");

}

@end

