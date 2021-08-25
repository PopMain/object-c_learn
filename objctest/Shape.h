//
// Created by PopMain on 2021/6/29.
//

#import <Foundation/Foundation.h>


@interface Shape : NSObject {
    @public CGFloat area;
}
-(void) printArea;
-(void) calculateArea;
-(void) moveX: (float) x;
-(void) moveY: (float) y;
@end