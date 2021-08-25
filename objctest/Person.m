//
// Created by PopMain on 2021/6/28.
//

#import <AppKit/AppKit.h>
#import "Person.h"


@implementation Person {

}
//@synthesize name;
@synthesize address = name;
-(id)init {
    self = [super init];
    return self;
}
#pragma mark - 动态方法
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
-(void)setIndex:(int)index {
    _index = index;
}
-(void)dealloc {
    NSLog(@"Person dealloc");
}
+(void)printPerson:(Person *)p {
    NSLog(@"name=%@, id=%d, age=%d, height=%f", p->name, p->id, p->age, p->height);
}
-(void)test:(NSNumber *)a {
    NSLog(@"person test %d , %@", [a intValue], [NSThread currentThread]);
}

@end