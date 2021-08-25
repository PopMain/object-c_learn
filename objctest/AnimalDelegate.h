//
// Created by PopMain on 2021/6/30.
//

#import <Foundation/Foundation.h>


@protocol AnimalDelegate <NSObject>
@required
-(void) eat;

@optional
-(void)run;
-(void)say;
-(void)sleep;
@end