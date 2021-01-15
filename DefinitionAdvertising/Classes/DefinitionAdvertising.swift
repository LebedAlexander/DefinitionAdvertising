import AdSupport

//MARK: - Protocols
public protocol DefinitionAdvertisingDelegate {
    func definitionAttribution(isOrganic: Bool)
}

public protocol DefinitionRawRepresentable {
    var rawValue: String { get set }
}

open class DefinitionAdvertising: NSObject {
    
    //MARK: - Urls
    public struct Urls: DefinitionRawRepresentable {
        
        public var rawValue: String
        
        public static let chksource = Urls(rawValue: "https://chksource.com")
        public static let chkmob = Urls(rawValue: "https://check.chkmob.com")
        public static let bittiu = Urls(rawValue: "https://check.bittiu.com")
        public static let trklabs = Urls(rawValue: "https://check.trklabs.com")
        public static let devpng = Urls(rawValue: "https://check.devpng.com")
        public static let pingfront = Urls(rawValue: "https://check.pingfront.com")
    }
    
    //MARK: - Singleton
    public static let shared = DefinitionAdvertising()
    
    //MARK: - Properties
    public var delegate: DefinitionAdvertisingDelegate?
    
    //MARK: - Configuration
    public func configuration(appToken: String, url: Urls){
        
        if let url = URL(string: url.rawValue + "/v1/conversion") {
            
            let json = ["idfa": ASIdentifierManager.shared().advertisingIdentifier.description,
                        "app_token": appToken,
                        "app_version": (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "",
                        "os_version": UIDevice.current.systemVersion]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }else{
                        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject], json["attributed"] != nil{
                            if let attributed = json["attributed"] as? Bool{
                                self.delegate?.definitionAttribution(isOrganic: attributed ? false : true)
                            }
                        }
                    }
                }.resume()
            }else{
                print("Not valid JSON")
            }
        }else{
            print("Not valid URL")
        }
    }
}

