//
//  TPDelegateMatrioska.m
//  TPDelegateMatrioska
//
//  Created by Tpphha on 22/07/17.
//  Copyright (c) 2017 Tpphha. All rights reserved.
//  Thanks https://github.com/lukabernardi/LBDelegateMatrioska


#import "TPDelegateMatrioska.h"

static inline qos_class_t NSQualityOfServiceToQOSClass(NSQualityOfService qos) {
    switch (qos) {
        case NSQualityOfServiceUserInteractive: return QOS_CLASS_USER_INTERACTIVE;
        case NSQualityOfServiceUserInitiated: return QOS_CLASS_USER_INITIATED;
        case NSQualityOfServiceUtility: return QOS_CLASS_UTILITY;
        case NSQualityOfServiceBackground: return QOS_CLASS_BACKGROUND;
        case NSQualityOfServiceDefault: return QOS_CLASS_DEFAULT;
        default: return QOS_CLASS_UNSPECIFIED;
    }
}


@implementation NSInvocation (TPDelegateMatrioskaReturnType)

- (BOOL)methodReturnTypeIsVoid
{
    return (([self.methodSignature methodReturnLength] == 0) ? YES : NO);
}

@end


@interface TPDelegateMatrioska ()
@property (nonatomic, strong) NSPointerArray *mutableDelegates;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy) NSString *uniqueId;
@end


@implementation TPDelegateMatrioska

static const void * const kDispatchQueueSpecificKey = &kDispatchQueueSpecificKey;

- (instancetype)initWithDelegateQueueQOS:(NSQualityOfService)qos {
    _mutableDelegates = [NSPointerArray weakObjectsPointerArray];
    dispatch_qos_class_t qosClass = NSQualityOfServiceToQOSClass(qos);
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qosClass, 0);
    _queue = dispatch_queue_create("com.qlchat.TPDelegateMatrioska.queue", attr);
    _uniqueId = [NSProcessInfo processInfo].globallyUniqueString;
    dispatch_queue_set_specific(_queue, kDispatchQueueSpecificKey, (__bridge void *)_uniqueId, NULL);
    return self;
}

- (instancetype)initWithDelegates:(NSArray *)delegates delegateQueueQOS:(NSQualityOfService)qos {
    self = [self initWithDelegateQueueQOS:qos];
    [delegates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_mutableDelegates addPointer:(void *)obj];
    }];
    return self;
}

- (instancetype)initWithDelegates:(NSArray *)delegates {
    return [self initWithDelegates:delegates delegateQueueQOS:NSQualityOfServiceDefault];
}

- (instancetype)init {
    return self;
}

static dispatch_queue_t sharedQueue;

+ (instancetype)defaultMatrioska {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_qos_class_t qosClass = NSQualityOfServiceToQOSClass(NSQualityOfServiceUserInitiated);
        dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qosClass, 0);
        sharedQueue = dispatch_queue_create("com.qlchat.TPDelegateMatrioska.shared.queue", attr);
    });
    TPDelegateMatrioska *instance = [[self alloc] init];
    instance.mutableDelegates = [NSPointerArray weakObjectsPointerArray];
    instance.queue = sharedQueue;
    return instance;
}


#pragma mark - Public interface

- (NSArray *)delegates
{
    return [self.mutableDelegates allObjects];
}


- (void)addDelegate:(id)aDelegate
{
    NSParameterAssert(aDelegate);
    [self dispatchSync:^{
        [self.mutableDelegates addPointer:(void *)aDelegate];
    }];
}

- (void)removeDelegate:(id)aDelegate
{
    NSParameterAssert(aDelegate);
    [self dispatchSync:^{
        NSUInteger index = 0;
        for (id delegate in self.mutableDelegates) {
            if (delegate == aDelegate) {
                [self.mutableDelegates removePointerAtIndex:index];
                break;
            }
            index++;
        }
    }];
}


- (BOOL)containsDelegate:(id)aDelegate {
    NSParameterAssert(aDelegate);
    __block BOOL result = NO;
    [self dispatchSync:^{
        for (id delegate in self.mutableDelegates) {
            if (delegate == aDelegate) {
                result = YES;
                break;
            }
        }
    }];
    return result;
}


#pragma mark - NSProxy


- (void)forwardInvocation:(NSInvocation *)invocation
{
    // If the invoked method return void I can safely call all the delegates
    // otherwise I just invoke it on the first delegate that
    // respond to the given selector
    if ([invocation methodReturnTypeIsVoid]) {
        [self dispatchSync:^{
            for (id delegate in self.mutableDelegates) {
                if ([delegate respondsToSelector:invocation.selector]) {
                    [invocation invokeWithTarget:delegate];
                }
            }
        }];
    } else {
        __block id firstResponder = nil;
        [self dispatchSync:^{
            firstResponder = [self p_firstResponderToSelector:invocation.selector];
        }];
        [invocation invokeWithTarget:firstResponder];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    __block id firstResponder = nil;
    [self dispatchSync:^{
        firstResponder = [self p_firstResponderToSelector:sel];
    }];
    if (firstResponder) {
        return [firstResponder methodSignatureForSelector:sel];
    }
    // https://github.com/facebookarchive/AsyncDisplayKit/pull/1562
    // Unfortunately, in order to get this object to work properly, the use of a method which creates an NSMethodSignature
    // from a C string. -methodSignatureForSelector is called when a compiled definition for the selector cannot be found.
    // This is the place where we have to create our own dud NSMethodSignature. This is necessary because if this method
    // returns nil, a selector not found exception is raised. The string argument to -signatureWithObjCTypes: outlines
    // the return type and arguments to the message. To return a dud NSMethodSignature, pretty much any signature will
    // suffice. Since the -forwardInvocation call will do nothing if the delegate does not respond to the selector,
    // the dud NSMethodSignature simply gets us around the exception.
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];;
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    __block id firstResponder = nil;
    [self dispatchSync:^{
        firstResponder = [self p_firstResponderToSelector:aSelector];
    }];
    return (firstResponder ? YES : NO);
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    __block id firstConformed = nil;
    [self dispatchSync:^{
        firstConformed = [self p_firstConformedToProtocol:aProtocol];
    }];
    return (firstConformed ? YES : NO);
}

#pragma mark - Private

- (id)p_firstResponderToSelector:(SEL)aSelector
{
    id returnValue = nil;
    for (id delegate in self.mutableDelegates) {
        if ([delegate respondsToSelector:aSelector]) {
            returnValue = delegate;
            break;
        }
    }
    return returnValue;
}

- (id)p_firstConformedToProtocol:(Protocol *)protocol
{
    id returnValue = nil;
    for (id delegate in self.mutableDelegates) {
        if ([delegate conformsToProtocol:protocol]) {
            returnValue = delegate;
            break;
        }
    }
    return returnValue;
}

- (void)dispatchSync:(_Nonnull dispatch_block_t)block {
    if (_queue == sharedQueue) {
        block();
    }else {
        NSString *uniqueId = (__bridge NSString *)(dispatch_get_specific(&kDispatchQueueSpecificKey));
        if ([uniqueId isEqualToString:_uniqueId]) {
            block();
        }else {
            dispatch_sync(_queue, ^{
                block();
            });
        }
    }
}

@end
