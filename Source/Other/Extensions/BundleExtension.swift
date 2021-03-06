//
//  BundleExtension.swift
//  Sequel Ace
//
//  Created by James on 4/12/2020.
//  Copyright © 2020 Sequel-Ace. All rights reserved.
//

import Foundation

@objc extension Bundle {

	public var appName: String? {

		if let info = self.infoDictionary {
			if let appName = info[kCFBundleNameKey as String]{
				return appName as? String
			}
		}
		return nil
	}

	/// Attempts to get the ."Sequel Ace URL scheme" from Info.plist
	/// We are looking for, see below
//	<key>CFBundleURLTypes</key>
//		<array>
//			<dict>
//				<key>CFBundleTypeRole</key>
//				<string>Editor</string>
//				<key>CFBundleURLName</key>
//				<string>Sequel Ace URL scheme</string>
//				<key>CFBundleURLSchemes</key>
//				<array>
//					<string>sequelace</string>     <--------- WE ARE LOOKING FOR THIS!
//				</array>
//			</dict>
//			<dict>
//				<key>CFBundleURLName</key>
//				<string>MySQL URL scheme</string>
//				<key>CFBundleURLSchemes</key>
//				<array>
//					<string>mysql</string>
//				</array>
//			</dict>
//		</array>
	public var saURLScheme: String? {
		guard let bundleURLTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] else {
			return nil
		}

		let expectedDictionary = bundleURLTypes.first { $0["CFBundleURLName"] as? String == "Sequel Ace URL scheme" }
		return [(expectedDictionary?["CFBundleURLSchemes"] as? [String])?.first?.trimmedString,"://"].compactMap { $0 }.joined(separator: "")

	}
}
