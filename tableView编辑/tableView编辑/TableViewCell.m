//
//  TableViewCell.m
//  tableView编辑
//
//  Created by 唐天成 on 16/9/11.
//  Copyright © 2016年 唐天成. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//-(void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing:editing animated:animated];
//    if (editing)//编辑状态
//    {
//        if (self.editingStyle == (UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete)){ //编辑多选状态
//            if (![self viewWithTag:20])  //编辑多选状态下添加一个自定义的图片来替代原来系统默认的圆圈，注意这个图片在选中与非选中的时候注意切换图片以模拟系统的那种效果
//            {
//                UIImage* img = [UIImage imageNamed:@"Group 2 Copy 2"];
//                UIImageView* editDotView = [[UIImageView alloc] initWithImage:img];
//                editDotView.tag = 20;
//                editDotView.frame = CGRectMake(10,15,20,20);
//                
//                [self addSubview:editDotView];
////                [editDotView release],editDotView = nil;
//            }
//        }
//    }
//    else {
//        //非编辑模式下检查是否有dot图片，有的话删除
//        UIView* editDotView = [self viewWithTag:20];
//        if (editDotView)
//        {
//            [editDotView removeFromSuperview];
//        }
//    }
//}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"Group 2 Copy 2"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"Group 2 Copy"];
                    }
                }
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    NSLog(@"haha");
    // Configure the view for the selected state
}

@end
