//
//  DonateTableViewController.m
//  eduadmin
//
//  Created by JieLee on 15/1/18.
//  Copyright (c) 2015年 PUPBOSS. All rights reserved.
//

#import "DonateTableViewController.h"
#import "MBProgressHUD+LJ.h"
#import "Common.h"
#import "IAPHelper.h"
#import "IAPShare.h"

@interface DonateTableViewController ()
{
    NSArray *_productArr;
    NSArray *_purchasedArr;
}
@end

@implementation DonateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showMessage:waitStr];
    
    [UIApplication sharedApplication].statusBarHidden = YES;

    [self getProduct];
    
}

- (void)getProduct {
    
    if(![IAPShare sharedHelper].iap) {
        
        NSSet* dataSet = [[NSSet alloc] initWithObjects:@"eduadm_donate_3", @"eduadm_donate_6", @"eduadm_donate_12", @"eduadm_donate_25", nil];
        
        [IAPShare sharedHelper].iap = [[IAPHelper alloc] initWithProductIdentifiers:dataSet];
        
    }
    
    [IAPShare sharedHelper].iap.production = YES;
    
    [[IAPShare sharedHelper].iap requestProductsWithCompletion:^(SKProductsRequest *request, SKProductsResponse *response) {
        if(response > 0 ) {
            
            _productArr = [IAPShare sharedHelper].iap.products;
            
            [MBProgressHUD hideHUD];
            
            
        }
        
        _purchasedArr = [[IAPShare sharedHelper].iap.purchasedProducts allObjects];
        
        [self.tableView reloadData];
    }];
}


- (void)buyProduct:(SKProduct *)product {

    [[IAPShare sharedHelper].iap buyProduct:product onCompletion:^(SKPaymentTransaction *transcation) {
        
        
        if(transcation.error)
        {
            
        }
        else if(transcation.transactionState == SKPaymentTransactionStatePurchased) {
            
            NSURLRequest *req = [NSURLRequest requestWithURL:[[NSBundle mainBundle] appStoreReceiptURL]];
            
            NSError *error = nil;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:&error];
            
            [[IAPShare sharedHelper].iap checkReceipt:data AndSharedSecret:@"929ba143829d45d4ba1c52af726b943c" onCompletion:^(NSString *response, NSError *error) {
                
                //Convert JSON String to NSDictionary
                NSDictionary* rec = [IAPShare toJSON:response];
                
                if([rec[@"status"] integerValue]==0)
                {
                    NSString *productIdentifier = transcation.payment.productIdentifier;
                    [[IAPShare sharedHelper].iap provideContent:productIdentifier];
                    _purchasedArr = [[IAPShare sharedHelper].iap.purchasedProducts allObjects];
                    [self.tableView reloadData];
                }
                else {
                    
                }
            }];
            
        }
        else if(transcation.transactionState == SKPaymentTransactionStateFailed) {
            
        }
        
    }];

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
        
        cell.textLabel.text = [NSString stringWithFormat:@"￥%@", pro.price];
        
        cell.detailTextLabel.text = pro.localizedDescription;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else {
        
        NSString *str = _purchasedArr[indexPath.row];
        
        NSArray *arr = [str componentsSeparatedByString:@"_"];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"purchased"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"donate"];
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
    
//    if (![_purchasedArr containsObject:pro.productIdentifier]) {
//        
//        [self buyProduct:pro];
//    }else {
//        
//        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"非常感谢" message:@"此项已经捐赠" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [view show];
//    
//    }
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
@end
