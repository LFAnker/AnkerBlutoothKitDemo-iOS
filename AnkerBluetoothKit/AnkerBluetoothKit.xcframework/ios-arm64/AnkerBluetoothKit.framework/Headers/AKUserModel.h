//
//  AKUserModel.h
//  Pods
//
//  Created by lefu on 2024/2/23
//  


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AKUserAthleteLevel) {
    AKUserAthleteLevelNormal = 0, //普通
    AKUserAthleteLevelAmateur,    //业余
    AKUserAthleteLevelProfessional, //专业
};

typedef NS_ENUM(NSUInteger, AKUserGenderType) {
    AKUserGenderTypeFemale = 0, // 女性
    AKUserGenderTypeMale,   // 男性
};

@interface AKUserModel : NSObject
/// 用户ID
@property (nonatomic, copy) NSString *userID;
/// 运动员等级
@property (nonatomic, assign) AKUserAthleteLevel athleteLevel;
/// 年龄 [10-100]岁
@property (nonatomic, assign) NSInteger age;
/// 性别
@property (nonatomic, assign) AKUserGenderType gender;
/// 身高 cm
@property (nonatomic, assign) NSInteger height;
/// 体重（扩大100倍，如：50kg 传 5000）
@property (nonatomic, assign) NSInteger weight;

@end

NS_ASSUME_NONNULL_END
