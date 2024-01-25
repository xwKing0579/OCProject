//
//  TPCryptoViewController.m
//  OCProject
//
//  Created by 王祥伟 on 2024/1/15.
//

#import "TPCryptoViewController.h"
#import "TPCryptoUtils.h"
@interface TPCryptoViewController ()
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextView *pubKeyTextView;
@property (nonatomic, strong) UITextView *privteKeyTextView;
@property (nonatomic, strong) UIButton *cryptoBtn;
@end

@implementation TPCryptoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.text = @"base64、MD5、DES、AES、RSA加密demo";
    self.pubKeyTextView.text = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmPW2SwJFldGVB1SM82VYvSZYRF1H5DREUiDK2SLnksxHAV/roC1uB44a4siUehJ9AKeV/g58pVrjhX3eSiBh9Khom/S2hEWF2n/6+lqqiwQi1W5rjl86v+dI2F6NgbPFpfesrRjWD9uskT2VX/ZJuMRLz8VPIyQOM9TW3PkMYBQIDAQAB";
    self.privteKeyTextView.text = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKY9bZLAkWV0ZUHVIzzZVi9JlhEXUfkNERSIMrZIueSzEcBX+ugLW4HjhriyJR6En0Ap5X+DnylWuOFfd5KIGH0qGib9LaERYXaf/r6WqqLBCLVbmuOXzq/50jYXo2Bs8Wl96ytGNYP26yRPZVf9km4xEvPxU8jJA4z1Nbc+QxgFAgMBAAECgYArZVW5PXO3HE9ihBUSyVlqNrdp9sB7VyHiTjuOwiVkwiocH9trv6s/mPmONVLjSJOZ2FYEl4Nw8yaIDrfUFJrvhdbhHJnwkO27Wo5jEfm2qGCwgQNtUACoIH637LXfP81v5I7eZtEa7kfO8Axpp3czvO1HdIAlOI8rU4jb3fB1cQJBANLgfHd/CDro1gtvTrUeTw/lqsKVScGiHn+pmT+THed6ftJ2MAJVcL/0H8+fFN5mRypCL7LQyPO48dTmfY9PbocCQQDJz8xZGq2BNAd3gSrNi3q++SEyjRPzDfr8AGJBJF8qtslcSYrVB/jjPx/qNNlMxOoXnpozBojzVTO3UirMJ/wTAkEAzb930YOhPREGHnwImFCtJT6ZYGcWYpXSGg8Y1d2tlLeA28myx+QjMTZ4fzOgwemaz9FqBpcNKjctxOLqaRRAKwJAXPZwznbgh8zcx6rjea2PjFscdLnR/7tn6x+OIy3K/NUYan+iCUHT33JblDpmAtwObXTs2SZgfZ645PBfsI2WqwJAGJxnG8+wiCnzN0CIZvG96tfOZmz0lkM4NSHDwdCSbagJlZccOtodpn00Dzy+l0t+oFe0Xm3RA0WkPzQX/seO0Q==";
    [self.cryptoBtn setTitle:@"base64" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"加密方式" style:(UIBarButtonItemStyleDone) target:self action:@selector(changeCryptoAction)];
}

- (void)changeCryptoAction{
    NSArray *titles = @[@"base64",@"MD5",@"DES",@"AES",@"RSA"];
    UIAlertController *alertController = [UIAlertController alertStyle:UIAlertControllerStyleActionSheet title:@"选择加密方式" message:nil cancel:@"取消" cancelBlock:^(NSString * _Nonnull cancel) {
        
    } confirm:titles confirmBlock:^(NSUInteger index) {
        self.cryptoBtn.tag = index;
        [self.cryptoBtn setTitle:titles[index] forState:UIControlStateNormal];
        switch (index) {
            case 0:
            case 1:
                self.pubKeyTextView.hidden = self.privteKeyTextView.hidden = YES;
            case 2:
            case 3:
            {
                self.pubKeyTextView.hidden = NO;
                self.privteKeyTextView.hidden = YES;
            }
            case 4:
                self.pubKeyTextView.hidden = self.privteKeyTextView.hidden = NO;
            default:
                break;
        }
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clickCryptoAction:(UIButton *)sender{
    NSString *text = self.textView.text;
    NSString *pubKey = self.pubKeyTextView.text;
    NSString *priKey = self.privteKeyTextView.text;
    if (text.length == 0) {
        [TPToastManager showText:@"明文不能为空"];
        return;
    }

    switch (self.cryptoBtn.tag) {
        case 0:
            self.textView.text = sender.selected ? [TPCryptoUtils base64DecodedString:text] : [TPCryptoUtils base64EncodedString:text];
            break;
        case 1:
            self.textView.text = [TPCryptoUtils MD5EncodedString:text];
            break;
        case 2:
            self.textView.text = sender.selected ? [TPCryptoUtils DESDecrypt:text key:pubKey] : [TPCryptoUtils DESEncrypt:text key:pubKey];
            break;
        case 3:
            self.textView.text = sender.selected ? [TPCryptoUtils AESDecrypt:text key:pubKey] : [TPCryptoUtils AESEncrypt:text key:pubKey];
            break;
        case 4:
            self.textView.text = sender.selected ? [TPCryptoUtils RSADecrypt:text privateKey:priKey] : [TPCryptoUtils RSAEncrypt:text publicKey:pubKey];
            break;
        default:
            break;
    }
   
    sender.selected = !sender.selected;
    NSString *title = self.cryptoBtn.titleLabel.text;
    if (sender.selected && self.cryptoBtn.tag != 1){
        title = [title stringByAppendingString:@"解密"];
    }else{
        title = [title stringByReplacingOccurrencesOfString:@"解密" withString:@""];
    }
    [self.cryptoBtn setTitle:title forState:UIControlStateNormal];
}

- (UITextView *)textView{
    if (!_textView){
        _textView = [[UITextView alloc] init];
        _textView.font = UIFont.font16;
        _textView.textColor = UIColor.c000000;
        _textView.placeholder = @"输入明文";
        _textView.backgroundColor = UIColor.cbfbfbf;
       
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(30);
            make.height.mas_equalTo(150);
        }];
    }
    return _textView;
}

- (UITextView *)pubKeyTextView{
    if (!_pubKeyTextView){
        _pubKeyTextView = [[UITextView alloc] init];
        _pubKeyTextView.font = UIFont.font14;
        _pubKeyTextView.textColor = UIColor.c000000;
        _pubKeyTextView.backgroundColor = UIColor.cbfbfbf;
        _pubKeyTextView.placeholder = @"输入公钥";
        [self.view addSubview:_pubKeyTextView];
        [_pubKeyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
            make.height.mas_equalTo(150);
        }];
    }
    return _pubKeyTextView;
}

- (UITextView *)privteKeyTextView{
    if (!_privteKeyTextView){
        _privteKeyTextView = [[UITextView alloc] init];
        _privteKeyTextView.font = UIFont.font14;
        _privteKeyTextView.textColor = UIColor.cff5a00;
        _privteKeyTextView.backgroundColor = UIColor.cbfbfbf;
        _privteKeyTextView.placeholder = @"输入私钥";
        [self.view addSubview:_privteKeyTextView];
        [_privteKeyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.top.mas_equalTo(self.pubKeyTextView.mas_bottom).offset(20);
            make.height.mas_equalTo(150);
        }];
    }
    return _privteKeyTextView;
}

- (UIButton *)cryptoBtn{
    if (!_cryptoBtn){
        _cryptoBtn = [[UIButton alloc] init];
        _cryptoBtn.backgroundColor = UIColor.cff5a00;
        _cryptoBtn.layer.cornerRadius = 6;
        [_cryptoBtn setTitleColor:UIColor.cffffff forState:UIControlStateNormal];
        [_cryptoBtn addTarget:self action:@selector(clickCryptoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cryptoBtn];
        [_cryptoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(-30-UIDevice.bottomBarHeight);
            make.height.mas_equalTo(50);
        }];
    }
    return _cryptoBtn;
}

@end
