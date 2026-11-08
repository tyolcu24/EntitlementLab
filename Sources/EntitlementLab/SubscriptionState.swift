import Foundation

public enum SubscriptionState: String, Sendable, CaseIterable, Identifiable {
    case active, gracePeriod, billingRetry, expired, revoked, notPurchased
    public var id: String { rawValue }
    public var hasAccess: Bool {
        switch self {
        case .active, .gracePeriod: true
        default: false
        }
    }
}

public struct EntitlementSnapshot: Sendable, Equatable {
    public let productID: String
    public let state: SubscriptionState
    public let expirationDate: Date?
    public let willAutoRenew: Bool?

    public init(productID: String, state: SubscriptionState,
                expirationDate: Date? = nil, willAutoRenew: Bool? = nil) {
        self.productID = productID
        self.state = state
        self.expirationDate = expirationDate
        self.willAutoRenew = willAutoRenew
    }
}
