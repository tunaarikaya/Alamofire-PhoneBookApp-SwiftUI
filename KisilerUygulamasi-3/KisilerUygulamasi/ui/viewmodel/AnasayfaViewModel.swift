
import Foundation
import Alamofire

class AnasayfaViewModel : ObservableObject{
    @Published var kisilerListesi = [Kisiler]()
    
    func kisileriYukle(){
        let url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php"
        
        AF.request(url,method: .get).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                    if let liste = cevap.kisiler {
                        DispatchQueue.main.async {
                            self.kisilerListesi = liste
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func ara(aramaKelimesi:String){
        let url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php"
        let params:Parameters = ["kisi_ad":aramaKelimesi]
        
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(KisilerCevap.self, from: data)
                    if let liste = cevap.kisiler {
                        DispatchQueue.main.async {
                            self.kisilerListesi = liste
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sil(kisi_id:Int){
        let url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php"
        let params:Parameters = ["kisi_id":kisi_id]
        
        AF.request(url,method: .post,parameters: params).response { response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(CRUDCevap.self, from: data)
                    print("Başarı : \(cevap.success!)")
                    print("Mesaj  : \(cevap.message!)")
                    self.kisileriYukle()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
