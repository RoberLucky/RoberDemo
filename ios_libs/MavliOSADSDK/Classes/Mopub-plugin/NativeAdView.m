//
//  NativeAdView.m
//  ADSample
//
//  Created by LiuShuo on 2018/5/30.
//  Copyright © 2019年 Liushuo. All rights reserved.
//

#import "NativeAdView.h"
#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
#import <MoPubSDKFramework/MoPub.h>
#else
#import "MoPub.h"
#endif
#if __has_include(<PureLayout/PureLayout.h>)
#import <PureLayout/PureLayout.h>
#elif __has_include(<PureLayoutSDKFramework/PureLayout.h>)
#import <PureLayoutSDKFramework/PureLayout.h>
#else
#import "PureLayout.h"
#endif



@interface NativeAdView () <MPNativeAdRendering>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *mainTextLabel;
@property (nonatomic, weak) UILabel *ctaLabel;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UIImageView *middleImageView;
@property (nonatomic, weak) UIImageView *privacyImageView;
@property (nonatomic, weak) UILabel  *adLabel;

@end

@implementation NativeAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *middleImageView = [[UIImageView alloc] init];
        self.middleImageView = middleImageView;
        [self addSubview:middleImageView];
        middleImageView.contentMode = UIViewContentModeScaleAspectFill;
        [middleImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        //[middleImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:26];
        [middleImageView autoSetDimension:ALDimensionHeight toSize:190];
        //[middleImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:iconImageView withOffset:0];
        //[middleImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:middleImageView withMultiplier:0.6];
        //middleImageView.layer.masksToBounds = YES;
        
        UILabel *adlabel = [[UILabel alloc] init];
        adlabel.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
        adlabel.textColor = UIColor.whiteColor;
        adlabel.font = [UIFont systemFontOfSize:6];
        adlabel.text = NSLocalizedString(@"AD", nil);
        [self addSubview:adlabel];
        [adlabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        [adlabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
        [adlabel autoSetDimensionsToSize:CGSizeMake(12, 10)];
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        [self addSubview:backImageView];
        backImageView.userInteractionEnabled = YES;
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"image.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *bundlePath1 = [bundle pathForResource:@"img_bg_black" ofType:@"png"];
        backImageView.image = [[UIImage alloc] initWithContentsOfFile:bundlePath1];
        [backImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [backImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [backImageView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [backImageView autoSetDimensionsToSize:CGSizeMake(320, 70)];
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        self.iconImageView = iconImageView;
        [self addSubview:iconImageView];
        iconImageView.layer.cornerRadius = 10;
        iconImageView.layer.masksToBounds = YES;
        [iconImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:12];
        [iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [iconImageView autoSetDimensionsToSize:CGSizeMake(40, 40)];
        
        UIImageView *privacyImageView = [[UIImageView alloc] init];
        self.privacyImageView = privacyImageView;
        [self addSubview:privacyImageView];
        [privacyImageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [privacyImageView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
        [privacyImageView autoSetDimensionsToSize:CGSizeMake(20, 20)];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        [titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:iconImageView withOffset:10];
        [titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:77];
        [titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:iconImageView withOffset:0];
        

        
        UILabel *mainTextLabel = [[UILabel alloc] init];
        self.mainTextLabel = mainTextLabel;
        [self addSubview:mainTextLabel];
        mainTextLabel.textColor = [UIColor blackColor];
        mainTextLabel.font = [UIFont systemFontOfSize:10];
        mainTextLabel.numberOfLines = 2;
        [mainTextLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:titleLabel];
        [mainTextLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:iconImageView];
        [mainTextLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:77];
        //[mainTextLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:titleLabel withOffset:2];
        
        
        UILabel *ctaLabel = [[UILabel alloc] init];
        self.ctaLabel = ctaLabel;
        [self addSubview:ctaLabel];
        ctaLabel.textAlignment = NSTextAlignmentCenter;
        ctaLabel.font = [UIFont systemFontOfSize:12];
        ctaLabel.layer.cornerRadius = 4;
        ctaLabel.layer.masksToBounds = YES;
        ctaLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [ctaLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:iconImageView];
        [ctaLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:13];
        [ctaLabel autoSetDimensionsToSize:CGSizeMake(52, 24)];
    }
    return self;
}

- (UILabel *)nativeTitleTextLabel {
    return self.titleLabel;
}

- (UILabel *)nativeMainTextLabel {
    return self.mainTextLabel;
}

- (UILabel *)nativeCallToActionTextLabel {
    return self.ctaLabel;
}

- (UIImageView *)nativeIconImageView {
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView {
    return self.middleImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView {
    return self.privacyImageView;
}

- (UILabel *)adLabel {
    return  self.adLabel;
}

@end
