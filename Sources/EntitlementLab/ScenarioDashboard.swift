import SwiftUI

/// Interactive, entirely local scenario explorer. Does not create StoreKit purchases.
@MainActor
public struct ScenarioDashboard: View {
    private let productID: String
    @State private var scenario: SubscriptionScenario = .active

    public init(productID: String) {
        self.productID = productID
    }

    public var body: some View {
        VStack {
            Picker("Test scenario", selection: $scenario) {
                ForEach(SubscriptionScenario.allCases) { item in
                    Text(item.title).tag(item)
                }
            }
            .padding()
            EntitlementDashboard(snapshot: scenario.snapshot(productID: productID))
        }
    }
}
