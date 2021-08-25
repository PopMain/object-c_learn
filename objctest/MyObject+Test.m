//
// Created by bytedance on 2021/8/25.
//

#import "MyObject+Test.h"


@implementation MyObject (Test)
-(void) noBB: (int) a : (int) b {
    NSLog(@"noBB: a=%d, b=%d", a, b);
}
@end