//
//  DXSimplePhoto.h
//  Pods
//
//  Created by xiekw on 15/9/16.
//
//

#import <Foundation/Foundation.h>
#import "DXPhoto.h"

@interface DXSimplePhoto : NSObject<DXPhoto>

@property (nonatomic, strong, readonly) NSString *imageURL;

+ (instancetype)photoWithImageURL:(NSString *)imageURL;

+ (NSArray *)photosWithImageURLs:(NSArray *)imageURLs;

@end
