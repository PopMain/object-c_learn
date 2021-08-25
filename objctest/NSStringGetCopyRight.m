//
// Created by PopMain on 2021/6/29.
//

#import "NSStringGetCopyRight.h"


@implementation NSString(GetCopyRight)
-(NSString *) getCopyRightString {
    return [self stringByAppendingString:@"CopyRight"];
}
@end