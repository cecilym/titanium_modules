/**
 * Beintoo  
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiBeintooVgoodProxy.h"
#import "Beintoo.h"

@implementation TiBeintooVgoodProxy

#pragma mark -
#pragma mark Public APIs

- (void)getVgood:(id)args{
    [BeintooVgood getSingleVirtualGoodWithDelegate:self];
}

#pragma mark -
#pragma mark Callbacks

- (void)didBeintooGenerateAVirtualGood:(BVirtualGood *)theVgood{
    NSDictionary *arg = [NSDictionary dictionaryWithObjectsAndKeys:[theVgood theGood],@"result",nil];
    if ([self _hasListeners:@"onVgoodGenerated"]) {
        [self fireEvent:@"onVgoodGenerated" withObject:arg];
    }
	NSLog(@"Vgood: %@",[theVgood theGood]);
}

- (void)didBeintooFailToGenerateAVirtualGoodWithError:(NSDictionary *)error{
    NSDictionary *arg = [NSDictionary dictionaryWithObjectsAndKeys:error,@"result",nil];
    if ([self _hasListeners:@"onVgoodGeneratedError"]) {
        [self fireEvent:@"onVgoodGeneratedError" withObject:arg];
    }
}

- (id)getMarketplaceUrl{
    
    NSString *urlAddress;
    
    if ([Beintoo isOnSandbox])
        urlAddress      = [NSString stringWithFormat:@"https://sandbox-elb.beintoo.com/m/marketplace.html"]; 
    else 
        urlAddress      = [NSString stringWithFormat:@"https://www.beintoo.com/m/marketplace.html"];
    
    
    urlAddress          = [urlAddress stringByAppendingFormat:@"?apikey=%@", [Beintoo getApiKey]];
    
    if ([Beintoo getPlayerID])
        urlAddress          = [urlAddress stringByAppendingFormat:@"&guid=%@", [Beintoo getPlayerID]];
    
    CLLocation *loc     = [Beintoo getUserLocation];
    if (loc == nil || (loc.coordinate.latitude <= 0.01f && loc.coordinate.latitude >= -0.01f) 
        || (loc.coordinate.longitude <= 0.01f && loc.coordinate.longitude >= -0.01f)) {
        
    }
    else	
        urlAddress      = [urlAddress stringByAppendingFormat:@"&lat=%f&lng=%f&acc=%f", loc.coordinate.latitude,loc.coordinate.longitude,loc.horizontalAccuracy];	
    
    /* Virtual Currency not already supported on this Sdk Version
     
     if ([Beintoo isVirtualCurrencyStored]){
        urlAddress      = [urlAddress stringByAppendingFormat:@"&developer_user_guid=%@&virtual_currency_amount=%f", [Beintoo getDeveloperUserId], [Beintoo getVirtualCurrencyBalance]];
    }*/

    return urlAddress;
    
}


@end

