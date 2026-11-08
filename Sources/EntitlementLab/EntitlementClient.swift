import Foundation

public protocol EntitlementClient: Sendable {
    func snapshot(for productID: String) async throws -> EntitlementSnapshot
}

public actor MockEntitlementClient: EntitlementClient {
    private var snapshots: [String: EntitlementSnapshot] = [:]

    public init() {}

    public func set(_ snapshot: EntitlementSnapshot) {
        snapshots[snapshot.productID] = snapshot
    }

    public func snapshot(for productID: String) async throws -> EntitlementSnapshot {
        snapshots[productID] ?? EntitlementSnapshot(productID: productID, state: .notPurchased)
    }
}
