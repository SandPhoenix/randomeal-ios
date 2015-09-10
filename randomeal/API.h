//
//  API.h
//  JackrabbitRefresh
//
//  Created by Matteo Sandrin on 26/05/15.
//  Copyright (c) 2015 Jackrabbit Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import "Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>


@interface API : NSObject

+(API*)sharedAPI;

@property (nonatomic,strong) NSDictionary *authParams;

@end
