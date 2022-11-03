#import "AutoOrientationPlugin.h"

@implementation AutoOrientationPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"auto_orientation"
            binaryMessenger:[registrar messenger]];
  AutoOrientationPlugin* instance = [[AutoOrientationPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"setLandscapeRight" isEqualToString:call.method]) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    
    if ([@"setLandscapeLeft" isEqualToString:call.method]) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
    }
    
    if ([@"setPortraitUp" isEqualToString:call.method]) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }
    
    if ([@"setPortraitDown" isEqualToString:call.method]) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortraitUpsideDown) forKey:@"orientation"];
    }
    
    if ([@"setPortraitAuto" isEqualToString:call.method]) {
//        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        if (@available(iOS 16.0, *)) {
//            [self setNeedsUpdateOfSupportedInterfaceOrientations];
//            [self.navigationController setNeedsUpdateOfSupportedInterfaceOrientations];
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *scene = (UIWindowScene *)array[0];
            UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskPortrait];
            [scene requestGeometryUpdateWithPreferences:geometryPreferences
                                           errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"wuwuFQ：%@", error);
            }];
        } else {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        }
    }
    
    if ([@"setLandscapeAuto" isEqualToString:call.method]) {
        if (@available(iOS 16.0, *)) {
//            [self setNeedsUpdateOfSupportedInterfaceOrientations];
//            [self.navigationController setNeedsUpdateOfSupportedInterfaceOrientations];
            NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
            UIWindowScene *scene = (UIWindowScene *)array[0];
            UIWindowSceneGeometryPreferencesIOS *geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:UIInterfaceOrientationMaskLandscape];
            [scene requestGeometryUpdateWithPreferences:geometryPreferences
                                           errorHandler:^(NSError * _Nonnull error) {
                NSLog(@"wuwuFQ：%@", error);
            }];
        } else {
            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        }
    }
    
    if ([@"setAuto" isEqualToString:call.method]) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }

    [UIViewController attemptRotationToDeviceOrientation];

  result(FlutterMethodNotImplemented);
}

@end
