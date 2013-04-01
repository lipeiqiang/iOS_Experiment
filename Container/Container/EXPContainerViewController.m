//
//  EXPContainerViewController.m
//  Container
//
//  Created by ブックライブ on 2013/03/29.
//  Copyright (c) 2013年 BookLive. All rights reserved.
//

#import "EXPContainerViewController.h"
#import "EXPContainerChildViewController.h"

@interface EXPContainerViewController ()

@end

@implementation EXPContainerViewController {
    UIPageControl *_pageControll;
    UIToolbar *_toolBar;
    UIViewController *_currentChildViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect baseBounds = self.view.bounds;
    
    // ページコントロール
    CGRect pageControllFrame = CGRectMake(0, 0, baseBounds.size.width, 20);
    _pageControll = [[UIPageControl alloc] initWithFrame:pageControllFrame];
    _pageControll.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75f];
    _pageControll.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_pageControll addTarget:self
                      action:@selector(pageControllValueChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    // BarButton Items
    NSMutableArray *barButtonItems = [[NSMutableArray alloc] init];
    
    // PREVボタン
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"PREV"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(moveToPrevChildView)];
    [barButtonItems addObject:prevButton];
    
    // スペーサー
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil
                                                                               action:nil];
    [barButtonItems addObject:flexSpace];
    
    // NEXTボタン
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"NEXT"
                                                                    style:UIBarButtonItemStyleBordered
                                                                   target:self
                                                                   action:@selector(moveToNextChildView)];
    [barButtonItems addObject:nextButton];
    
    // ツールバー
    // CGRect baseBounds = self.view.bounds;
    CGRect toolBarFrame = CGRectMake(0, 0, baseBounds.size.width, 44);
    toolBarFrame.origin.y = baseBounds.size.height - toolBarFrame.size.height;
    _toolBar = [[UIToolbar alloc] initWithFrame:toolBarFrame];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _toolBar.items = barButtonItems;
    [self.view addSubview:_toolBar];
    
    
    // 最初のchildViewController
    [self addContainerChildViewController];
    [self.view addSubview:[self.childViewControllers[0] view]];
    _currentChildViewController = self.childViewControllers[0];
    [self.view addSubview:_pageControll];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonDidTapped:(id)sender {
    [self addContainerChildViewController];
}

- (IBAction)pageControllValueChanged:(UIPageControl *)sender
{
    [self changeChildViewAtPageIndex:_pageControll.currentPage];
}

- (CGRect)rectForChildView
{
    CGRect childViewFrame = self.view.bounds;
    childViewFrame.origin.y = 20;
    childViewFrame.size.height -= 64;
    return childViewFrame;
}

- (void)moveToNextChildView
{
    [self changeChildViewAtPageIndex:_pageControll.currentPage + 1];
}

- (void)moveToPrevChildView
{
    if (_pageControll.currentPage == 0) return;
    [self changeChildViewAtPageIndex:_pageControll.currentPage - 1];
}

- (void)addContainerChildViewController
{
    UIViewController *controller = [[EXPContainerChildViewController alloc] init];
    controller.view.frame = [self rectForChildView];
    [self addChildViewController:controller];
    _pageControll.numberOfPages += 1;

}

- (void)changeChildViewAtPageIndex:(NSUInteger)pageIndex
{
    
    while((NSInteger)pageIndex > _pageControll.numberOfPages - 1) {
        [self addContainerChildViewController];
    }
    
    UIViewController *fromViewController = _currentChildViewController;
    UIViewController *toViewController = self.childViewControllers[pageIndex];
    toViewController.view.frame = [self rectForChildView];
    
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                [self.view bringSubviewToFront:_pageControll];
                            }
                            completion:^(BOOL finished){
                                _currentChildViewController = toViewController;
                                _pageControll.currentPage = (NSInteger)pageIndex;
                            }];
    
    
}




@end
