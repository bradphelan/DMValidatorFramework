#import "DMCondition.h"


@interface DMBaseCondition : NSObject<DMCondition>


/**
 * Override this method and create custom condition.
 */
+ (BOOL)check:(NSString*)string;


@end
