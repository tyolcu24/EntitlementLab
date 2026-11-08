import SwiftUI

/// An embeddable read-only dashboard for an entitlement snapshot.
@MainActor
public struct EntitlementDashboard: View {
    public let snapshot: EntitlementSnapshot

    public init(snapshot: EntitlementSnapshot) {
        self.snapshot = snapshot
    }

    public var body: some View {
        Form {
            Section("Subscription") {
                LabeledContent("Product ID", value: snapshot.productID)
                LabeledContent("State", value: snapshot.state.rawValue)
                LabeledContent("Access", value: snapshot.state.hasAccess ? "Granted" : "Denied")
                if let date = snapshot.expirationDate {
                    LabeledContent("Expires") { Text(date, style: .date) }
                }
                if let autoRenew = snapshot.willAutoRenew {
                    LabeledContent("Auto-renew", value: autoRenew ? "On" : "Off")
                }
            }
        }
    }
}
