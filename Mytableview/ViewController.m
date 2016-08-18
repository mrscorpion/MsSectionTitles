//
//  ViewController.m
//  Mytableview
//
//  Created by mr.scorpion  on 15/9/21.
//  Copyright (c) 2015年 mr.scorpion . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    NSMutableArray *_indexArr;//索引数组
    UILabel *_myindex;//中间索引view
    UILabel *_indexView;//右边索引view
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     CGFloat ViewWid=self.view.frame.size.width;
     CGFloat ViewHigt=self.view.frame.size.height;
//   初始化tableview
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, ViewWid, ViewHigt-20) style:0];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
    
//    初始化右边索引条
    _indexView=[[UILabel alloc]initWithFrame:CGRectMake(ViewWid-15,(ViewHigt-380)/2,13,380)];
    _indexView.numberOfLines=0;
    _indexView.font=[UIFont systemFontOfSize:12];
    _indexView.backgroundColor=[UIColor lightGrayColor];
    _indexView.textAlignment=NSTextAlignmentCenter;
    _indexView.userInteractionEnabled=YES;
    _indexView.layer.cornerRadius=5;
    _indexView.layer.masksToBounds=YES;
    _indexView.alpha=0.7;
    [self.view addSubview:_indexView];
    
//    初始化索引条内容
    _indexArr=[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<26; i++)
    {
        NSString *str=[NSString stringWithFormat:@"%c",i+65];
        [_indexArr addObject:str];
        _indexView.text=i==0?str:[NSString stringWithFormat:@"%@\n%@",_indexView.text,str];
    }
//    初始化显示的索引view
    _myindex=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _myindex.font=[UIFont boldSystemFontOfSize:30];
    _myindex.backgroundColor=[UIColor greenColor];
    _myindex.textColor=[UIColor redColor];
    _myindex.textAlignment=NSTextAlignmentCenter;
    _myindex.center=self.view.center;
    _myindex.layer.cornerRadius=_myindex.frame.size.width/2;
    _myindex.layer.masksToBounds=YES;
    _myindex.alpha=0;
    [self.view addSubview:_myindex];
}

//点击开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 [self myTouch:touches];
}


//点击进行中
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self myTouch:touches];
}

//点击结束
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
// 让中间的索引view消失
    [UIView animateWithDuration:1 animations:^{
        _myindex.alpha=0;
    }];
}

//点击会掉的方法
-(void)myTouch:(NSSet *)touches
{
//    让中间的索引view出现
    [UIView animateWithDuration:0.3 animations:^{
         _myindex.alpha=1;
    }];
//    获取点击的区域
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_indexView];
    
    int index=(int)((point.y/380)*26);
    if (index>25||index<0)return;
//    给显示的view赋标题
    _myindex.text=_indexArr[index];
//    跳到tableview指定的区
    NSIndexPath *indpath=[NSIndexPath indexPathForRow:0 inSection:index];
    [_tableview  scrollToRowAtIndexPath:indpath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _indexArr[section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _indexArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundView = nil;
        cell.textLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.95f];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"------第%u行------",(unsigned)indexPath.row + 1];
    
    return cell;
}


@end
