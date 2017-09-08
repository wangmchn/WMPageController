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
@end


@implementation TPDelegateMatrioska

- (instancetype)initWithDelegateQueueQOS:(NSQualityOfService)qos {
    _mutableDelegates = [NSPointerArray weakObjectsPointerArray];
    dispatch_qos_class_t qosClass = NSQualityOfServiceToQOSClass(qos);
    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qosClass, 0);
    _queue = dispatch_queue_create("com.tpphha.TPDelegateMatrioska", attr);
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



#pragma mark - Public interface

- (NSArray *)delegates
{
    return [self.mutableDelegates allObjects];
}


- (void)addDelegate:(id)aDelegate
{
    NSParameterAssert(aDelegate);
    dispatch_sync(_queue, ^{
        [self.mutableDelegates addPointer:(void *)aDelegate];
    });
}

- (void)removeDelegate:(id)aDelegate
{
    NSParameterAssert(aDelegate);
    
    dispatch_sync(_queue, ^{
        NSUInteger index = 0;
        for (id delegate in self.mutableDelegates) {
            if (delegate == aDelegate) {
                [self.mutableDelegates removePointerAtIndex:index];
                break;
            }
            index++;
        }
    });
}


- (BOOL)containsDelegate:(id)aDelegate {
    NSParameterAssert(aDelegate);
    __block BOOL result = NO;
    dispatch_sync(_queue, ^{
        for (id delegate in self.mutableDelegates) {
            if (delegate == aDelegate) {
                result = YES;
                break;
            }
        }
    });
    return result;
}

#pragma mark - NSProxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    // If the invoked method return void I can safely call all the delegates
    // otherwise I just invoke it on the first delegate that
    // respond to the given selector
    if ([invocation methodReturnTypeIsVoid]) {
        for (id delegate in self.mutableDelegates) {
            if ([delegate respondsToSelector:invocation.selector]) {
                [invocation invokeWithTarget:delegate];
            }
        }
    } else {
        id firstResponder = [self p_firstResponderToSelector:invocation.selector];
        [invocation invokeWithTarget:firstResponder];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    id firstResponder = [self p_firstResponderToSelector:sel];
    if (firstResponder) {
        return [firstResponder methodSignatureForSelector:sel];
    }
    return nil;
}

#pragma mark - NSObject

- (BOOL)respondsToSelector:(SEL)aSelector
{
    id firstResponder = [self p_firstResponderToSelector:aSelector];
    return (firstResponder ? YES : NO);
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    id firstConformed = [self p_firstConformedToProtocol:aProtocol];
    return (firstConformed ? YES : NO);
}

#pragma mark - Private

- (id)p_firstResponderToSelector:(SEL)aSelector
{
    __block id returnValue = nil;
    dispatch_sync(_queue, ^{
        for (id delegate in self.mutableDelegates) {
            if ([delegate respondsToSelector:aSelector]) {
                returnValue = delegate;
                break;
            }
        }
    });
    return returnValue;
}

- (id)p_firstConformedToProtocol:(Protocol *)protocol
{
    __block id returnValue = nil;
    dispatch_sync(_queue, ^{
        for (id delegate in self.mutableDelegates) {
            if ([delegate conformsToProtocol:protocol]) {
                returnValue = delegate;
                break;
            }
        }
    });
    return returnValue;
}

@end
