//
// Created by PopMain on 2021/7/9.
//

#import "Generic.h"


@implementation Generic {

}
-(void) genericTest {
    NSArray<NSString *> *array = @[@"1", @"2", @"3"];
    NSLog(@"0=========%@", array[0]);
    NSMutableArray<NSString*> *array1 = [NSMutableArray arrayWithCapacity:10];
    [array1 addObject:@"1"];
    [array1 addObject:@"2"];
    NSLog(@"0=========%@", array1[0]);
}
@end