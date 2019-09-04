//
//  AppDelegate.swift
//  AppDelegate
//
//  Copyright (c) 2019 Jason Nam (https://jasonnam.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import UserNotifications
import Intents
import CloudKit

open class AppDelegate: UIResponder, UIApplicationDelegate {

    open var plugins: [UIApplicationDelegate] = []

    open var window: UIWindow?

    public override init() {
        super.init()
    }

    public init(window: UIWindow) {
        super.init()
        self.window = window
    }

    @discardableResult
    open func evaluate<Result, Return>(work: (UIApplicationDelegate, @escaping (Result) -> Void) -> Return?, completionHandler: @escaping ([Result]) -> Void) -> [Return] {
        let dispatchGroup = DispatchGroup()

        var results: [Result] = []
        var returns: [Return] = []

        for plugin in plugins {
            dispatchGroup.enter()

            let `return` = work(plugin) {
                results.append($0)
                dispatchGroup.leave()
            }

            if let `return` = `return` {
                returns.append(`return`)
            } else {
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completionHandler(results)
        }

        return returns
    }

    @available(iOS 2.0, *)
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        plugins.forEach { $0.applicationDidFinishLaunching?(application) }
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return plugins.reduce(true, { $0 && ($1.application?(application, willFinishLaunchingWithOptions: launchOptions) ?? true) })
    }

    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return plugins.reduce(true, { $0 && ($1.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true) })
    }

    @available(iOS 2.0, *)
    open func applicationDidBecomeActive(_ application: UIApplication) {
        plugins.forEach { $0.applicationDidBecomeActive?(application) }
    }

    @available(iOS 2.0, *)
    open func applicationWillResignActive(_ application: UIApplication) {
        plugins.forEach { $0.applicationWillResignActive?(application) }
    }

    @available(iOS, introduced: 2.0, deprecated: 9.0)
    open func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, handleOpen: url) ?? false) })
    }

    @available(iOS, introduced: 4.2, deprecated: 9.0)
    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation) ?? false) })
    }

    @available(iOS 9.0, *)
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(app, open: url, options: options) ?? false) })
    }

    @available(iOS 2.0, *)
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        plugins.forEach { $0.applicationDidReceiveMemoryWarning?(application) }
    }

    @available(iOS 2.0, *)
    open func applicationWillTerminate(_ application: UIApplication) {
        plugins.forEach { $0.applicationWillTerminate?(application) }
    }

    @available(iOS 2.0, *)
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        plugins.forEach { $0.applicationSignificantTimeChange?(application) }
    }

    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, willChangeStatusBarOrientation newStatusBarOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        plugins.forEach { $0.application?(application, willChangeStatusBarOrientation: newStatusBarOrientation, duration: duration) }
    }

    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, didChangeStatusBarOrientation oldStatusBarOrientation: UIInterfaceOrientation) {
        plugins.forEach { $0.application?(application, didChangeStatusBarOrientation: oldStatusBarOrientation) }
    }

    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {
        plugins.forEach { $0.application?(application, willChangeStatusBarFrame: newStatusBarFrame) }
    }

    @available(iOS 2.0, *)
    open func application(_ application: UIApplication, didChangeStatusBarFrame oldStatusBarFrame: CGRect) {
        plugins.forEach { $0.application?(application, didChangeStatusBarFrame: oldStatusBarFrame) }
    }

    @available(iOS, introduced: 8.0, deprecated: 10.0)
    open func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        plugins.forEach { $0.application?(application, didRegister: notificationSettings) }
    }

    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        plugins.forEach { $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }

    @available(iOS 3.0, *)
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        plugins.forEach { $0.application?(application, didFailToRegisterForRemoteNotificationsWithError: error) }
    }

    @available(iOS, introduced: 3.0, deprecated: 10.0)
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        plugins.forEach { $0.application?(application, didReceiveRemoteNotification: userInfo) }
    }

    @available(iOS, introduced: 4.0, deprecated: 10.0)
    open func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        plugins.forEach { $0.application?(application, didReceive: notification) }
    }

    @available(iOS, introduced: 8.0, deprecated: 10.0)
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        evaluate(
            work: { appDelegate, completionHandler in
                appDelegate.application?(application, handleActionWithIdentifier: identifier, for: notification) { completionHandler(()) }
            },
            completionHandler: { _ in
                completionHandler()
            }
        )
    }

    @available(iOS, introduced: 9.0, deprecated: 10.0)
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        evaluate(
            work: { appDelegate, completionHandler in
                appDelegate.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: responseInfo) { completionHandler(()) }
            },
            completionHandler: { _ in
                completionHandler()
            }
        )
    }

    @available(iOS, introduced: 8.0, deprecated: 10.0)
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        evaluate(
            work: { appDelegate, completionHandler in
                appDelegate.application?(application, handleActionWithIdentifier: identifier, forRemoteNotification: userInfo) { completionHandler(()) }
            },
            completionHandler: { _ in
                completionHandler()
            }
        )
    }

    @available(iOS, introduced: 9.0, deprecated: 10.0)
    open func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        evaluate(
            work: { appDelegate, completionHandler in
                appDelegate.application?(application, handleActionWithIdentifier: identifier, for: notification, withResponseInfo: responseInfo) { completionHandler(()) }
            },
            completionHandler: { _ in
                completionHandler()
            }
        )
    }

    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        evaluate(
            work: {
                $0.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: $1)
            },
            completionHandler: {
                let result = $0.min(by: { $0.rawValue < $1.rawValue }) ?? .noData
                completionHandler(result)
            }
        )
    }

    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        evaluate(
            work: {
                $0.application?(application, performFetchWithCompletionHandler: $1)
            },
            completionHandler: {
                let result = $0.min(by: { $0.rawValue < $1.rawValue }) ?? .noData
                completionHandler(result)
            }
        )
    }

    @available(iOS 9.0, *)
    open func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        evaluate(
            work: {
                $0.application?(application, performActionFor: shortcutItem, completionHandler: $1)
            },
            completionHandler: {
                let result = $0.reduce(false, { $0 || $1 })
                completionHandler(result)
            }
        )
    }

    @available(iOS 7.0, *)
    open func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        evaluate(
            work: { appDelegate, completionHandler in
                appDelegate.application?(application, handleEventsForBackgroundURLSession: identifier) { completionHandler(()) }
            },
            completionHandler: { _ in
                completionHandler()
            }
        )
    }

    @available(iOS 8.2, *)
    open func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?, reply: @escaping ([AnyHashable: Any]?) -> Void) {
        evaluate(
            work: {
                $0.application?(application, handleWatchKitExtensionRequest: userInfo, reply: $1)
            },
            completionHandler: {
                let results = $0.reduce([:]) { results, result in
                    var results = results
                    for (key, value) in result ?? [:] {
                        results[key] = value
                    }
                    return results
                }
                reply(results)
            }
        )
    }

    @available(iOS 9.0, *)
    open func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        plugins.forEach { $0.applicationShouldRequestHealthAuthorization?(application) }
    }

    @available(iOS 11.0, *)
    open func application(_ application: UIApplication, handle intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {
        evaluate(
            work: {
                $0.application?(application, handle: intent, completionHandler: $1)
            }, completionHandler: {
                if let last = $0.last {
                    completionHandler(last)
                }
            }
        )
    }

    @available(iOS 4.0, *)
    open func applicationDidEnterBackground(_ application: UIApplication) {
        plugins.forEach { $0.applicationDidEnterBackground?(application) }
    }

    @available(iOS 4.0, *)
    open func applicationWillEnterForeground(_ application: UIApplication) {
        plugins.forEach { $0.applicationWillEnterForeground?(application) }
    }

    @available(iOS 4.0, *)
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        plugins.forEach { $0.applicationProtectedDataWillBecomeUnavailable?(application) }
    }

    @available(iOS 4.0, *)
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        plugins.forEach { $0.applicationProtectedDataDidBecomeAvailable?(application) }
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return plugins.reduce([], {
            var interfaceOrientationMask = $0
            if let supportedInterfaceOrientations = $1.application?(application, supportedInterfaceOrientationsFor: window) {
                interfaceOrientationMask.formUnion(supportedInterfaceOrientations)
            }
            return interfaceOrientationMask
        })
    }

    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, shouldAllowExtensionPointIdentifier: extensionPointIdentifier) ?? false) })
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        let viewControllers = plugins.compactMap { $0.application?(application, viewControllerWithRestorationIdentifierPath: identifierComponents, coder: coder) }
        return viewControllers.last
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, shouldSaveApplicationState: coder) ?? false) })
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, shouldRestoreApplicationState: coder) ?? false) })
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        plugins.forEach { $0.application?(application, willEncodeRestorableStateWith: coder) }
    }

    @available(iOS 6.0, *)
    open func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        plugins.forEach { $0.application?(application, didDecodeRestorableStateWith: coder) }
    }

    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return plugins.reduce(false, { $0 || ($1.application?(application, willContinueUserActivityWithType: userActivityType) ?? false) })
    }

    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let returns = evaluate(
            work: {
                return $0.application?(application, continue: userActivity, restorationHandler: $1)
            },
            completionHandler: {
                let result = $0.reduce([], { $0 + ($1 ?? []) })
                restorationHandler(result)
            }
        )
        return returns.reduce(false, { $0 || $1 })
    }

    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        plugins.forEach { $0.application?(application, didFailToContinueUserActivityWithType: userActivityType, error: error) }
    }

    @available(iOS 8.0, *)
    open func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        plugins.forEach { $0.application?(application, didUpdate: userActivity) }
    }

    @available(iOS 10.0, *)
    open func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        plugins.forEach { $0.application?(application, userDidAcceptCloudKitShareWith: cloudKitShareMetadata) }
    }
}
