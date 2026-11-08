import Foundation
import Testing
@testable import EntitlementLab

@Test func activeGrantsAccess() {
    #expect(SubscriptionState.active.hasAccess)
    #expect(SubscriptionState.gracePeriod.hasAccess)
}

@Test func expiredAndRevokedDenyAccess() {
    #expect(!SubscriptionState.expired.hasAccess)
    #expect(!SubscriptionState.revoked.hasAccess)
    #expect(!SubscriptionState.billingRetry.hasAccess)
}

@Test func mockDefaultsToNotPurchased() async throws {
    let client = MockEntitlementClient()
    let snapshot = try await client.snapshot(for: "com.example.premium")
    #expect(snapshot.state == .notPurchased)
}

@Test func mockScenarioOverridesState() async throws {
    let client = MockEntitlementClient()
    await client.set(.init(productID: "premium", state: .active))
    let snapshot = try await client.snapshot(for: "premium")
    #expect(snapshot.state == .active)
}

@Test func cancellationDoesNotImmediatelyRemoveAccess() {
    let snapshot = SubscriptionScenario.cancelledButActive.snapshot(productID: "premium")
    #expect(snapshot.state.hasAccess)
    #expect(snapshot.willAutoRenew == false)
    #expect(snapshot.expirationDate != nil)
}

@Test func scenarioFixturesMatchAccessPolicy() {
    for scenario in SubscriptionScenario.allCases {
        let snapshot = scenario.snapshot(productID: "premium")
        #expect(snapshot.productID == "premium")
        let expected = [SubscriptionScenario.active, .cancelledButActive, .gracePeriod]
            .contains(scenario)
        #expect(snapshot.state.hasAccess == expected)
    }
}

@Test func mockCanSwitchScenarios() async throws {
    let client = MockEntitlementClient()
    await client.set(SubscriptionScenario.active.snapshot(productID: "premium"))
    #expect(try await client.snapshot(for: "premium").state == .active)
    await client.set(SubscriptionScenario.refunded.snapshot(productID: "premium"))
    #expect(try await client.snapshot(for: "premium").state == .revoked)
}
