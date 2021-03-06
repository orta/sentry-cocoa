//
//  SentryStacktrace.m
//  Sentry
//
//  Created by Daniel Griesser on 05/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//


#if __has_include(<Sentry/Sentry.h>)

#import <Sentry/SentryStacktrace.h>
#import <Sentry/SentryFrame.h>
#import <Sentry/SentryLog.h>

#else
#import "SentryStacktrace.h"
#import "SentryFrame.h"
#import "SentryLog.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@implementation SentryStacktrace

- (instancetype)initWithFrames:(NSArray<SentryFrame *> *)frames
                     registers:(NSDictionary<NSString *, NSString *> *)registers {
    self = [super init];
    if (self) {
        self.registers = registers;
        self.frames = frames;
    }
    return self;
}

/// This function fixes duplicate frames and removes the first duplicate
/// https://github.com/kstenerud/KSCrash/blob/05cdc801cfc578d256f85de2e72ec7877cbe79f8/Source/KSCrash/Recording/Tools/KSStackCursor_MachineContext.c#L84
- (void)fixDuplicateFrames {
    if (self.frames.count < 2 || nil == self.registers) {
        return;
    }
    
    SentryFrame *lastFrame = self.frames.lastObject;
    SentryFrame *beforeLastFrame = [self.frames objectAtIndex:self.frames.count - 2];
 
    if ([lastFrame.symbolAddress isEqualToString:beforeLastFrame.symbolAddress] &&
        [self.registers[@"lr"] isEqualToString:beforeLastFrame.instructionAddress]) {
        NSMutableArray *copyFrames = self.frames.mutableCopy;
        [copyFrames removeObjectAtIndex:self.frames.count - 2];
        self.frames = copyFrames;
        [SentryLog logWithMessage:@"Found duplicate frame, removing one with link register" andLevel:kSentryLogLevelDebug];
    }
}

- (NSDictionary<NSString *, id> *)serialize {
    NSMutableDictionary *serializedData = [NSMutableDictionary new];

    NSMutableArray *frames = [NSMutableArray new];
    for (SentryFrame *frame in self.frames) {
        [frames addObject:[frame serialize]];
    }
    [serializedData setValue:frames forKey:@"frames"];

    // This is here because we wanted to be conform with the old json
    if (self.registers.count > 0) {
        [serializedData setValue:self.registers forKey:@"registers"];
    }
    return serializedData;
}

@end

NS_ASSUME_NONNULL_END
