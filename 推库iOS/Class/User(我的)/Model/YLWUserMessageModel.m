//
//  YLWUserMessageModel.m
//  推库iOS
//
//  Created by Mac on 16/2/21.
//  Copyright © 2016年 YLW. All rights reserved.
//

#import "YLWUserMessageModel.h"
#import "YLWHttpTool.h"
@implementation YLWUserMessageModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)userMessageModelWithDictionary:(NSDictionary *)dic{

    return [[self alloc]initWithDictionary:dic];

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

+(void)userMessageModelToLoginWith:(NSDictionary *)nameAndPassword success:(SuccessLoginblock)successLogin error:(ErrorLogin)errorLogin{

    [YLWHttpTool postWithURLString:@"" parameter:nameAndPassword progress:nil success:^(id responseObject) {
        
        NSDictionary *responseObjectDic = (NSDictionary *)responseObject;
        
        NSDictionary *userDic = responseObjectDic[@"user"];
        
        YLWUserMessageModel *model = [self userMessageModelWithDictionary:userDic];
        //归档保存
        [model saveUserInfo];
        
        successLogin();
        
    } failure:^(NSError *error) {
        
        errorLogin(error);
    }];
    
}
#pragma mark 归档与反归档
/**
 *  归档保存用户数据
 */
-(void)saveUserInfo{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    NSString *file = [path stringByAppendingPathComponent:@"userInfo.plist"];

    [NSKeyedArchiver archiveRootObject:self toFile:file];
    
}
/**
 *  反归档读取用户数据
 *
 *  @return 用户数据模型
 */

+(instancetype)readUserInfo{

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *file = [path stringByAppendingPathComponent:@"userInfo.plist"];
    
//    YLWUserMessageModel *model =
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];

}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.ctime forKey:@"ctime"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.profile forKey:@"profile"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.weixin_name forKey:@"weibo_id"];
    [aCoder encodeObject:self.weibo_name forKey:@"weibo_name"];
    [aCoder encodeObject:self.qq_id forKey:@"qq_id"];
    [aCoder encodeObject:self.qq_name forKey:@"qq_name"];
    [aCoder encodeObject:self.weixin_name forKey:@"weixin_name"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.ctime =[aDecoder decodeObjectForKey:@"ctime"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.profile = [aDecoder decodeObjectForKey:@"profile"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.weibo_id = [aDecoder decodeObjectForKey:@"weibo_id"];
        self.weibo_name = [aDecoder decodeObjectForKey:@"weibo_name"];
        self.qq_id = [aDecoder decodeObjectForKey:@"qq_id"];
        self.qq_name = [aDecoder decodeObjectForKey:@"qq_name"];
        self.weixin_name = [aDecoder decodeObjectForKey:@"weixin_name"];
        self.flyme_name = [aDecoder decodeObjectForKey:@"flyme_name"];

        
    }
    return self;
}


@end
