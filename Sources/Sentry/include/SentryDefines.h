//
//  SentryDefines.h
//  Sentry
//
//  Created by Daniel Griesser on 02/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#ifdef __cplusplus
#define SENTRY_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define SENTRY_EXTERN        extern __attribute__((visibility ("default")))
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#define SENTRY_HAS_UIDEVICE 1
#else
#define SENTRY_HAS_UIDEVICE 0
#endif

#if SENTRY_HAS_UIDEVICE
#define SENTRY_HAS_UIKIT 1
#else
#define SENTRY_HAS_UIKIT 0
#endif

#ifdef LINKED_KSCRASH
#define KSCRASH 1
#else
#define KSCRASH 0
#endif

#define WITH_KSCRASH \
(__has_include(<KSCrash/KSCrash.h>) || KSCRASH)

#define SENTRY_NO_INIT \
- (instancetype)init NS_UNAVAILABLE; \
+ (instancetype)new NS_UNAVAILABLE;

@class SentryEvent, SentryNSURLRequest;

/**
 * Block used for returning after a request finished
 */
typedef void (^SentryRequestFinished)(NSError *_Nullable error);
/**
 * Block can be used to mutate event before its send
 */
typedef void (^SentryBeforeSerializeEvent)(SentryEvent *_Nonnull event);
/**
 * Block can be used to mutate NSURLRequest e.g.: add headers before request is executed
 */
typedef void (^SentryBeforeSendRequest)(SentryNSURLRequest *_Nonnull request);

/**
 * Loglevel
 */
typedef NS_ENUM(NSInteger, SentryLogLevel) {
    kSentryLogLevelNone = 1,
    kSentryLogLevelError,
    kSentryLogLevelDebug,
    kSentryLogLevelVerbose
};

/**
 * Level of severity
 */
typedef NS_ENUM(NSInteger, SentrySeverity) {
    kSentrySeverityFatal = 0,
    kSentrySeverityError = 1,
    kSentrySeverityWarning = 2,
    kSentrySeverityInfo = 3,
    kSentrySeverityDebug = 4,
};

/**
 * Static internal helper to convert enum to string
 */
static NSString *_Nonnull const SentrySeverityNames[] = {
        @"fatal",
        @"error",
        @"warning",
        @"info",
        @"debug",
};

