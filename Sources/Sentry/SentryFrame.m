//
//  SentryFrame.m
//  Sentry
//
//  Created by Daniel Griesser on 05/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/SentryFrame.h>

#else
#import "SentryFrame.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@implementation SentryFrame

- (instancetype)init {
    return [super init];
}

+ (instancetype)new {
    return [super new];
}

- (NSDictionary<NSString *, id> *)serialize {
    NSMutableDictionary *serializedData = [NSMutableDictionary new];

    [serializedData setValue:self.symbolAddress forKey:@"symbol_addr"];
    [serializedData setValue:self.fileName forKey:@"filename"];
    [serializedData setValue:self.function forKey:@"function"];
    [serializedData setValue:self.module forKey:@"module"];
    [serializedData setValue:self.lineNumber forKey:@"lineno"];
    [serializedData setValue:self.columnNumber forKey:@"colno"];
    [serializedData setValue:self.package forKey:@"package"];
    [serializedData setValue:self.imageAddress forKey:@"image_addr"];
    [serializedData setValue:self.instructionAddress forKey:@"instruction_addr"];
    [serializedData setValue:self.platform forKey:@"platform"];

    return serializedData;
}

@end

NS_ASSUME_NONNULL_END
