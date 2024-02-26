//
//  AKLog.h
//  PPScaleSDK
//
//  Created by 彭思远 on 2022/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  自定义Log，可配置开关（用于替换NSLog）
 */
#define PP_Log(format,...) PPCustomLog(__FUNCTION__,__LINE__,format,##__VA_ARGS__)



@interface AKLog : NSObject
@property(nonatomic,strong)NSMutableArray *PP_Log_MessagesArray;

+ (instancetype)sharedInstance;

/**
 *  自定义Log
 *  @warning 外部可直接调用 KDS_Log
 *
 *  @param func         方法名
 *  @param lineNumber   行号
 *  @param format       Log内容
 *  @param ...          个数可变的Log参数
 */
void PPCustomLog(const char *func, int lineNumber, NSString *format, ...);


/**
 *  Log 输出开关 (默认关闭)
 *
 *  @param flag 是否开启
 */
+ (void)setLogEnable:(BOOL)flag;

/**
 *  是否开启了 Log 输出
 *
 *  @return Log 开关状态
 */
+ (BOOL)logEnable;

+ (BOOL)logMessagesEnable;

+ (void)setLogMessagesEnable:(BOOL)flag;

+ (NSString *)getAppLogUUID;

@end

NS_ASSUME_NONNULL_END
