# EntitlementLab

**Swift 6 · StoreKit 2 · SwiftUI · iOS 17+ · macOS 14+**

An open-source entitlement debugging and subscription scenario toolkit.

> **v0.3 demo prototype:** Not production-ready subscription validation. The scenario explorer simulates states locally; it does not manipulate App Store purchases.

## Features

- Dependency-injectable `EntitlementClient` interface
- Actor-isolated `MockEntitlementClient`
- Minimal verified StoreKit 2 `Transaction.currentEntitlements` adapter
- Read-only `EntitlementDashboard`
- **NEW:** Interactive `ScenarioDashboard` with seven scenarios
- **NEW:** Cancellation-with-access and refund fixtures, plus tests
- Swift Testing tests and GitHub Actions CI

## Run the macOS demo

Open `Package.swift` in Xcode, select the `EntitlementLabDemo` scheme and **My Mac**, then press **Run (⌘R)**. The demo switches between seven simulated states. No App Store purchase is made.

## Quick start

Add the local package to your Xcode project, import `EntitlementLab`, then embed:

```swift
import SwiftUI
import EntitlementLab

struct ContentView: View {
    var body: some View {
        ScenarioDashboard(productID: "com.example.premium")
    }
}
```

Use the picker to switch between never purchased, active, cancelled-but-active, grace period, billing retry, expired, and refunded states.

For production-like inspection, use `StoreKitEntitlementClient` to obtain a snapshot and pass it to `EntitlementDashboard(snapshot:)`.

## Access policy

The sample policy grants access for `active` and `gracePeriod`. Billing retry is denied by default, but real access decisions must follow the actual App Store grace-period configuration and verified subscription status. A cancelled subscription may remain active until its paid period ends.

## Limitations

- The StoreKit adapter currently reads verified current entitlements only. It does not distinguish subscription status states (grace period, billing retry, expired) or determine auto-renewal.
- No transaction update observer, purchase flow, server validation, or multi-device sync guarantee.
- The scenario dashboard is an **in-memory simulator**, not a StoreKit sandbox controller.
- A successful Xcode **build** does not mean the test suite has passed. Run **Product → Test**.

## Next steps

1. Read subscription status / renewal info with StoreKit 2.
2. Observe `Transaction.updates` and refresh UI.
3. Build an example Xcode application and `.storekit` configuration.
4. Add integration tests and accessibility review.

## License

MIT
