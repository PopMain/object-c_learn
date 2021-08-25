//
// Created by PopMain on 2021/6/28.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
@public NSString * name;
@public int id;
@protected int age;
@protected float height;
@public NSString * _address;
}
@property(nonatomic, readwrite) NSString * name;
@property(nonatomic, readwrite) NSString * address;
@property(nonatomic, readonly) int index;
-(void)setHeight: (float) h;
-(void)setAge:(int) a;
-(void)setup:(float)h Age: (int)a;
+(void)printPerson: (Person*)p;
-(void)test:(NSNumber *)a;
@end