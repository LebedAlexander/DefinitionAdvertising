import AdSupport

//MARK: - Protocols
protocol DefinitionAdvertisingDelegate {
    func definitionAttribution(isOrganic: Bool)
}

open class DefinitionAdvertising: NSObject {
    
    //MARK: - Singleton
    static let shared = DefinitionAdvertising()
    
    //MARK: - Properties
    var delegate: DefinitionAdvertisingDelegate?
    
    //MARK: - Configuration
    func configuration(appToken: String, completion: @escaping (_ isOrganic: Bool)->()){
        
        if let url = URL(string: "https://chksource.com/v1/conversion") {
            let json = ["idfa": ASIdentifierManager.shared().advertisingIdentifier.description, "app_token": appToken]
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
                            self.delegate?.definitionAttribution(isOrganic: (json["attributed"] as! Bool) ? false : true)
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

