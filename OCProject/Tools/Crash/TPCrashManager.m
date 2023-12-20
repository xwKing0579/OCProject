//
//  TPCrashManager.m
//  OCProject
//
//  Created by 王祥伟 on 2023/12/12.
//

#import "TPCrashManager.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import "TPCrashModel.h"
#import "TPCrashCache.h"

@implementation TPCrashManager

+ (void)load{
#ifdef DEBUG
    [self registerCatch];
#endif
}

#pragma mark - Primary
+ (void)registerCatch {
    NSSetUncaughtExceptionHandler(&HandleException);
    signal(SIGHUP, SignalHandler);
    signal(SIGINT, SignalHandler);
    signal(SIGQUIT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGTRAP, SignalHandler);
    signal(SIGABRT, SignalHandler);
#ifdef SIGPOLL
    signal(SIGPOLL, SignalHandler);
#endif
#ifdef SIGEMT
    signal(SIGEMT, SignalHandler);
#endif
    signal(SIGFPE, SignalHandler);
    signal(SIGKILL, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGSYS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
    signal(SIGALRM, SignalHandler);
    signal(SIGTERM, SignalHandler);
    signal(SIGURG, SignalHandler);
    signal(SIGSTOP, SignalHandler);
    signal(SIGTSTP, SignalHandler);
    signal(SIGCONT, SignalHandler);
    signal(SIGCHLD, SignalHandler);
    signal(SIGTTIN, SignalHandler);
    signal(SIGTTOU, SignalHandler);
#ifdef SIGIO
    signal(SIGIO, SignalHandler);
#endif
    signal(SIGXCPU, SignalHandler);
    signal(SIGXFSZ, SignalHandler);
    signal(SIGVTALRM, SignalHandler);
    signal(SIGPROF, SignalHandler);
#ifdef SIGWINCH
    signal(SIGWINCH, SignalHandler);
#endif
#ifdef SIGINFO
    signal(SIGINFO, SignalHandler);
#endif
    signal(SIGUSR1, SignalHandler);
    signal(SIGUSR2, SignalHandler);
}

void HandleException(NSException *exception){
    TPCrashModel *model = [TPCrashModel new];
    model.name = exception.name;
    model.reason = exception.reason;
    model.stackSymbols = exception.callStackSymbols;
    model.date = [NSDate currentTime];
    model.thread = [NSThread currentThread].description;
    model.page = [NSString stringWithFormat:@"%@",UIViewController.currentViewController ?: UIViewController.window];
    
    id obj = [TPCrashCache crashData];
    NSMutableArray *data = [NSMutableArray array];
    if (obj) [data addObjectsFromArray:obj];
    [data addObject:model];
    [TPCrashCache cacheCrashData:data];
    
    [exception raise];
}

void SignalHandler(int sig){
    // See https://stackoverflow.com/questions/40631334/how-to-intercept-exc-bad-instruction-when-unwrapping-nil.
    NSString *name = @"Unknown signal";
    switch (sig) {
        case SIGHUP:{
            name = @"SIGHUP";
        }
            break;
        case SIGINT:{
            name = @"SIGINT";
        }
            break;
        case SIGQUIT:{
            name = @"SIGQUIT";
        }
            break;
        case SIGILL:{
            name = @"SIGILL";
        }
            break;
        case SIGTRAP:{
            name = @"SIGTRAP";
        }
            break;
        case SIGABRT:{
            name = @"SIGABRT";
        }
            break;
#ifdef SIGPOLL
        case SIGPOLL:{
            name = @"SIGPOLL";
        }
            break;
#endif
        case SIGEMT:{
            name = @"SIGEMT";
        }
            break;
        case SIGFPE:{
            name = @"SIGFPE";
        }
            break;
        case SIGKILL:{
            name = @"SIGKILL";
        }
            break;
        case SIGBUS:{
            name = @"SIGBUS";
        }
            break;
        case SIGSEGV:{
            name = @"SIGSEGV";
        }
            break;
        case SIGSYS:{
            name = @"SIGSYS";
        }
            break;
        case SIGPIPE:{
            name = @"SIGPIPE";
        }
            break;
        case SIGALRM:{
            name = @"SIGALRM";
        }
            break;
        case SIGTERM:{
            name = @"SIGTERM";
        }
            break;
        case SIGURG:{
            name = @"SIGURG";
        }
            break;
        case SIGSTOP:{
            name = @"SIGSTOP";
        }
            break;
        case SIGTSTP:{
            name = @"SIGTSTP";
        }
            break;
        case SIGCONT:{
            name = @"SIGCONT";
        }
            break;
        case SIGCHLD:{
            name = @"SIGCHLD";
        }
            break;
        case SIGTTIN:{
            name = @"SIGTTIN";
        }
            break;
        case SIGTTOU:{
            name = @"SIGTTOU";
        }
            break;
#ifdef SIGIO
        case SIGIO:{
            name = @"SIGIO";
        }
            break;
#endif
        case SIGXCPU:{
            name = @"SIGXCPU";
        }
            break;
        case SIGXFSZ:{
            name = @"SIGXFSZ";
        }
            break;
        case SIGVTALRM:{
            name = @"SIGVTALRM";
        }
            break;
        case SIGPROF:{
            name = @"SIGPROF";
        }
            break;
#ifdef SIGWINCH
        case SIGWINCH:{
            name = @"SIGWINCH";
        }
            break;
#endif
#ifdef SIGINFO
        case SIGINFO:{
            name = @"SIGINFO";
        }
            break;
#endif
        case SIGUSR1:{
            name = @"SIGUSR1";
        }
            break;
        case SIGUSR2:{
            name = @"SIGUSR2";
        }
            break;
    }

    TPCrashModel *model = [TPCrashModel new];
    model.name = name;
    model.reason = [NSString stringWithFormat:@"%@ Signal",name];
    model.stackSymbols = [NSThread callStackSymbols];
    model.date = [NSDate currentTime];
    model.thread = [NSThread currentThread].description;
    model.page = [NSString stringWithFormat:@"%@",UIViewController.currentViewController ?: UIViewController.window];
    id obj = [TPCrashCache crashData];
    
    NSMutableArray *data = [NSMutableArray array];
    if (obj) [data addObjectsFromArray:obj];
    [data addObject:model];
    [TPCrashCache cacheCrashData:data];
    
    kill(getpid(), SIGKILL);
}

@end
