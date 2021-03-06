//
//  NSData+Compression.h
//  Sentry
//
//  Created by Daniel Griesser on 08/05/2017.
//  Copyright © 2017 Sentry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Compression)

- (NSData *_Nullable)gzippedWithCompressionLevel:(NSInteger)compressionLevel
                                           error:(NSError *_Nullable *_Nullable)error;

@end

NS_ASSUME_NONNULL_END
