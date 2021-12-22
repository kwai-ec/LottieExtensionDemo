//
//  KwaiLottieMixTestViewController.m
//  KwaiLottieMixTestViewController
//
//  Created by xxx on 2021/9/13.
//

#import "KwaiLottieMixTestViewController.h"
#import "Lottie.h"
#import "LOTAnimationView+MixView.h"
#import "HongBaoView.h"

@interface KwaiLottieMixTestViewController ()

@property (nonatomic, strong) LOTAnimationView *lottieView;

@end

@implementation KwaiLottieMixTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lottieView = [LOTAnimationView animationNamed:@"hongbao" inBundle:[NSBundle mainBundle]];
    HongBaoView *view = [[[NSBundle mainBundle] loadNibNamed:@"HongBaoView" owner:nil options:nil]lastObject];
    [self.lottieView addSubview:view withLayerName:@"卡"];
    
    self.lottieView.frame = self.view.bounds;
    [self.view addSubview:self.lottieView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.lottieView play];
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  [self.lottieView pause];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
