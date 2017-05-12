//
//  PW_RollingScrollView.m
//  导航标题按钮
//
//  Created by DFSJ on 2017/4/6.
//  Copyright © 2017年 dfsj. All rights reserved.
//

#import "PW_RollingScrollView.h"
#import "UIView+Extension.h"
#define indicatorViewColorDefualt [UIColor redColor]

@interface PW_RollingScrollView ()
{

    CGFloat scrollMaxWith;
}

/** 标题数组 */
@property (nonatomic, strong) NSArray *title_Arr;
/** 标题按钮 */
@property (nonatomic, strong) UIButton *title_btn;

/** 是否开启文字缩放功能 */
@property (nonatomic, assign) BOOL isScaleText;


/** 临时button用来转换button的点击状态 */
@property (nonatomic, strong) UIButton *temp_btn;

/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

/** 标记是否是一个button */
@property (nonatomic, assign) BOOL isFirstButton;

@end


/** 按钮字体的大小(字号) */
static CGFloat const btn_fondOfSize = 14;
/** 标题按钮文字的缩放倍数 */
static CGFloat const btn_scale = 0.14;
/** 按钮之间的间距(滚动时按钮之间的间距) */
static CGFloat const btn_Margin = 15;
/** 指示器的高度(默认指示器) */
static CGFloat const indicatorViewHeight = 2;
/** 点击按钮时, 指示器的动画移动时间 */
static CGFloat const indicatorViewTimeOfAnimation = 0.15;

@implementation PW_RollingScrollView

- (NSMutableArray *)storageAlltitleBtn_mArr {
    if (!_storageAlltitleBtn_mArr) {
        _storageAlltitleBtn_mArr = [NSMutableArray array];
    }
    return _storageAlltitleBtn_mArr;
}


+ (instancetype)segmentedControlWithFrame:(CGRect)frame delegate:(id<PW_RollingScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText {
   
    return [[self alloc] initWithFrame:frame delegate:delegate childVcTitle:childVcTitle isScaleText:isScaleText];
}


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PW_RollingScrollViewDelegate>)delegate childVcTitle:(NSArray *)childVcTitle isScaleText:(BOOL)isScaleText {
    
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        self.bounces = NO;
        
        self.delegate_PW = delegate;
        
        self.title_Arr = childVcTitle;
        
        self.isScaleText = isScaleText;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    // 计算scrollView的宽度
    CGFloat button_X = 0;
    CGFloat button_Y = 0;
    CGFloat button_H = self.frame.size.height;
    
    for (NSUInteger i = 0; i < _title_Arr.count; i++) {
        /** 创建滚动时的标题button */
        self.title_btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _title_btn.titleLabel.font = [UIFont systemFontOfSize:btn_fondOfSize];
        _title_btn.tag = i;
        
        // 计算内容的Size
        CGSize buttonSize = [self sizeWithText:_title_Arr[i] font:[UIFont systemFontOfSize:btn_fondOfSize] maxSize:CGSizeMake(MAXFLOAT, button_H)];
        
        // 计算内容的宽度
        CGFloat button_W = 2 * btn_Margin + buttonSize.width;
        _title_btn.frame = CGRectMake(button_X, button_Y, button_W, button_H);
        
        [_title_btn setTitle:_title_Arr[i] forState:(UIControlStateNormal)];
        [_title_btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_title_btn setTitleColor:MainColor forState:(UIControlStateSelected)];
        
        // 计算每个button的X值
        button_X = button_X + button_W;
        
        // 点击事件
        [_title_btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        // 存入所有的title_btn
        [self.storageAlltitleBtn_mArr addObject:_title_btn];
        [self addSubview:_title_btn];
    }
    if (scrollMaxWith<ScreenW&&self.storageAlltitleBtn_mArr.count>1) {
        CGFloat marg_w = (ScreenW - button_X)/(self.storageAlltitleBtn_mArr.count+1);
        for (int i=0; i<self.storageAlltitleBtn_mArr.count; i++) {
            UIButton *btn=self.storageAlltitleBtn_mArr[i];
            btn.left=btn.left+(i+1)*marg_w;
        }
        button_X=ScreenW;
        [self layoutSubviews];
    }
    scrollMaxWith=button_X;

    
    // 计算scrollView的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
    
    // 默认选中第0个button
//    if (self.storageAlltitleBtn_mArr&&self.storageAlltitleBtn_mArr.count>0) {
//        [self buttonAction:self.storageAlltitleBtn_mArr[0]];
//    }

    
    // 取出第一个子控件
    UIButton *firstButton = self.subviews.firstObject;
   
    if (firstButton) {
        
        self.isFirstButton = YES;
    
    }
    
#pragma mark - - - 为文字缩放增加的代码
    if (self.isScaleText) {
        firstButton.titleLabel.font = [UIFont systemFontOfSize:btn_fondOfSize * btn_scale + btn_fondOfSize];
    }
    
    // 添加指示器
    self.indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = MainColor;
    _indicatorView.height = indicatorViewHeight;
    _indicatorView.y = self.frame.size.height - 2 * indicatorViewHeight;
    [self addSubview:_indicatorView];
    
    // 指示器默认在第一个选中位置
    // 计算Titlebutton内容的Size
    CGSize buttonSize = [self sizeWithText:firstButton.titleLabel.text font:[UIFont systemFontOfSize:btn_fondOfSize] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];

#pragma mark - - - 判断是否开启文字缩放功能
    if (self.isScaleText) {
        _indicatorView.width = buttonSize.width + btn_scale * buttonSize.width;
    } else {
        _indicatorView.width = buttonSize.width;
    }
    
    _indicatorView.centerX = firstButton.centerX;
    
    
    UIView *line=[UIView new];
}


#pragma mark - - - 激活按钮
- (void)buttonActive:(UIButton *)sender{
    // 2、改变选中的button的位置
    [self selectedBtnLocation:sender];
}

#pragma mark - - - 按钮的点击事件
- (void)buttonAction:(UIButton *)sender {
    // 1、代理方法实现
    NSInteger index = sender.tag;
    if ([self.delegate_PW respondsToSelector:@selector(SGSegmentedControlDefault:didSelectTitleAtIndex:)]) {
        [self.delegate_PW SGSegmentedControlDefault:self didSelectTitleAtIndex:index];
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
            button.selected = YES; _temp_btn = button;
        }
    });
    
        // 改变指示器位置
        [UIView animateWithDuration:indicatorViewTimeOfAnimation animations:^{
            // 计算内容的Size
            [UIView animateWithDuration:indicatorViewTimeOfAnimation animations:^{
                self.indicatorView.width = button.width - 2 * btn_Margin;
                self.indicatorView.centerX = button.centerX;
            }];
        }];
    
    
    if (scrollMaxWith<=[UIScreen mainScreen].bounds.size.width) {
        return;
    } else {
        // 3、滚动标题选中居中
        [self selectedBtnCenter:button];
    }
    

}


/** 滚动标题选中居中 */
- (void)selectedBtnCenter:(UIButton *)centerBtn {
    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - self.frame.size.width * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentSize.width - self.frame.size.width;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

/** 改变选中button的位置以及指示器位置变化（给外界scrollView提供的方法 -> 必须实现） */
- (void)changeThePositionOfTheSelectedBtnWithScrollView:(UIScrollView *)scrollView {
    // 1、计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 2、把对应的标题选中
    UIButton *selectedBtn = self.storageAlltitleBtn_mArr[index];
    
    // 3、滚动时，改变标题选中
    [self selectedBtnLocation:selectedBtn];
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
