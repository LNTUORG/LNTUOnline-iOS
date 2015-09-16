//
//  DonateTableViewController.m
//  eduadmin
//
//  Created by Li Jie on 15/1/18.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "DonateTableViewController.h"
#import "MBProgressHUD+LJ.h"
#import "Common.h"

@interface DonateTableViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    NSArray *_productArr;
    NSMutableArray *_purchasedArr;
}
@end

@implementation DonateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _purchasedArr = [NSMutableArray array];
    
    [MBProgressHUD showMessage:WAITSTR];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

    [self getProduct];
    
}

- (void)getProduct {
    
    if ([SKPaymentQueue canMakePayments]) {
        // 没有意外
        NSSet *set =[NSSet setWithArray:@[@"eduadm_donate_3", @"eduadm_donate_6", @"eduadm_donate_12", @"eduadm_donate_25"]];
        
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        
        request.delegate = self;
        [request start];
        
    }else {
    
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"访问限制" message:@"您已经禁止应用内购买" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [view show];
    }

}

- (void)buyProduct:(SKProduct *)product {
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    // 添加到队列
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

#pragma mark - StoreKit

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    _productArr = response.products;
    
    [MBProgressHUD hideHUD];
    [self.tableView reloadData];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *trans in transactions) {
        
        switch (trans.transactionState) {
            case SKPaymentTransactionStatePurchased:
                
                [self completeTransaction:trans];
                break;
                
            case SKPaymentTransactionStateFailed:
                
                [self failedTransaction:trans];
                break;
                
            case SKPaymentTransactionStateRestored:
                
                [self restoreTransaction:trans];
                break;
                
                
            default:
                break;
        }
        
    }

}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {

    // 处理 id
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    
    // 移除队列
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [_purchasedArr addObject:productIdentifier];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return _productArr.count;
    }else {
        return _purchasedArr.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SKProduct *pro = _productArr[indexPath.row];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"donate"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"donate"];
        }
        
        cell.userInteractionEnabled = NO;
        
        cell.textLabel.text = [NSString stringWithFormat:@"￥%@", pro.price];
        
        cell.detailTextLabel.text = pro.localizedDescription;
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:pro.productIdentifier]) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
        }
        
        return cell;
    }else {
        
        NSString *str = _purchasedArr[indexPath.row];
        
        NSArray *arr = [str componentsSeparatedByString:@"_"];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"purchased"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"purchased"];
        }
        
        cell.textLabel.text = [NSString stringWithFormat:@"已捐赠的项目是￥%@", arr[2]];
        
        cell.userInteractionEnabled = NO;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SKProduct *pro = _productArr[indexPath.row];
    
    [self buyProduct:pro];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"可选择的捐赠项";
    }else {
    
        return @"已捐赠的项目";
    }
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (IBAction)restore:(id)sender {
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
@end
