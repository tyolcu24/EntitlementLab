import Foundation
import StoreKit

/// Reads StoreKit 2's verified current entitlements.
/// Renewal metadata and grace/billing-retry classification are intentionally
/// not inferred here; a later version will use subscription status APIs.
public struct StoreKitEntitlementClient: EntitlementClient {
    public init() {}

    public func snapshot(for productID: String) async throws -> EntitlementSnapshot {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result,
                  transaction.productID == productID else { continue }
            let state: SubscriptionState = transaction.revocationDate == nil ? .active : .revoked
            return EntitlementSnapshot(productID: productID, state: state,
                                       expirationDate: transaction.expirationDate)
        }
        return EntitlementSnapshot(productID: productID, state: .notPurchased)
    }
}
