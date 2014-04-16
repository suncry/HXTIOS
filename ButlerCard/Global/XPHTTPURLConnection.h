
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

enum NetActionType
{
    TYPE_NULL = 0,
    TYPE_LOGIN,
    TYPE_REGISTE,
    TYPE_MODIFYPASS,
    TYPE_MODIFYCARDPASS,
    TYPE_CARDBINDING
};

@protocol HTTPURLConnectionDelegate <NSObject>

- (void)ProcessRequestOK:(id)response;
- (void)ProcessRequestError:(NSString*)response;

@end

@interface XPHTTPURLConnection : NSObject
{
    id<HTTPURLConnectionDelegate> mdelegate;
    MBProgressHUD *mProgressHUD;
}

@property (nonatomic, assign) enum NetActionType netActionType;
@property (nonatomic, copy) NSString *responseString;

//下面两个函数是存取文件的操作
- (NSString*)loadFromJSONFile:(NSString*)strFile;
- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content;

/*******************功能区*******************************/
//软件更新
- (void)GetLatestSoftwareVersion:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent;//获取最新版本信息

//登录注册
- (void)Registe:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent phone:(NSString*)phone pass:(NSString*)pass;//注册
- (void)GetUserInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID;//获取用户信息
- (void)Login:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent phone:(NSString*)phone pass:(NSString*)pass;//登录

//小区物业
- (void)ApplyForTenement:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent name:(NSString*)name areaID:(NSInteger)ID;//物业申请
- (void)GetTenementInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID;//获取用户的物业信息
- (void)AddTenement:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid buildingNum:(NSInteger)bnum unitNum:(NSInteger)unum houseNum:(NSInteger)hnum;//添加物业
- (void)GetTenementAreaList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent;//获取所有物业对应的地区
- (void)GetHousingEstateList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent areaID:(NSInteger)areaID searchKey:(NSString*)key;//获取小区列表
- (void)GetTenementInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid;//获取小区编号信息
- (void)TenementServiceComment:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID serviceID:(NSInteger)serviceID comment:(NSString*)comment score:(NSInteger)score;//小区物业服务评价
- (void)GetTenementServiceCommentList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid serviceID:(NSInteger)serviceID pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum;//获取小区服务评价列表
- (void)ApplyForService:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID serviceID:(NSInteger)serviceID;//申请物业服务
- (void)GetTenementServiceList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid;//获取小区的服务列表

//用户物业
- (void)GetUserTenementBill:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID;//获取用户的物业账单
- (void)GetBillCostDetail:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billID:(NSInteger)bID pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum;//账单费用明细
- (void)AddBindingBill:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billtype:(NSInteger)billtype areaID:(NSInteger)areaID companyID:(NSInteger)companyID cardnum:(NSString*)cardnum comment:(NSString*)comment;//添加账单绑定
- (void)ApplyForBillWithhold:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billIDJson:(NSString*)billID userID:(NSInteger)userID;//申请账单代扣(billID为json格式:{1:0,2:1,3:0})

//用户物品
- (void)GetUserGoodsList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID goodstype:(NSInteger)type pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum;//获取用户物品列表

//周边服务
- (void)GetAroundStoreList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid storetype:(NSInteger)type cansend:(BOOL)cansend canpayoff:(BOOL)canpayoff pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum;//获取周边商铺列表
- (void)GetAroundStoreInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent storeID:(NSInteger)storeID;//获取周边商铺详情
- (void)AroundStoreComment:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID storeID:(NSInteger)storeID grade:(NSInteger)grade comment:(NSString*)comment;//对周边商铺进行评价
@end

