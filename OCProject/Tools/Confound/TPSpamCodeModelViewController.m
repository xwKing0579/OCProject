//
//  TPSpamCodeModelViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/3/22.
//

#import "TPSpamCodeModelViewController.h"
#import "TPConfoundModel.h"
#import "TPConfoundSetting.h"
#import <iCarousel.h>
@interface TPSpamCodeModelViewController ()<iCarouselDelegate,iCarouselDataSource>
@property (nonatomic, strong) iCarousel *iCarousel;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TPSpamCodeModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @".h.m文件模版";
    
    self.data = [TPConfoundModel data_file];
    [self.view addSubview:self.iCarousel];
    [self.iCarousel reloadData];
    [self.tableView reloadData];
    self.tableView.scrollEnabled = NO;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(52*self.data.count+UIDevice.bottomBarHeight);
    }];
}

- (void)reloadData{
    [self.iCarousel reloadData];
}

- (NSString *)cellClass{
    return TPString.tc_spam_code_model;
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 2;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc] initWithFrame:carousel.bounds];
        UITextView *textView = [[UITextView alloc] initWithFrame:view.bounds];
        textView.font = UIFont.font14;
        textView.textColor = UIColor.c000000;
        textView.backgroundColor = UIColor.cbfbfbf;
        [view addSubview:textView];
    }
    UITextView *textView = view.subviews.firstObject;
    textView.placeholder = @"文件模版";
    TPSpamCodeFileSetting *fileSet = TPConfoundSetting.sharedManager.spamSet.spamFileSet;
    NSString *string = index%2 ? fileSet.spammFileContent : fileSet.spamhFileContent;
    string = [string stringByReplacingOccurrencesOfString:@"projectName" withString:fileSet.projectName];
    string = [string stringByReplacingOccurrencesOfString:@"author" withString:fileSet.author];
    string = [string stringByReplacingOccurrencesOfString:@"date" withString:[NSDate currentTimeFormatterString:@"yyyy/MM/dd"]];
    textView.text = string;
    return view;
}

#pragma mark - iCarouselDelegate
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
        case iCarouselOptionWrap:  return YES;
        default:                   return value;
    }
}

#pragma mark - setter/getter
- (iCarousel *)iCarousel{
    if (!_iCarousel){
        _iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, UIDevice.width, UIDevice.height-52*self.data.count-UIDevice.bottomBarHeight)];
        _iCarousel.delegate = self;
        _iCarousel.dataSource = self;
        _iCarousel.pagingEnabled = YES;
        _iCarousel.scrollEnabled = 3;
        _iCarousel.clipsToBounds = YES;
        _iCarousel.type = iCarouselTypeLinear;
    }
    return _iCarousel;
}
@end
