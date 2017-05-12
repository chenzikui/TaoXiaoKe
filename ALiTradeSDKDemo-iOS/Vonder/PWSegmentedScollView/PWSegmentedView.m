//
//  PWSegmentedView.m
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import "PWSegmentedView.h"
#import "UIView+Extension.h"
#define indicatorViewColorDefualt [UIColor redColor]

@interface PWSegmentedView ()


/** 标题按钮 */
@property (nonatomic, strong) UIButton *title_btn;

/** 标题数组 */
@property (nonatomic, strong) NSArray *title_Arr;



/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

/** 临时button用来转换button的点击状态 */
@property (nonatomic, strong) UIButton *temp_btn;

@end

/** 按钮字体的大小(字号) */
static CGFloat const btn_fondOfSize = 17;
/** 指示器的高度 */
static CGFloat const indicatorViewHeight = 2;
/** 点击按钮时, 指示器的动画移动时间 */
static CGFloat const indicatorViewTimeOfAnimation = 0.15;

@implementation PWSegmentedView

+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<PWSegmentedViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle {
    return [[self alloc] initWithFrame:frame delegate:delegate childVcTitle:childVcTitle];
}
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PWSegmentedViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle {
    
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        self.PW_delegate = delegate;
        
        self.title_Arr = childVcTitle;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = self.frame.size.width;
    CGFloat button_X = 0;
    CGFloat button_Y = 0;
    CGFloat button_W = scrollViewWidth / _title_Arr.count;
    CGFloat button_H = self.frame.size.height;
    
    for (NSInteger i = 0; i < _title_Arr.count; i++) {
        // 创建静止时的标题button
        self.title_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _title_btn.titleLabel.font = [UIFont systemFontOfSize:btn_fondOfSize];
        _title_btn.tag = i;
        
        // 计算title_btn的x值
        button_X = i * button_W;
        _title_btn.frame = CGRectMake(button_X, button_Y, button_W, button_H);
        
        [_title_btn setTitle:_title_Arr[i] forState:(UIControlStateNormal)];
        [_title_btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_title_btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        
        // 点击事件
        [_title_btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        // 默认选中第0个button
        if (i == 0) {
            [self buttonAction:_title_btn];
        }
        
        // 存入所有的title_btn
        [self.storageAlltitleBtn_mArr addObject:_title_btn];
        [self addSubview:_title_btn];
    }
    
    // 取出第一个子控件
    UIButton *firstButton = self.subviews.firstObject;
    firstButton.backgroundColor = [UIColor orangeColor];
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = indicatorViewColorDefualt;
    _indicatorView.height = indicatorViewHeight;
    _indicatorView.y = self.frame.size.height - 2 * indicatorViewHeight;
    
    // 指示器默认在第一个选中位置
    // 计算Titlebutton内容的Size
    CGSize buttonSize = [self sizeWithText:firstButton.titleLabel.text font:[UIFont systemFontOfSize:btn_fondOfSize] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    _indicatorView.width = buttonSize.width;
    _indicatorView.centerX = firstButton.centerX;
    
    [self addSubview:_indicatorView];

}


#pragma mark - - - 按钮的点击事件
- (void)buttonAction:(UIButton *)sender {

//     1、代理方法实现
    NSInteger index = sender.tag;
    
    if ([self.PW_delegate respondsToSelector:@selector(SGSegmentedControlStatic:didSelectTitleAtIndex:)]) {
        [self.PW_delegate SGSegmentedControlStatic:self didSelectTitleAtIndex:index];
    }
    
    // 2、改变选中的button的位置
    [self selectedBtnLocation:sender];
}

/** 标题选中颜色改变以及指示器位置变化 */
- (void)selectedBtnLocation:(UIButton *)button {
    
    // 1、选中的button
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(indicatorViewTimeOfAnimation * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_temp_btn == nil) {
            button.selected = YES;
            _temp_btn = button;
        }else if (_temp_btn != nil && _temp_btn == button){
            button.selected = YES;
        }else if (_temp_btn != button && _temp_btn != nil){
            _temp_btn.selected = NO;
            button.selected = YES;
            _temp_btn = button;
        }
    });
    
        NSLog(@"ddddddd button.tag: %zd",button.tag);
    // 2、改变指示器的位置
    // 改变指示器位置
    [UIView animateWithDuration:indicatorViewTimeOfAnimation animations:^{
        // 计算内容的Size
        CGSize buttonSize = [self sizeWithText:button.titleLabel.text font:[UIFont systemFontOfSize:btn_fondOfSize] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height - indicatorViewHeight)];
        
        self.indicatorView.width = buttonSize.width;
        self.indicatorView.centerX = button.centerX;
        
    
        
    }];
}

/** 改变选中button的位置以及指示器位置变化（给外界scrollView提供的方法 -> 必须实现） */
- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView {
    // 1、计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 2、把对应的标题选中
    UIButton *selectedBtn = self.storageAlltitleBtn_mArr[index];
    
        NSLog(@"ddddddd selectedBtn.tag: %zd",selectedBtn.tag);
    
    // 3、滚动时，改变标题选中
    [self selectedBtnLocation:selectedBtn];
}

- (NSMutableArray *)storageAlltitleBtn_mArr {
    
    if (_storageAlltitleBtn_mArr == nil) {
        
        _storageAlltitleBtn_mArr = [NSMutableArray array];
    }
    return _storageAlltitleBtn_mArr;
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
