import AdSupport

//MARK: - Protocols
public protocol DefinitionAdvertisingDelegate {
    func definitionAttribution(isOrganic: Bool)
}

open class DefinitionAdvertising: NSObject {
    
    //MARK: - Singleton
    public static let shared = DefinitionAdvertising()
    
    //MARK: - Properties
    public var delegate: DefinitionAdvertisingDelegate?
    
    //MARK: - Configuration
    public func configuration(appToken: String){
        
        if let url = URL(string: "https://chksource.com/v1/conversion") {
            
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
                        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]{
                            if let attributed = json["attributed"] as? Bool{
                                self.delegate?.definitionAttribution(isOrganic: attributed)
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

