
#import "NSArrayAdditionals.h"

@implementation NSArray (Additionals)

+ (BOOL)isValidValue:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if(obj == nil || obj == [NSNull null])
        return NO;
    
    return YES;
}

+ (BOOL)isValidNSArray:(NSObject*)obj
{
    if(![self isValidValue:obj])
        return NO;
    
    if(![obj isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    
    return YES;
}

+ (void)appendArayToMutableArray:(NSArray*)array mutableArray:(NSMutableArray**)pMutalbAppay
{
    if(!array)
        return;
    
    if(!pMutalbAppay)
        *pMutalbAppay = [[NSMutableArray alloc] init];
    
    for(int i=0;i<array.count;i++)
        [*pMutalbAppay addObject:[array objectAtIndex:i]];
}

@end
