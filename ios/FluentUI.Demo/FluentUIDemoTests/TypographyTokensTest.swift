//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import XCTest

class TypographyTokensTest: BaseTest {
    override var controlName: String { "TypographyTokens" }

    // launch test that ensures the demo app does not crash and is on the correct control page
    func testLaunch() throws {
        XCTAssertTrue(app.navigationBars[controlName].exists)
    }
}
