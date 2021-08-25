//
// Created by PopMain on 2021/7/9.
//

#import "FoundationTest.h"
#import "Person.h"
#import "SomeException.h"
#import "Square.h"
#import "MyObject.h"
#import "SquareExtension.h"
#import "NSStringGetCopyRight.h"

extern int a, b;
int a = 1;
int b = 2;
extern int c;
extern float f;
#define LENGTH 100

#define TEST(n) @"switch"#n
typedef struct Book {
    __unsafe_unretained NSString *title;
    __unsafe_unretained NSString *author;
    __unsafe_unretained NSString *subject;
    int id;
};

int func();

BOOL contentNumber(NSString *string);

void printBook(struct Book book) {
    NSLog(@"%@", TEST(YES));
}

NSString *intToBinary(int intValue) {
    int byteBlock = 8;
    int totalBits = (sizeof(int)) * byteBlock;
    int binaryDigit = totalBits;
    char nDigit[totalBits + 1];
    while (true) {
        int temp = intValue >> binaryDigit;
        nDigit[binaryDigit] = (char) (((temp & 1) == 1) ? '1' : '0');
        binaryDigit = binaryDigit - 1;
        if (binaryDigit < 0) {
            break;
        }
    }
    nDigit[totalBits] = 0;
    return [NSString stringWithUTF8String:nDigit];
}




@implementation FoundationTest {

}
-(void)foundationTest {
    // insert code here...
    [NSThread currentThread].name = @"main";
    int a, b, c;
    float f;
    a = 10;
    b = 20;
    c = a + b;
    f = 3.14f;
    int i = func();
    NSLog(@"Hello, World!");
    char ch = 'a';
    NSLog(@"ch=%c", ch);
    NSLog(@"a=%d, b=%d, c=%d, f=%f, func=%d, len=%d", a, b, c, f, i, LENGTH);
    const int *p = &a;
    NSLog(@"p=%d", *p);
    int *const p1 = &b;
    *p1 = c;
    NSLog(@"p1=%d", *p1);
    int d = 0b110;
    int e = 0b010;
    NSLog(intToBinary((d & e)));
    int var1;
    char var2[10];
    NSLog(@"address of var1 variable: %x", &var1);
    NSLog(@"address of var2 variable: %x", &var2);
    NSString *hello = @"hello";
    NSString *world = @"world";
    NSLog(@"%@,%@", hello, world);
    NSString *str;
    int len;
    str = [world uppercaseString];
    str = [world stringByAppendingFormat:@"0000qqqq"];
    len = [world length];
    NSLog(@"%d", len);
    str = [[NSString alloc] initWithFormat:@"%@ %@", hello, world];
    NSLog(str);
    struct Book book1;
    struct Book book2;
    book1.title = @"dfoid";
    book1.author = @"oeieie";
    book1.id = 309404;
    book1.subject = @"fffff";
    book2.title = @"bbcxc";
    book2.author = @"23dsd";
    book2.id = 154540;
    book2.subject = @"rrrrrr";
    NSLog(@"%@, %@", book1.title, book2.title);
    printBook(book1);
    struct Book *book3 = &book1;
    book1.title = @"oeoieri3223";
    NSLog(@"%@", book3->title);
    NSLog(@"FILE=%s", __FILE__);
//    if (argc == 2) {
//        NSLog(@"arguments is: %s, %s", argv[0], argv[1]);
//    } else {
//        NSLog(@"arguments count must 2");
//    }
    MyObject *obj1 = [[MyObject alloc] init];
    MyObject *obj2 = [[MyObject alloc] init];
    [obj2 tstFun:99];
    int *t2 = [obj2 testFun2];
    NSLog(@"t2=%d", *t2);
    NSLog(@"obj1.weight=%f", obj1.weight);
    Person *person = [[Person alloc] init];
    person->id = 9999;
    person->name = @"hahaha";
    person.address = @"aaaaaa";
    NSLog(@"id=%d, name=%@, address=%@", person->id, person->name, person->_address);
    [person setHeight:1.8f];
    [person setAge:88];
    [person setup:1.78f Age:26];
    [Person printPerson:person];
    Shape *shape = [[Square alloc] init];
    shape->area = 2.0f;
    [shape printArea];
    [((Square *) shape) setId:@"1488555"];
    [((Square *) shape) printId];
    NSLog(@"%@", [@"byte" getCopyRightString]);
    NSString *format = [NSString stringWithFormat:@"ieieieie%d", 10000];
    NSLog(format);
    @try {
        NSException *e = [SomeException
                exceptionWithName:@"SomeException" reason:@"No Reason" userInfo:nil];
        @throw e;
    }
    @catch (NSException *exception) {
        NSLog(exception.reason);
    }
    @finally {

    }
    NSArray *array = [NSArray array];
    NSArray *array1 = @[@"1", @"2", @"3"];
    int index1 = (int) [array1 indexOfObject:@"2"];
    NSLog(@"INDEX=%d %@", index1, array1[(NSUInteger) index1]);
    for (NSString *item in array1) {
        NSLog(@"item=%@", item);
    }
    NSArray *array2 = [NSArray arrayWithArray:array1];
    BOOL isWrite = [array2 writeToFile:@"/Users/PopMain/workspace/sohi/learn-demo/objctest/objctest/objctest/w.plist" atomically:YES];
    if (isWrite) {
        NSLog(@"Write success");
    }
    NSArray *array4 = [NSArray arrayWithContentsOfFile:@"/Users/PopMain/workspace/sohi/learn-demo/objctest/objctest/objctest/myplist.plist"];
    for (NSString *s in array4) {
        NSLog(@"%@", s);
    }


    NSMutableArray *mutableArray1 = [NSMutableArray arrayWithCapacity:10];
    mutableArray1[0] = @"0";
    [mutableArray1 addObject:@"1"];
    [mutableArray1 addObject:@"2"];
    for (NSArray *s in mutableArray1) {
        NSLog(s);
    }

    NSDictionary *dictionary = @{@"key": @"vale",
            @"a": @"1",
            @"b": @"2"};
    for (NSObject *key in [dictionary allKeys]) {
        NSLog(@"%@=%@", key, dictionary[key]);
    }

    NSMutableDictionary *mutableDictionary = [@{@"vale": @"key",
            @"1": @"a",
            @"2": @"b"} mutableCopy];
    [mutableDictionary setValue:@"3" forKey:@"c"];
    for (NSObject *key in [mutableDictionary allKeys]) {
        NSLog(@"%@=%@", key, mutableDictionary[key]);
    }
    NSString *testString = @"    THIS IS HAHAHAHAHAHAAHAHAHAHAHAHAHAHHAHAHAHAHA      ";
    NSLog(testString);
    NSString *whitesspaceStr = [testString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(whitesspaceStr);
    NSDate *date = [NSDate date];
//        [NSDate allocWithZone:NSCreateZone(<#NSUInteger startSize#>, <#NSUInteger granularity#>, <#BOOL canFree#>)]
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"current date is %@", dateString);
    Person *person2 = [[Person alloc] init];

//        [person2 setIndex:200];
//        person2.index = 4664;
    NSLog(@"person2 index = %d", person2.index);
    // Open the Object-c Automatic Reference Counting
//        NSLog(@"person2 retain count after initial allocation %d", [person2 retainCount]);
//        [person2 retain];
//        NSLog(@"person2 retain count after retain %d", [person2 retainCount]);
//        [person2 release];
//        NSLog(@"person2 retain count after release1 %d", [person2 retainCount]);
//        [person2 release];
//        NSLog(@"person2 retain count after release2 %d", [person2 retainCount]);
    Class personClass = [Person class];
    NSLog(@"aaaa  %@", NSStringFromClass(personClass));
    int var[] = {10, 20, 30};
    int h, *ptr;
    ptr = var;
    for (h = 0; h < 3; h++) {
        NSLog(@"Address of var[%d] = %x\n", h, ptr);
        NSLog(@"Value of var[%d] = %d\n", h, *ptr);
        /* move to the next location */
        ptr++;
    }

    func();
    __block int z = 0;
    ^{
        func();
        printf("z=%d", z);
        z = 100;
    };
}
BOOL contentNumber(NSString *str) {
    BOOL res = NO;
    NSCharacterSet *tempSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < str.length) {
        NSString *tempString = [str substringWithRange:NSMakeRange((NSUInteger) i, 1)];
        NSRange range = [tempString rangeOfCharacterFromSet:tempSet];
        if (range.length > 0) {
            res = YES;
        }
    }
    return res;
}

int func() {
    int a = 1;
    int b = 2;
    return a + b;
}
@end