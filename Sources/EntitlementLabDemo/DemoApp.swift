import SwiftUI
import EntitlementLab

@main
struct EntitlementLabDemoApp: App {
    var body: some Scene {
        WindowGroup("EntitlementLab Demo") {
            NavigationStack {
                ScenarioDashboard(productID: "com.example.entitlementlab.premium")
                    .navigationTitle("EntitlementLab")
            }
            .frame(minWidth: 520, minHeight: 420)
        }
    }
}
