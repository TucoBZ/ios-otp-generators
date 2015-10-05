//
//  MFATokenGeneratorTests.swift
//
// Copyright 2015 Codewise sp. z o.o. Sp. K.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import XCTest
@testable import OTPGenerator

class HOTPGeneratorTests: XCTestCase {

    let generator = HOTPGenerator(secret: "12345678901234567890", counter: 0, pinLength: 6, algorithm: .SHA1)

    func testInit() {
        XCTAssertNotNil(generator)
    }

    func testFailInit() {
        let gen = HOTPGenerator(secret: "12345678901234567890", counter: 0, pinLength: 0)
        XCTAssertNil(gen)
    }

    func testTokenConsistency() {
        XCTAssertEqual("755224", self.generator!.generateOTPForCounter(0))
        // make sure generating another token with same counter doesn't change the generator
        XCTAssertEqual("755224", self.generator!.generateOTPForCounter(0))
    }

    // http://www.ietf.org/rfc/rfc4226.txt
    // Appendix D - HOTP Algorithm: Test Values
    func testConsecutiveTokens() {
        let results = [
            "287082", "359152", "969429", "338314", "254676",
            "287922", "162583", "399871", "520489", "403154"
        ]

        for result in results {
            XCTAssertEqual(result, self.generator!.generateOTP())
        }
    }
}