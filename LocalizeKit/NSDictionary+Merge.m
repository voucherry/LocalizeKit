#import "NSDictionary+Merge.h"


@implementation NSDictionary (Merge)

+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dict1];
  [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
    if (dict1[key]==nil) {
      result[key] = obj;
    } else {
      if ([dict1[key] isKindOfClass:[NSDictionary class]] && [obj isKindOfClass:[NSDictionary class]]) {
        result[key] = [NSDictionary dictionaryByMerging:dict1[key] with:obj];
      } else {
        result[key] = obj;
      }
    }
  }];
  return (NSDictionary *)result;
}

- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict {
  return [[self class] dictionaryByMerging:self with:dict];
}

@end