//
//  TPiCarouselViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/9.
//

#import "TPiCarouselViewController.h"
#import <iCarousel.h>

#define iCarouselHeight 150

@interface TPiCarouselViewController ()<iCarouselDelegate,iCarouselDataSource>
@property (nonatomic, strong) iCarousel *iCarouselA;
@property (nonatomic, strong) iCarousel *iCarouselB;
//当前拖动的Carousel
@property (nonatomic, strong) iCarousel *dragingCarousel;
@end

@implementation TPiCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubviews:@[self.iCarouselA,self.iCarouselB]];
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 10;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIDevice.width, iCarouselHeight)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, UIDevice.width-30, iCarouselHeight)];
        [view addSubview:label];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    UILabel *label = view.subviews.firstObject;
    label.text = [NSString stringWithFormat:@"第%ld位置\n上下都支持联动",(long)index];
    return view;
}

#pragma mark - iCarouselDelegate
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
        case iCarouselOptionWrap:  return YES;
        default:                   return value;
    }
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    if ([carousel isEqual:self.iCarouselB]) return transform;
    return CATransform3DScale(CATransform3DTranslate(transform, offset*carousel.frame.size.width, 0.0, 0.0), [self scale:0.5 ByOffset:offset], [self scale:0.5 ByOffset:offset], 1.0f);
}

- (CGFloat)scale:(CGFloat)scale ByOffset:(float)offset{
    float off = fabsf(offset);
    if (off <= 1) {
        return 1-(1-scale)*off;
    }
    return scale;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    _dragingCarousel = carousel;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    //不然会引起循环滚动。
    if(self.dragingCarousel != carousel) return;
    
    if(carousel == _iCarouselA){
        self.iCarouselB.scrollOffset = carousel.scrollOffset;
    }else if(carousel == _iCarouselB){
        self.iCarouselA.scrollOffset = carousel.scrollOffset;
    }
}

#pragma mark - setter/getter
- (iCarousel *)iCarouselA{
    if (!_iCarouselA){
        _iCarouselA = [[iCarousel alloc] initWithFrame:CGRectMake(0, 10, UIDevice.width, iCarouselHeight)];
        _iCarouselA.delegate = self;
        _iCarouselA.dataSource = self;
        _iCarouselA.pagingEnabled = YES;
        _iCarouselA.scrollEnabled = 3;
        _iCarouselA.clipsToBounds = YES;
        _iCarouselA.type = iCarouselTypeCustom;
    }
    return _iCarouselA;
}

- (iCarousel *)iCarouselB{
    if (!_iCarouselB){
        _iCarouselB = [[iCarousel alloc] initWithFrame:CGRectMake(0, 170, UIDevice.width, iCarouselHeight)];
        _iCarouselB.delegate = self;
        _iCarouselB.dataSource = self;
        _iCarouselB.pagingEnabled = YES;
        _iCarouselB.clipsToBounds = YES;
        _iCarouselB.type = iCarouselTypeLinear;
    }
    return _iCarouselB;
}

@end
