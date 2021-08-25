//
// Created by PopMain on 2021/6/28.
//

#import <Foundation/Foundation.h>


@interface MyObject : NSObject {
    double height;
    double width;
    double weight;
}
@property(nonatomic, readwrite) double weight;
-(double) color;
-(BOOL) tstFun: (int) a;
-(int*) testFun2;
@end




