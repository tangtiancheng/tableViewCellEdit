//
//  ViewController.m
//  tableView编辑
//
//  Created by 唐天成 on 16/9/11.
//  Copyright © 2016年 唐天成. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIButton *selectAllBtn;

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *dataArray;
;
@property (nonatomic, strong) NSMutableArray *deleteArr;

@property (nonatomic, strong) UIButton *deleteBtn;


@property (nonatomic, strong) UIView *baseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * a = [NSMutableArray array];
    UIView* v = [[UIView alloc]init];
    UIView* v1 = [[UIView alloc]init];
    [a addObject:v];
    [a addObject:v];
    [a addObject:v];
    [a addObject:v];
    [a addObject:v1];
    NSMutableArray * a1 = [NSMutableArray array];
    UIView *v2=[[UIView alloc]init];
    [a1 addObject:v];
    [a1 addObject:v2];
    [a removeObjectsInArray:a1];
    
    NSLog(@"%ld",a.count);
    
    self.dataArray =[NSMutableArray arrayWithObjects: @"12",@"192",@"182",@"712",@"162",@"125",@"124",nil];
    self.deleteArr = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.editing = NO;//默认tableview的editing 是不开启的
    
    //3 全选和多选 删除按钮
    
    //选择按钮
    
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    selectedBtn.frame = CGRectMake(0, 0, 60, 30);
    
    [selectedBtn setTitle:@"选择" forState:UIControlStateNormal];
    
    [selectedBtn addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *selectItem = [[UIBarButtonItem alloc] initWithCustomView:selectedBtn];
    
    self.navigationItem.rightBarButtonItem =selectItem;
    
    //        全选
    
    _selectAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    _selectAllBtn.frame = CGRectMake(0, 0, 60, 30);
    
    [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    
    [_selectAllBtn addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:_selectAllBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _selectAllBtn.hidden = YES;
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height- 60, self.view.frame.size.width, 60)];
    
    _baseView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_baseView];
    
    //删除按钮
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _deleteBtn.backgroundColor = [UIColor redColor];
    
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    
    _deleteBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    
    [_deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_baseView addSubview:_deleteBtn];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const iden = @"Cell";
    
    TableViewCell * cel = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    cel.textLabel.text = self.dataArray[indexPath.row];
    return cel;
}



//4 tableview的delegate和datasource

//是否可以编辑  默认的时YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

//选择编辑的方式,按照选择的方式对表进行处理

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
        
        //真正项目中做删除
        
        //1.将表中的cell删除
        
        //2.将本地的数组中数据删除
        
        //3.最后将服务器端的数据删除
        
    }
    
}

//选择你要对表进行处理的方式  默认是删除方式

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

//******//选中时将选中行的在self.dataArray 中的数据添加到删除数组self.deleteArr中

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.deleteArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {

    [self.deleteArr removeObject:[self.dataArray objectAtIndex:indexPath.row]];

}

//实现完tableview的代理方法 下面处理各个按钮的响应事件
//
//1 首先是选择按钮的响应事件 在按钮事件里面要有self.tableView.allowsMultipleSelectionDuringEditing = YES; 允许支持同时选中多行
//
//然后在点击的时候让tableview.editing = !tableview.editing 点击此按钮可切换tableview的编辑状态

- (void)selectedBtn:(UIButton *)button {
    
    //支持同时选中多行
    
//    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    self.tableView.editing = !self.tableView.editing;
    
    if (self.tableView.editing) {
        
        _selectAllBtn.hidden = NO;
        
        [button setTitle:@"完成" forState:UIControlStateNormal];
        
    }else{
        
        _selectAllBtn.hidden = YES;
        
        [button setTitle:@"删除" forState:UIControlStateNormal];
        
    }
    
}



//2 全选按钮的响应事件
//
//点击全选按钮时 要在这里选中所有的cell 我在网上看到很多资料都是选中当前可见的cell 我们项目要求是全部cell ，所以在这里我这样去做 在self.dataArray里面遍历， 然后找到对应的一共多少行， 获取索引值 indexPath，tableview有系统方法 [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop]; 选择全部的cell  此时在这个全选方法中将数据源self.dataArray的所有数据全部添加到self.deleteArr (存储删除数据的数组中)

//全选

- (void)selectAllBtnClick:(UIButton *)button {
    
    //    [self.tableView reloadData];
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        [self.deleteArr addObjectsFromArray:self.dataArray];
        
    }
    
    NSLog(@"self.deleteArr:%@", self.deleteArr);
    
}

//3 删除按钮的处理事件
//
//无论是多行删除还是全部删除的数据对tableview的操作都是走这个delete方法的。在方法中判断当前的tableview是否处于编辑状态。然后再执行删除操作，关键点就是将数据源self.dataArray中的要删除的数据移除，之前我们的多选或者全选已经将我们要删除的数据存储在self.deleteArr中了 ，所以在这里我们用[self.dataArray removeObjectsInArray:self.deleteArr];这个方法操作 然后刷新tableview。至此就可以实现功能了。



- (void)deleteClick:(UIButton *) button {
    
    if (self.tableView.editing) {
        
        //删除
        
        [self.dataArray removeObjectsInArray:self.deleteArr];
        
        [self.tableView reloadData];
        
    }
    
    else return;
    
}


////******//取消选中时 将存放在self.deleteArr中的数据移除
//

//总结 ：这里面一共有以下几个点
//
//1 在多选删除时 在didSelectRowAtIndexPath这个方法中，根据cell所在行的索引值将此行的数据存到self.deleteArr中 [self.deleteArr addObject:[self.dataArray objectAtIndex:indexPath.row]];
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//当取消删除时，要将self.deleteArr中的数据移除，不然会造成 （你先选中一行 然后取消选中 但是当你点击删除按钮时，这行cell还是会被删除）


//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//    
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
//    
//    [self.deleteArr addObjectsFromArray:self.dataArray];
//    
//    //3 执行删除操作时，将self.dataArr中包含self.deleteArr的数据移除
//    
//    self.dataArray removeObjectsInArray:self.deleteArr];
//    
//    [self.tableView reloadData];
//
//}
//
////2 在全选时。将self.dataArr 中的全部数据都赋值给self.deleteArr
//
//
//
//
////后记：还有一个在cell中添加长按手势 使tableview进入编辑状态
////
////在
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{ //方法中 为cell添加长按手势
//
//UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressedAct:)];
//
//longPressed.minimumPressDuration = 1;
//
//[cell.contentView addGestureRecognizer:longPressed];
//
//
//
////实现长按手势的响应方法：
//
//-(void)longPressedAct:(UILongPressGestureRecognizer *)gesture
//
//{
//    
//    if(gesture.state == UIGestureRecognizerStateBegan)
//        
//    {
//        
//        CGPoint point = [gesture locationInView:self.tableView];
//        
//        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
//        
//        if(indexPath == nil) return ;
//        
//        //add your code here
//        
//        self.tableView.editing = YES;
//        
//    }
//    
//}

//文／劉光軍_Shine（简书作者）
//原文链接：http://www.jianshu.com/p/ec6a037e4c6b
//著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。

@end
