#import "Globals.h"

@implementation Globals

- (void)setToken:(NSString *)s {
    NSLog(@"writing token:%@", s);
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)token {
    
    NSString* tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"TOKEN"];
    NSLog(@"retrieved token:%@", tok);
    return tok;
}
- (void)setExpires:(NSDate *)s {
    NSLog(@"writing expires:%@", s);
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"EXPIRES"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)expires {
    
    NSDate* tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"EXPIRES"];
    NSLog(@"retrieved expires:%@", tok);
    return tok;
}

- (void)setRefreshtoken:(NSString *)s {
    NSLog(@"writing refresh token:%@", s);
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"REFRESH_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)refreshtoken {
    
    NSString* tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"REFRESH_TOKEN"];
    NSLog(@"retrieved refresh token:%@", tok);
    return tok;
}

- (void)setHost:(NSString *)s {
    NSLog(@"writing host:%@", s);
    [[NSUserDefaults standardUserDefaults] setObject:s forKey:@"HOST"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)host {
    
    NSString* tok = [[NSUserDefaults standardUserDefaults] valueForKey:@"HOST"];
    NSLog(@"retrieved host:%@", tok);
    return tok;
}

#pragma mark Singleton Methods

+ (id)sharedManager {
    static Globals *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
