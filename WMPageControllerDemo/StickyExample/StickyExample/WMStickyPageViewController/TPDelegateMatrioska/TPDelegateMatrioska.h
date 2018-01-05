//
//  TPDelegateMatrioska.h
//  TPDelegateMatrioska
//
//  Created by Tpphha on 22/07/17.
//  Copyright (c) 2017 Tpphha. All rights reserved.
//  Thanks https://github.com/lukabernardi/LBDelegateMatrioska

#import <Foundation/Foundation.h>

@interface NSInvocation (TPDelegateMatrioskaReturnType)
- (BOOL)methodReturnTypeIsVoid;
@end


@interface TPDelegateMatrioska : NSProxy

@property (readonly, nonatomic, strong) NSArray *delegates;

- (instancetype)initWithDelegateQueueQOS:(NSQualityOfService)qos;

- (instancetype)initWithDelegates:(NSArray *)delegates delegateQueueQOS:(NSQualityOfService)qos;

- (instancetype)initWithDelegates:(NSArray *)delegates;

/**
 返回的实例共用一个 delegate queue, 不是单例
 */
+ (instancetype)defaultMatrioska;

- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (BOOL)containsDelegate:(id)aDelegate;
@end
