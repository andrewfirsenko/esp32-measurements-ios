// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum InfoPlist {
    /// ESP32 Readings
    internal static let cfBundleDisplayName = Strings.tr("InfoPlist", "CFBundleDisplayName", fallback: "ESP32 Readings")
  }
  internal enum Localizable {
    internal enum InputDeviceId {
      /// Next
      internal static let button = Strings.tr("Localizable", "input_device_id.button", fallback: "Next")
      /// It will be used to identify the device
      internal static let description = Strings.tr("Localizable", "input_device_id.description", fallback: "It will be used to identify the device")
      /// Localizable.strings
      ///   ESP32Measurements
      /// 
      ///   Created by Andrew on 07.03.2026.
      internal static let title = Strings.tr("Localizable", "input_device_id.title", fallback: "Enter the Device ID")
    }
    internal enum MainDashboard {
      /// change
      internal static let change = Strings.tr("Localizable", "main_dashboard.change", fallback: "change")
    }
    internal enum Warning {
      /// Data cannot be received from the device
      internal static let connectionErrorDescription = Strings.tr("Localizable", "warning.connection_error_description", fallback: "Data cannot be received from the device")
      /// Connection error
      internal static let connectionErrorTitle = Strings.tr("Localizable", "warning.connection_error_title", fallback: "Connection error")
      /// Try again
      internal static let tryAgain = Strings.tr("Localizable", "warning.try_again", fallback: "Try again")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
