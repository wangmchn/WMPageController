//
//  WMCollectionViewController.m
//  WMPageController
//
//  Created by Mark on 15/6/14.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMCollectionViewController.h"
#import "WMImageViewCell.h"

@interface WMCollectionViewController ()
@property (nonatomic, strong) NSArray *imageNames;
@end

@implementation WMCollectionViewController

static NSString * const reuseIdentifier = @"WMCollectionCell";

- (instancetype)init{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 1;
    flow.minimumInteritemSpacing = .1;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width / 4 - 3*0.1;
    flow.itemSize = CGSizeMake(width,width);
    self = [self initWithCollectionViewLayout:flow];
    if (self) {
        // insert code here...
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageNames = @[@"The roar.jpg",@"Dragon Spirit.jpg",@"Night.jpg"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[WMImageViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSLog(@"%@",self.name);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"------------------------------%@ viewWillAppear",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"%@ destroyed",[self class]);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WMImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSInteger i = indexPath.row % self.imageNames.count;
    NSString *imageName = self.imageNames[i];
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

@end
