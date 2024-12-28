
import SwiftUI

struct Anasayfa: View {
    @State private var aramaKelimesi = ""
    
    @ObservedObject private var viewModel = AnasayfaViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.kisilerListesi){ kisi in
                    NavigationLink(destination: KisiDetaySayfa(kisi: kisi)){
                        KisilerSatir(kisi: kisi)
                    }
                }.onDelete(perform: sil)
            }.navigationTitle("Kişiler")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: KisiKayitSayfa()){
                            Image(systemName: "plus")
                        }
                    }
                }.onAppear{
                    viewModel.kisileriYukle()
                }
        }.searchable(text: $aramaKelimesi,prompt: "Ara")
            .onChange(of: aramaKelimesi){ _ , s in
                viewModel.ara(aramaKelimesi: s)
            }
    }
    
    func sil(at offsets:IndexSet){
        let kisi = viewModel.kisilerListesi[offsets.first!]
        viewModel.sil(kisi_id: Int(kisi.kisi_id!)!)
    }
}

#Preview {
    Anasayfa()
}
