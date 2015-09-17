//
//  DXSimplePhoto.m
//  Pods
//
//  Created by xiekw on 15/9/16.
//
//

#import "DXSimplePhoto.h"
#import "SDWebImageManager.h"

@interface DXSimplePhoto ()

@property (nonatomic, strong) UIImage *placeholder;

@end

@implementation DXSimplePhoto {
    NSString *_imageURL;
    id<SDWebImageOperation> _operation;
}

+ (instancetype)photoWithImageURL:(NSString *)imageURL {
    DXSimplePhoto *photo = [DXSimplePhoto new];
    photo->_imageURL = imageURL;
    photo->_placeholder = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageURL];

    return photo;
}

+ (NSArray *)photosWithImageURLs:(NSArray *)imageURLs {
    if (!imageURLs || imageURLs.count == 0) return nil;
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:imageURLs.count];
    for (NSString *imageURL in imageURLs) {
        DXSimplePhoto *simplePhoto = nil;
        if ([imageURL isKindOfClass:[NSString class]]) {
            simplePhoto = [DXSimplePhoto photoWithImageURL:imageURL];
        } else if ([imageURL isKindOfClass:[NSURL class]]) {
            NSURL *URL = (NSURL *)imageURL;
            simplePhoto = [DXSimplePhoto photoWithImageURL:URL.absoluteString];
        }
        [mArray addObject:simplePhoto];
    }
    
    return mArray;
}

- (UIImage *)placeholder {
    return _placeholder;
}

- (CGSize)expectLoadedImageSize {
    return _placeholder.size;
}

- (void)loadImageWithProgressBlock:(DXPhotoProgressBlock)progressBlock completionBlock:(DXPhotoCompletionBlock)completionBlock {
    __weak typeof(self) wself = self;
    SDWebImageCompletionWithFinishedBlock finishBlock = ^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        wself.placeholder = image;
        if (completionBlock) {
            completionBlock(wself, image);
        }
    };
    
    _operation = [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_imageURL] options:1 progress:nil completed:finishBlock];
}

- (void)cancelLoadImage {
    [_operation cancel];
    _operation = nil;
}

@end
