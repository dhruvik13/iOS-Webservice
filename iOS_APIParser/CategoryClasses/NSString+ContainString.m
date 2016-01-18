//
//  NSString+ContainString.m
//  FastTicket
//
//  Created by Dhruvik Rao on 17/10/15.
//  Copyright © 2015 Sujav Group. All rights reserved.
//


#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000

@interface NSString (PSPDFModernizer)

// Added in iOS 8, retrofitted for iOS 7
- (BOOL)containsString:(NSString *)aString;

@end

#endif

#import <objc/runtime.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000

@implementation NSString (PSPDFModernizerCreator)

+ (void)load {
    @autoreleasepool {
        [self pspdf_modernizeSelector:NSSelectorFromString(@"containsString:") withSelector:@selector(pspdf_containsString:)];
    }
}

+ (void)pspdf_modernizeSelector:(SEL)originalSelector withSelector:(SEL)newSelector {
    if (![NSString instancesRespondToSelector:originalSelector]) {
        Method newMethod = class_getInstanceMethod(self, newSelector);
        class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    }
}

// containsString: has been added in iOS 8. We dynamically add this if we run on iOS 7.
- (BOOL)pspdf_containsString:(NSString *)aString {
    return [self rangeOfString:aString].location != NSNotFound;
}

@end

#endif