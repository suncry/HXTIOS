
#import "XPHTTPURLConnection.h"
#import "AFNetworking.h"
#import "SBJson4.h"

#define URLPREFIX "http://bbs.enveesoft.com:1602/htx/hexinpassserver/appserver/public/"

@interface XPHTTPURLConnection ()
- (void)processResponse:(NSData*)data;
- (void)processErrorInfo:(int)errorType;
- (BOOL)isValidDictionary:(NSObject*)obj;
- (BOOL)isValidNSArray:(NSObject*)obj;

/******************************************************************
 下面两个函数是HTTP请求网络数据的两种方式Get和Post
 strUrl:请求的服务器接口地址的后缀
 parent:请求数据的页面，用于接收IndicatorView
 delegate:请求结果的回调
 *****************************************************************/
- (void)DoGetRequestURL:(NSString*)strUrl parent:(UIView*)parent;
- (void)DoPostRequestURL:(NSString*)strUrl parent:(UIView*)parent params:(NSDictionary*)params;
@end

@implementation XPHTTPURLConnection
@synthesize netActionType;
@synthesize responseString;

#pragma mark 
#pragma mark - init and dealloc
- (id)init
{
    if (self = [super init])
    {
        self.responseString = nil;
        mdelegate = nil;
        self.netActionType = TYPE_NULL;
    }
    return self;
}

#pragma mark -
- (void)processErrorInfo:(int)errorType
{
    NSString *errInfo = nil;
    switch (errorType)
    {
        case 0:
            errInfo = @"网络连接超时, 请检查网络连接";
            break;
        case 1:
            errInfo = @"数据返回格式错误";
            break;
        default:
            break;
    }
    if(mdelegate != nil)[mdelegate ProcessRequestError:errInfo];
}

- (void)processResponse:(NSData*)data
{
    if(data.length <= 0)
    {
        [self processErrorInfo:1];
        return;
    }
    NSStringEncoding strEncode =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString *tempString = nil;
    tempString = [[NSString alloc] initWithData:data encoding:strEncode];
    if(!tempString)
    {
        [self processErrorInfo:1];
        return;
    }
    NSLog(@"httpMsg=%@", tempString);
    self.responseString = tempString;
    
    SBJson4ValueBlock block = ^(id v, BOOL *stop){
        if(![self isValidDictionary:v])
        {
            [self processErrorInfo:1];
            return;
        }
        
        NSDictionary *dataDic = (NSDictionary*)v;
        id status = [dataDic objectForKey:@"success"];
        if([status isKindOfClass:[NSString class]] || [status isKindOfClass:[NSNumber class]])
        {
            int bsuccess = 0;
            if([status isKindOfClass:[NSString class]])bsuccess = [(NSString*)status intValue];
            else bsuccess = [(NSNumber*)status intValue];
            if(bsuccess > 0)
            {
                status = [dataDic objectForKey:@"results"];
                if(![self isValidDictionary:status])
                {
                    [self processErrorInfo:1];
                    return;
                }
                if(mdelegate != nil)[mdelegate ProcessRequestOK:(NSDictionary*)status];
            }
            else
            {
                
            }
        }
        else
        {
            [self processErrorInfo:1];
            return;
        }
    };
    SBJson4ErrorBlock eh = ^(NSError* err) {
        [self processErrorInfo:1];
    };
    
    id parser = [SBJson4Parser parserWithBlock:block allowMultiRoot:YES unwrapRootArray:NO errorHandler:eh];
    [parser parse:data];
}

#pragma mark get methods
- (void)DoGetRequestURL:(NSString*)strUrl parent:(UIView*)parent
{
    NSString *strRequest = [NSString stringWithFormat:@"%s%@", URLPREFIX, strUrl];
    mProgressHUD = [[MBProgressHUD alloc] initWithView:parent];
	[parent addSubview:mProgressHUD];
	mProgressHUD.delegate = nil;
	mProgressHUD.labelText = @"正在请求数据...";
	//mProgressHUD.detailsLabelText = @"updating data";
	mProgressHUD.square = YES;
	[mProgressHUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:strRequest parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processErrorInfo:0];
    }];
}

- (void)DoPostRequestURL:(NSString*)strUrl parent:(UIView*)parent params:(NSDictionary*)params
{
    NSString *strRequest = [NSString stringWithFormat:@"%s%@", URLPREFIX, strUrl];
    mProgressHUD = [[MBProgressHUD alloc] initWithView:parent];
	[parent addSubview:mProgressHUD];
	mProgressHUD.delegate = nil;
	mProgressHUD.labelText = @"正在请求数据...";
	mProgressHUD.square = YES;
	[mProgressHUD show:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:strRequest parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //[formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [mProgressHUD hide:YES];
        [mProgressHUD removeFromSuperview];
        [self processErrorInfo:0];
    }];
}

#pragma mark get from local file
- (NSString*)loadFromJSONFile:(NSString*)strFile
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];
    NSString* fileData = [NSString stringWithContentsOfFile:finalPath encoding:NSUTF8StringEncoding error:nil];
    
    [self setResponseString:fileData];
    return self.responseString;
}

- (void)writeToJSONFile:(NSString*)strFile content:(NSString*)content
{
    NSString* file = strFile;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths objectAtIndex:0];//去处需要的路径//[[NSBundle mainBundle] bundlePath];
	NSString* finalPath = [path stringByAppendingPathComponent:file];

    NSError *error = nil;
    [content writeToFile:finalPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error != nil)NSLog(@"write to file error,info:%@", error.localizedDescription);
}

#pragma mark - extra event
- (BOOL)isValidDictionary:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if([obj isKindOfClass:[NSArray class]])
        return YES;
    
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)obj;
        if([dict count]<=0)
        {
            return NO;
        }
        return YES;
    }
    
    return NO;
}
- (BOOL)isValidNSArray:(NSObject*)obj
{
    if(obj == nil)
        return NO;
    
    if(![obj isKindOfClass:[NSArray class]])
        return NO;
    
    //if( [(NSArray*)obj count] > 0)
    //    return YES;
    
    return YES;
}


/*******************************功能接口区*********************************************/
#pragma mark - 功能接口区
- (void)GetLatestSoftwareVersion:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"ios",@"device",nil];
    [self DoPostRequestURL:@"application/update/update-info" parent:parent params:params];
}

- (void)Registe:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent phone:(NSString*)phone pass:(NSString*)pass
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"tel",pass,@"password",nil];
    [self DoPostRequestURL:@"user/register" parent:parent params:params];
}

- (void)GetUserInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",nil];
    [self DoPostRequestURL:@"user/info" parent:parent params:params];
}

- (void)Login:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent phone:(NSString*)phone pass:(NSString*)pass
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"tel",pass,@"password",nil];
    [self DoPostRequestURL:@"user/login" parent:parent params:params];
}

- (void)ApplyForTenement:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent name:(NSString*)name areaID:(NSInteger)ID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:name,@"tenement_name",[NSNumber numberWithInteger:ID],@"area_id",nil];
    [self DoPostRequestURL:@"tenement/apply" parent:parent params:params];
}

- (void)GetTenementInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",nil];
    [self DoPostRequestURL:@"tenement/user-tenement" parent:parent params:params];
}

- (void)AddTenement:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid buildingNum:(NSInteger)bnum unitNum:(NSInteger)unum houseNum:(NSInteger)hnum
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tid],@"tenement_id",[NSNumber numberWithInteger:bnum],@"building",[NSNumber numberWithInteger:unum],@"unit",[NSNumber numberWithInteger:hnum],@"house",nil];
    [self DoPostRequestURL:@"tenement/open" parent:parent params:params];
}

- (void)GetTenementAreaList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent
{
    mdelegate = delegate;
    [self DoPostRequestURL:@"tenement/area" parent:parent params:nil];
}

- (void)GetHousingEstateList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent areaID:(NSInteger)areaID searchKey:(NSString*)key
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:key,@"search_word",[NSNumber numberWithInteger:areaID],@"area_id",nil];
    [self DoPostRequestURL:@"tenement/list" parent:parent params:params];
}

- (void)GetTenementInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tid],@"tenement_id",nil];
    [self DoPostRequestURL:@"tenement/detail" parent:parent params:params];
}

- (void)TenementServiceComment:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID serviceID:(NSInteger)serviceID comment:(NSString*)comment score:(NSInteger)score
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",[NSNumber numberWithInteger:serviceID],@"tenement_serv_id",comment,@"comment",[NSNumber numberWithInteger:score],@"grade",nil];
    [self DoPostRequestURL:@"serv/appraise" parent:parent params:params];
}

- (void)GetTenementServiceCommentList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid serviceID:(NSInteger)serviceID pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tid],@"tenement_id",[NSNumber numberWithInteger:serviceID],@"id",[NSNumber numberWithInteger:pageSize],@"size",[NSNumber numberWithInteger:pageNum],@"offset",nil];
    [self DoPostRequestURL:@"serv/list" parent:parent params:params];
}

- (void)ApplyForService:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID serviceID:(NSInteger)serviceID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",[NSNumber numberWithInteger:serviceID],@"tenement_serv_id",nil];
    [self DoPostRequestURL:@"announce/apply" parent:parent params:params];
}

- (void)GetTenementServiceList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tid],@"tenement_id",nil];
    [self DoPostRequestURL:@"serv/top" parent:parent params:params];
}

- (void)GetUserTenementBill:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",nil];
    [self DoPostRequestURL:@"bill/tenement-bill" parent:parent params:params];
}

- (void)GetBillCostDetail:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billID:(NSInteger)bID pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:bID],@"bill_id",[NSNumber numberWithInteger:pageSize],@"size",[NSNumber numberWithInteger:pageNum],@"offset",nil];
    [self DoPostRequestURL:@"bill/tenement-log" parent:parent params:params];
}

- (void)AddBindingBill:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billtype:(NSInteger)billtype areaID:(NSInteger)areaID companyID:(NSInteger)companyID cardnum:(NSString*)cardnum comment:(NSString*)comment
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:billtype],@"bill_type",[NSNumber numberWithInteger:areaID],@"area",[NSNumber numberWithInteger:companyID],@"company",cardnum,"card",comment,"name",nil];
    [self DoPostRequestURL:@"bill/add-bind" parent:parent params:params];
}

- (void)ApplyForBillWithhold:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent billIDJson:(NSString*)billID userID:(NSInteger)userID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:billID,@"bill_id",[NSNumber numberWithInteger:userID],@"uid",nil];
    [self DoPostRequestURL:@"bill/apply-charge" parent:parent params:params];
}

- (void)GetUserGoodsList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID goodstype:(NSInteger)type pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",[NSNumber numberWithInteger:type],@"type",[NSNumber numberWithInteger:pageSize],@"size",[NSNumber numberWithInteger:pageNum],@"offset",nil];
    [self DoPostRequestURL:@"item/list" parent:parent params:params];
}

- (void)GetAroundStoreList:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent tenementID:(NSInteger)tid storetype:(NSInteger)type cansend:(BOOL)cansend canpayoff:(BOOL)canpayoff pageCount:(NSInteger)pageSize pageNum:(NSInteger)pageNum
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tid],@"tenement_id",[NSNumber numberWithInteger:type],@"type",[NSNumber numberWithBool:cansend],@"canSend",[NSNumber numberWithBool:canpayoff],@"candPayoff",[NSNumber numberWithInteger:pageSize],@"size",[NSNumber numberWithInteger:pageNum],@"offset",nil];
    [self DoPostRequestURL:@"store/list" parent:parent params:params];
}

- (void)GetAroundStoreInfo:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent storeID:(NSInteger)storeID
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:storeID],@"store_id",nil];
    [self DoPostRequestURL:@"store/info" parent:parent params:params];
}

- (void)AroundStoreComment:(id<HTTPURLConnectionDelegate>)delegate parent:(UIView*)parent userID:(NSInteger)userID storeID:(NSInteger)storeID grade:(NSInteger)grade comment:(NSString*)comment
{
    mdelegate = delegate;
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userID],@"uid",[NSNumber numberWithInteger:storeID],@"store_id",[NSNumber numberWithInteger:grade],@"grade",comment,@"comment",nil];
    [self DoPostRequestURL:@"store/comment-add" parent:parent params:params];
}

@end
