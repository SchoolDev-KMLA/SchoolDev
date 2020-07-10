//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <cloud_firestore/CloudFirestorePlugin.h>
#import <dynamic_list_view/DynamicListViewPlugin.h>
#import <firebase_auth/FirebaseAuthPlugin.h>
#import <firebase_core/FirebaseCorePlugin.h>
#import <firebase_storage/FirebaseStoragePlugin.h>
#import <flutter_appavailability/AppAvailability.h>
#import <flutter_launch/FlutterLaunchPlugin.h>
#import <google_sign_in/GoogleSignInPlugin.h>
#import <intro_slider/IntroSliderPlugin.h>
#import <share/SharePlugin.h>
#import <sqflite/SqflitePlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTCloudFirestorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTCloudFirestorePlugin"]];
  [DynamicListViewPlugin registerWithRegistrar:[registry registrarForPlugin:@"DynamicListViewPlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FLTFirebaseStoragePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseStoragePlugin"]];
  [AppAvailability registerWithRegistrar:[registry registrarForPlugin:@"AppAvailability"]];
  [FlutterLaunchPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterLaunchPlugin"]];
  [FLTGoogleSignInPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleSignInPlugin"]];
  [IntroSliderPlugin registerWithRegistrar:[registry registrarForPlugin:@"IntroSliderPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
}

@end
