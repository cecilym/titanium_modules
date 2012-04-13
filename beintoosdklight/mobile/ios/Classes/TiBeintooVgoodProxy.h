/**
 * Beintoo  
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiProxy.h"
#import "BeintooVgood.h"

@interface TiBeintooVgoodProxy : TiProxy <BeintooVgoodDelegate>
{
}

- (void)getVgood:(id)args;
- (id)getMarketplaceUrl;


@end
