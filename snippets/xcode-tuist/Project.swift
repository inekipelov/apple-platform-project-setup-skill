import ProjectDescription

let project = Project(
    name: "App",
    organizationName: "Example",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.example.App",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .default,
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.example.AppTests",
            infoPlist: .default,
            sources: ["App/Tests/**"],
            dependencies: [
                .target(name: "App"),
            ]
        ),
    ]
)
