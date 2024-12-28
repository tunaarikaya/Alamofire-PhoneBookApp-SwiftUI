
import Foundation
import Alamofire

class KisiKayitViewModel {
    func kaydet(kisi_ad:String,kisi_tel:String){
        let url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php"
        let params:Parameters = ["kisi_ad":kisi_ad,"kisi_tel":kisi_tel]
        
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
