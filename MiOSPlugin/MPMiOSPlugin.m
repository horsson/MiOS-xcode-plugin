//
//  MPMiOSPlugin.m
//  MPMiOSPlugin
//
//  Created by Hu, Hao on 03/04/14.
//    Copyright (c) 2014 SAP AG. All rights reserved.
//

#import "MPMiOSPlugin.h"

static MPMiOSPlugin *sharedPlugin;

@interface MPMiOSPlugin()

@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation MPMiOSPlugin

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static id sharedPlugin = nil;
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource acccess
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.

        // Sample Menu Item:
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Product"];
        if (menuItem) {
            [menuItem.submenu addItem:[NSMenuItem separatorItem]];
            NSMenuItem *miosMenuItem = [[NSMenuItem alloc] initWithTitle:@"MiOS" action:nil keyEquivalent:@""];
            NSMenuItem* aInitiaMenuItem = [[NSMenuItem alloc] initWithTitle:@"Initialize" action:@selector(doMavenInitialize) keyEquivalent:@""];
            [aInitiaMenuItem setTarget:self];
            NSMenuItem* aCleanMenuItem = [[NSMenuItem alloc] initWithTitle:@"Clean" action:@selector(doMavneClean) keyEquivalent:@""];
            [aCleanMenuItem setTarget:self];
            NSMenu* miosMenu = [[NSMenu alloc] initWithTitle:@"MiOS"];
            miosMenuItem.submenu = miosMenu;
            [miosMenuItem.submenu addItem:aInitiaMenuItem];
            [miosMenuItem.submenu addItem:aCleanMenuItem];
            [menuItem.submenu addItem:miosMenuItem];
        }
    }
    return self;
}

#pragma mark - MenuItem action

-(void) doMavenInitialize
{
    
}


-(void) doMavneClean
{
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
