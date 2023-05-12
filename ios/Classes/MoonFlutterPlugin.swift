import Flutter
import UIKit

public class MoonFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "moon_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = MoonFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getBatteryLevel"{
        let device = UIDevice.current
        let batter = Int(device.batteryLevel * 100)
        print(batter)
//         result(String(batter))
        result("77")
    }else if call.method == "getPlatformVersion"{
      result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "add" {
        guard let args = call.arguments as? [String: Any] else {
          return
        }

        if let a1 = args["param1"] as? Int {
          let r = a1 + 5
          result(r)
        } else {
          return
        }

    } else if call.method == "getResource" {
        guard let args = call.arguments as? [String: Any] else {
                  return
                }

            if let resourceName = args["resourceName"] as? String {
                do {
                    var r = try getAssetResourceByName(resourceName)
                    if r != nil {
                        result(r)
                    }
                }catch {
                    print("bundle....error ")
                }
                
                
                } else {
                   return
                }
    }
    else {
      result("Unknow")
    }
  }

  func getAssetResourceByName(_ imageName: String) throws -> Data? {
      var image: UIImage? = nil
      if image == nil {
          image = UIImage(named: imageName)
          if image == nil {
              
              var rr = self.tj_refreshBundle().path(forResource: imageName, ofType: "png")
              if rr == nil {
                  throw BundleGetError.bundleError
//                  return nil
              }
              image = UIImage(contentsOfFile: rr!)?.withRenderingMode(.alwaysOriginal)
          }
          if image == nil {
              image = UIImage(contentsOfFile: self.tj_refreshBundle().path(forResource: "\(imageName)@\((Int(UIScreen.main.scale)))x", ofType: "png")!)?.withRenderingMode(.alwaysOriginal)
          }
      }
      if image == nil {
          return nil
      }
      return image?.pngData()
  }

  func tj_refreshBundle() -> Bundle {
      var refreshBundle: Bundle? = nil
      if refreshBundle == nil {
          let currentBundle = Bundle(for: type(of: self))
          let r = currentBundle.path(forResource: "selfBundleName", ofType: "bundle")
          if r == nil{
              return Bundle.main
          }
          refreshBundle = Bundle(path: r!)
          if refreshBundle == nil {
              refreshBundle = Bundle.main
          }
      }
      
      return refreshBundle!
  }


}


enum BundleGetError : Error {
    case bundleError
}
