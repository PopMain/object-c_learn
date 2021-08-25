//
// Created by PopMain on 2021/7/9.
//

#import "Async.h"
#import "Person.h"


@implementation Async {

}
-(void) asyncTest {
    /****************************************并发start**********************************************************/
    Person *person = [[Person alloc] init];
    NSString *mtn = [[NSThread currentThread] name];
    NSLog(@"main thread name = %@", mtn);

    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSString *tn = [[NSThread currentThread] name];
        NSLog(@"new thread name = %@", tn);
        int ci = 0;
        while (!thread.isFinished) {
            NSLog(@"%@ is running: %d", tn, ci);
            ci = ci + 1;
            if (ci == 200) {
//                    break;
                [NSThread exit];
            }
        }
        NSLog(@"%@ exist", tn);
    }];
    thread.name = @"my-newthread";
    thread.threadPriority = NSQualityOfServiceUtility;
//        [thread start];
//        [NSThread sleepForTimeInterval:5.0f];
    // 串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.nengyongjiuhao.serial", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(serialQueue, ^{
        NSLog(@"serial sync %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
        dispatch_async(serialQueue, ^{
            NSLog(@"serial async %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
        });
        [NSThread sleepForTimeInterval:3.0f];
    });

//        dispatch_async(serialQueue, ^{
//            NSLog(@"serial async %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
//        });

    // 并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.nengyongjiuhao.concurrent", DISPATCH_QUEUE_CONCURRENT);

    dispatch_sync(concurrentQueue, ^{
        NSLog(@"concurrent sync %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
        dispatch_async(concurrentQueue, ^{
            NSLog(@"concurrent async %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
        });
//            [NSThread sleepForTimeInterval:10.0f];
    });



//        dispatch_async(concurrentQueue, ^{
//            NSLog(@"concurrent async %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
//        });

    // 主队列
//        dispatch_queue_t mainQueue = dispatch_get_main_queue();
//        dispatch_sync(mainQueue, ^{
//            NSLog(@"main sync %@", [[NSThread currentThread] isMainThread] ? @"isMain" : @"notMain");
//        });
    // 全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // 栅栏
//        dispatch_queue_t concurrentQueue2 = dispatch_queue_create("com.nengyongjiuhao.concurrent2", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(concurrentQueue2, ^{
//            // 追加任务 1
//            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);  // 打印当前线程
//        });
//        dispatch_async(concurrentQueue2, ^{
//            // 追加任务 2
//            [NSThread sleepForTimeInterval:2];  // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]); //打印当前线程
//        });
//        dispatch_barrier_async(concurrentQueue2, ^{
//            NSLog(@"barrier---%@",[NSThread currentThread]); //打印当前线程
//        });
//        dispatch_async(concurrentQueue2, ^{
//            // 追加任务 1
//            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
//            NSLog(@"3---%@",[NSThread currentThread]);  // 打印当前线程
//        });
//        dispatch_async(concurrentQueue2, ^{
//            // 追加任务 2
//            [NSThread sleepForTimeInterval:2];  // 模拟耗时操作
//            NSLog(@"4---%@",[NSThread currentThread]); //打印当前线程
//        });


    // dispatch_group
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];  // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    });

    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:2];  // 模拟耗时操作
        NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
    });

//        dispatch_group_notify(group, serialQueue, ^{
//            // 等前面的异步任务 1、任务 2 都执行完毕后，回到主线程执行下边任务
//            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
//            NSLog(@"3---%@",[NSThread currentThread]); // 打印当前线程
//
//            NSLog(@"group---end");
//        });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"group---end");

    // Semaphore
    /**
    semaphore 初始创建时计数为 0。
    异步执行  将  任务 1  追加到队列之后，不做等待，接着执行  dispatch_semaphore_wait  方法，semaphore 减 1，此时  semaphore == -1，当前线程进入等待状态。
    然后，异步任务 1 开始执行。任务 1 执行到  dispatch_semaphore_signal  之后，总信号量加 1，此时  semaphore == 0，正在被阻塞的线程（主线程）恢复继续执行。
    最后打印  semaphore---end,number = 100。
    **/

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // __block https://blog.csdn.net/abc649395594/article/details/47086751
    __block int number = 0;

    dispatch_async(concurrentQueue, ^{
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]);// 打印当前线程

        number = 100;

        dispatch_semaphore_signal(semaphore);

    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"semaphore---end,number = %d", number);

    dispatch_semaphore_t modifyLock = dispatch_semaphore_create(1);

    __block int ticketSurplusCount = 50;

    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_CONCURRENT);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_CONCURRENT);

    // 消费者
//        dispatch_async(queue1, ^{
//            while (1) {
//                // 加锁，保证修改原子性， 确保最后只卖出50张票
//                dispatch_semaphore_wait(modifyLock, DISPATCH_TIME_FOREVER);
//                if (ticketSurplusCount > 0) {
//                    ticketSurplusCount--;
//                    NSLog(@"%@", [NSString stringWithFormat:@"卖票：剩余票数：%d 窗口：%@", ticketSurplusCount, [NSThread currentThread]], modifyLock );
//                    [NSThread sleepForTimeInterval:0.2f];
//                } else {
//                    NSLog(@"所有火车票均已售完。。。等待出票");
//                    dispatch_semaphore_signal(modifyLock);
//                    break;
//                }
//                dispatch_semaphore_signal(modifyLock);
//            }
//        });


//        dispatch_async(queue2, ^{
//            while (1) {
//                // 加锁，保证修改原子性， 确保最后只卖出50张票
//                dispatch_semaphore_wait(modifyLock, DISPATCH_TIME_FOREVER);
//                if (ticketSurplusCount < 49) {
//                    ticketSurplusCount++;
//                    NSLog(@"%@", [NSString stringWithFormat:@"印票：剩余票数：%d 窗口：%@", ticketSurplusCount, [NSThread currentThread]], modifyLock );
//                    [NSThread sleepForTimeInterval:0.3f];
//                } else {
//                    NSLog(@"火车票仓库已满。。。等待出售");
//                    dispatch_semaphore_signal(modifyLock);
//                    break;
//                }
//                dispatch_semaphore_signal(modifyLock);
//            }
//        });

//        NSOperation
    NSNumber * num = [[NSNumber alloc] initWithInt:999];
    NSMethodSignature * sig = [Person instanceMethodSignatureForSelector:@selector(test:)] ;
    NSInvocation *testInvocation = [NSInvocation invocationWithMethodSignature:sig];
    [testInvocation setTarget:person];
    [testInvocation setSelector:@selector(test:)];
    // atIndex从2开始。。。。。
    [testInvocation setArgument:&num  atIndex:2];
//        [testInvocation invoke];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithInvocation:testInvocation];
//        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:person selector:@selector(test:) object:[[NSNumber alloc] initWithInt:999]];
    [op start];

    /**
     * 一般情况下，如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。如果添加的操作的个数多，就会自动开启新线程。当然开启的线程数是由系统来决定的。
     */
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"0--------------%@", [NSThread currentThread]);
    }];
//        typedef void(^Block)(int p);
//        Block block = ^(int p){
//            NSLog(@"%d--------------%@", p, [NSThread currentThread]);
//        };
//        for (int j = 1; j < 10; ++j) {
//            [blockOperation addExecutionBlock:^{
//                NSLog(@"%d--------------%@", j, [NSThread currentThread]);
//            }];
//        }
//        [blockOperation start];

    NSOperationQueue * operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 10;
//        for (int j = 1; j < 10; ++j) {
//            [operationQueue addOperationWithBlock:^{
//                NSLog(@"%d--------------%@", j, [NSThread currentThread]);
//            }];
//        }
    __block NSLock * lock = [[NSLock alloc] init];
    __block NSRecursiveLock * recursiveLoc = [[NSRecursiveLock alloc] init];
    __block NSCondition *condition = [[NSCondition alloc] init];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
            [recursiveLoc lock];
//        @synchronized (person) {
            NSLog(@"op1 start");
            [NSThread sleepForTimeInterval:2.0f];
            NSLog(@"op1 end");
        [recursiveLoc lock];
        NSLog(@"op1 re enter");
        [recursiveLoc unlock];
//        }
            [recursiveLoc unlock];
    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//            [lock lock];
        @synchronized (person) {
            NSLog(@"op2 start");
            [NSThread sleepForTimeInterval:2.0f];
            NSLog(@"op2 end");
        }
//            [lock unlock];
    }];

//        [op2 addDependency:op1];
    [operationQueue addOperation:op1];
    [operationQueue addOperation:op2];

    [NSThread sleepForTimeInterval:12.0f];
    /****************************************并发end**********************************************************/
}
@end