//
//  ApsiOSHelper.h
//  ApsiOSHelper
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef ApsManager_h
#define ApsManager_h

#import <Foundation/Foundation.h>
#import <DTBiOSSDK/DTBiOSSDK.h>

@interface ApsManager : NSObject
+ (instancetype)sharedSingleton;

- (void)initSDK;
@end

@interface ApsBannerLoader : NSObject<DTBAdCallback>
+ (instancetype)sharedSingleton;
@end

@interface ApsInterstitialLoader : NSObject<DTBAdCallback>
+ (instancetype)sharedSingleton;
@end

@interface ApsRewardedVideoLoader : NSObject<DTBAdCallback>
+ (instancetype)sharedSingleton;
@end

@interface ApsMrecLoader : NSObject<DTBAdCallback>
+ (instancetype)sharedSingleton;

@end

@interface ApsiOSHelper : NSObject

@end
#endif /* UTNotificationsTools_h */
