
#import <Foundation/Foundation.h>

@interface NSArray (Additionals)

+ (BOOL)isValidNSArray:(NSObject*)obj;
+ (BOOL)isValidValue:(NSObject*)obj;

+ (void)appendArayToMutableArray:(NSArray*)array mutableArray:(NSMutableArray**)pMutalbAppay;

@end
