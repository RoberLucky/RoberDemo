//
//  ApsiOSHelper.m
//  ApsiOSHelper
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ApsiOSHelper.h"
#import "sys/utsname.h"
#import <DTBiOSSDK/DTBiOSSDK.h>
#import "MoPubManager.h"

#ifdef __cplusplus
extern "C" {
#endif
    // life cycle management
    void UnityPause(int pause);
    void UnitySendMessage(const char* obj, const char* method, const char* msg);
#ifdef __cplusplus
}
#endif

struct utsname systemInfo;

@implementation ApsManager

NSString * const AppID = @"9e93daa6-2583-4b44-9eda-159e5bf06569";
NSString * const RewardID = @"4f79c913-7b3d-4e5b-b195-afefa743b9c2";
NSString * const InterstitialID = @"66c5413c-3263-4145-9359-4b27c1ff0ffc";
NSString * const BannerID = @"649db76b-6c84-4b0a-88fc-1f18e023b782";
NSString * const MrecID = @"aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa";


+ (instancetype)sharedSingleton {
    static ApsManager *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)initSDK
{
    [[DTBAds sharedInstance] setAppKey: AppID];
    
    if ([[MoPub sharedInstance] isGDPRApplicable] == MPBoolYes) {
        [[DTBAds sharedInstance] setCmpFlavor:MOPUB_CMP];
    }
    
    [[DTBAds sharedInstance] setUseGeoLocation:YES];
    [[DTBAds sharedInstance] setLogLevel:DTBLogLevelAll];
    [[DTBAds sharedInstance] setTestMode:YES];
}

- (void)loadBanner;
{
        DTBAdSize *size = [[DTBAdSize alloc] initBannerAdSizeWithWidth:320 height:50 andSlotUUID:BannerID];
        DTBAdLoader *adLoader = [DTBAdLoader new];
        [adLoader setSizes:size, nil];
        [adLoader loadAd:[ApsBannerLoader sharedSingleton]];
}

- (void)loadInterstitial;
{
        DTBAdSize *size = [[DTBAdSize alloc] initInterstitialAdSizeWithSlotUUID:InterstitialID];
        DTBAdLoader *adLoader = [DTBAdLoader new];
        [adLoader setSizes:size, nil];
        [adLoader loadAd:[ApsInterstitialLoader sharedSingleton]];
}

- (void)loadRewardedVideo
{
    DTBAdSize *size = [[DTBAdSize alloc] initVideoAdSizeWithPlayerWidth:480 height:320 andSlotUUID:RewardID];
    DTBAdLoader *adLoader = [DTBAdLoader new];
    [adLoader setSizes:size, nil];
    [adLoader loadAd:[ApsRewardedVideoLoader sharedSingleton]];
}

- (void)loadMrec
{
    DTBAdSize *size = [[DTBAdSize alloc] initBannerAdSizeWithWidth:300 height:250 andSlotUUID:MrecID];
    DTBAdLoader *adLoader = [DTBAdLoader new];
    [adLoader setSizes:size, nil];
    [adLoader loadAd:[ApsMrecLoader sharedSingleton]];
    
}
@end

@implementation ApsBannerLoader
+ (instancetype)sharedSingleton {
    static ApsBannerLoader *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)loadBanner
{
    [[ApsManager sharedSingleton] loadBanner];
}

- (void)onFailure:(DTBAdError)error {
    UnitySendMessage("APSManager", "onBannerFailure", [[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(int)error]] UTF8String] );
}

- (void)onSuccess:(DTBAdResponse *)adResponse {
    UnitySendMessage("APSManager", "onBannerSuccess", [[adResponse keywordsForMopub] UTF8String]);
}

@end

@implementation ApsInterstitialLoader
+ (instancetype)sharedSingleton {
    static ApsInterstitialLoader *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)loadInterstitial
{
    [[ApsManager sharedSingleton] loadInterstitial];
}

- (void)onFailure:(DTBAdError)error {
    UnitySendMessage("APSManager", "onInterstitialFailure", [[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(int)error]] UTF8String] );
}

- (void)onSuccess:(DTBAdResponse *)adResponse {
    UnitySendMessage("APSManager", "onInterstitialSuccess", [[adResponse keywordsForMopub] UTF8String]);
}
@end

@implementation ApsRewardedVideoLoader
+ (instancetype)sharedSingleton {
    static ApsRewardedVideoLoader *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)loadRewardedVideo
{
    [[ApsManager sharedSingleton] loadRewardedVideo];
}

- (void)onFailure:(DTBAdError)error {
    UnitySendMessage("APSManager", "onRewardFailure", [[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(int)error]] UTF8String] );
}

- (void)onSuccess:(DTBAdResponse *)adResponse {
    NSString * sad = [adResponse keywordsForMopub];
    UnitySendMessage("APSManager", "onRewardSuccess", [[adResponse keywordsForMopub] UTF8String]);
}
@end

@implementation ApsMrecLoader

+ (instancetype)sharedSingleton {
    static ApsMrecLoader *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (void)loadMrec {
    [[ApsManager sharedSingleton] loadMrec];
}

- (void)onFailure:(DTBAdError)error {
    UnitySendMessage("APSManager", "onMrecFailure", [[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:(int)error]] UTF8String] );
}

- (void)onSuccess:(DTBAdResponse *)adResponse {
    UnitySendMessage("APSManager", "onMrecSuccess", [[adResponse keywordsForMopub] UTF8String]);
}

@end

@implementation ApsiOSHelper

#define GetStringParam(_x_) ((_x_) != NULL ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""])
#define GetNullableStringParam(_x_) ((_x_) != NULL ? [NSString stringWithUTF8String:_x_] : nil)

#if defined(__cplusplus)
extern "C"{
#endif
    void load_banner()
    {
        [[ApsBannerLoader sharedSingleton] loadBanner];
    }
    
    void refresh_banner_with_load_ad(char* bannerID, char* keywords, char* userDataKeywords)
    {
        [[MoPubManager managerForAdunit:GetStringParam(bannerID)] updateKeywords:GetNullableStringParam(keywords) userDataKeywords:GetNullableStringParam(userDataKeywords)];
    }
    
    void load_interstitial()
    {
        [[ApsInterstitialLoader sharedSingleton] loadInterstitial];
    }
    
    void load_reward()
    {
        [[ApsRewardedVideoLoader sharedSingleton] loadRewardedVideo];
    }
    
    void load_mrec()
    {
        [[ApsMrecLoader sharedSingleton] loadMrec];
    }
    
#if defined(__cplusplus)
    
}
#endif

@end
