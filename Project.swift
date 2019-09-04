import ProjectDescription

let project = Project(
    name: "AppDelegate",
    targets: [
        .init(
            name: "AppDelegate",
            platform: .iOS,
            product: .app,
            bundleId: "com.jasonnam.AppDelegate",
            infoPlist: "Debug/Info.plist",
            sources: [
                "Debug/AppDelegateMain.swift",
                "Sources/AppDelegate/**"
            ]
        )
    ]
)
