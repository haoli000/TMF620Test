import Foundation
import TMF620

// swift run swaggen generate ../TMF620/TMF620-ProductCatalog-v4.1.0.swagger.yaml --option name:TMF620 -d ../TMF620

print("Hello, TMF620")
print(TMF620.version)

let client = APIClient(baseURL: "http://192.168.206.50:1480/tmf-api/productCatalogManagement/v4")
let queue = DispatchQueue(label: "com.app.queue")

func listCatalogs() async -> Void {
    await withUnsafeContinuation { continuation in
        let req = TMF620.Catalog.ListCatalog.Request()
        let creq = client.makeRequest(req, completionQueue: queue) { response in
            print("ListCatalog with \(response)")
            switch response.result {
            case .success(let rs):
                for r in rs.success! {
                    print(">>>>> \(r.id!) -> \(r.name!)")
                }
                continuation.resume()
            default:
                print(">>> failed: response: \(response)")
                continuation.resume()
            }
        }
    }
}

await listCatalogs()

func listProductOffering() async -> Void {
    await withUnsafeContinuation { continuation in
        
        let req2 = TMF620.ProductOffering.ListProductOffering.Request()
        let creq2 = client.makeRequest(req2, completionQueue: queue) { response in
            print("ListProductOffering with \(response)")
            switch response.result {
            case .success(let rs):
                for r in rs.success! {
                    print(">>>>> \(r.id!) -> \(r.name!)")
                }
                continuation.resume()
            default:
                print(">>> failed: response: \(response)")
                continuation.resume()
            }
        }
    }
}

await listProductOffering()

