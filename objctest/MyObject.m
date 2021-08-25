//
// Created by PopMain on 2021/6/28.
//

#import "MyObject.h"


@implementation MyObject
@synthesize weight;
-(id)init {
    self = [super init];
    height = 20;
    width = 10;
    weight = 1.0;
    return self;
}
-(double) color {
    return .5;
}
//typedef void (^Blk)(void);

-(BOOL) tstFun: (int) a {
    int *p = &a;
    NSLog(@"MyObject testFun : before &a=%x", &a);
    a = 10;
    NSLog(@"MyObject testFun : after &a=%x", &a);
    NSLog(@"MyObject testFun : p=%d", *p);
    typedef void (^Blk)(void);
    Blk blk = ^{
        self.weight = 100;
        [self testFun2];
        printf("%d", a);
//        a = 100;
    };
    blk();
    return YES;
}
-(int*) testFun2 {
    int i = 10;
    return &i;
}
@end

