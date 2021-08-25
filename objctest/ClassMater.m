//
// Created by PopMain on 2021/6/29.
//

#import "ClassMater.h"


@implementation ClassMater {

}
-(void)setHeight:(float)h {
    height = h;
}
-(void)setAge:(int)a {
    age = a;
}
-(void)setup:(float)h Age:(int)a {
    height = h;
    age = a;
}
-(void)test:(int)a {
    NSLog(@"person test fun = %d %@", a, [NSThread currentThread]);
}
@end