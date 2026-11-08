import Foundation

/// Deterministic fixtures for testing subscription UI and access policies.
public enum SubscriptionScenario: String, CaseIterable, Identifiable, Sendable {
    case neverPurchased, active, cancelledButActive, gracePeriod
    case billingRetry, expired, refunded

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .neverPurchased: "Never purchased"
        case .active: "Active subscription"
        case .cancelledButActive: "Cancelled (still active)"
        case .gracePeriod: "Billing grace period"
        case .billingRetry: "Billing retry"
        case .expired: "Expired subscription"
        case .refunded: "Refunded / revoked"
        }
    }

    public func snapshot(productID: String, now: Date = .now) -> EntitlementSnapshot {
        let day: TimeInterval = 86_400
        return switch self {
        case .neverPurchased:
            .init(productID: productID, state: .notPurchased)
        case .active:
            .init(productID: productID, state: .active,
                  expirationDate: now.addingTimeInterval(30 * day), willAutoRenew: true)
        case .cancelledButActive:
            .init(productID: productID, state: .active,
                  expirationDate: now.addingTimeInterval(12 * day), willAutoRenew: false)
        case .gracePeriod:
            .init(productID: productID, state: .gracePeriod,
                  expirationDate: now.addingTimeInterval(-day), willAutoRenew: true)
        case .billingRetry:
            .init(productID: productID, state: .billingRetry,
                  expirationDate: now.addingTimeInterval(-day), willAutoRenew: true)
        case .expired:
            .init(productID: productID, state: .expired,
                  expirationDate: now.addingTimeInterval(-10 * day), willAutoRenew: false)
        case .refunded:
            .init(productID: productID, state: .revoked, willAutoRenew: false)
        }
    }
}
