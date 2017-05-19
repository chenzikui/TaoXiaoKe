
//
//  NavHeadTitleView.m
//  京师杏林
//
//  Created by sjt on 15/11/12.
//  Copyright © 2015年 MaNingbo. All rights reserved.
//

#import "CustomNavHeadView.h"

@interface CustomNavHeadView()

@end

@implementation CustomNavHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {

        self.headBgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.headBgView.backgroundColor=[UIColor whiteColor];
        self.headBgView.image = [UIImage imageNamed:@"nav_BG"];
        //隐藏黑线
        self.headBgView.alpha=1;
        [self addSubview:self.headBgView];
        
        self.leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn.backgroundColor=[UIColor clearColor];
        self.leftBtn.frame=CGRectMake(15, 0, 44, 44);
        [self.leftBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.leftBtn];
        
        self.title_lb=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, frame.size.width-120, 44)];
        self.title_lb.textAlignment=NSTextAlignmentCenter;
        self.title_lb.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.title_lb];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-60, 0, 44, 44);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.rightBtn];
        
    }
    return self;
}

-(void)setupViewWithLayer:(UIView *)sender{

    sender.layer.masksToBounds=YES;
    sender.layer.cornerRadius=sender.width/2;
    sender.layer.borderWidth=0.5;
    sender.layer.borderColor=[UIColor whiteColor].CGColor;
}


-(void)setTitle:(NSString *)title{
    _title=title;
    self.title_lb.text=title;

    
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor=titleColor;
    self.title_lb.textColor=_titleColor;
}

//返回按钮
-(void)backClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(NavHeadToLeft:)] ) {
        [_delegate NavHeadToLeft:sender];
    }
}

//右边按钮
-(void)rightBtnClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight:)]) {
        [_delegate NavHeadToRight:sender];
    }
}


@end
