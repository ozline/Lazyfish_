//
//  UploadView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct UploadView: View {
    
    @State private var image = UIImage()
    @State private var image1 = UIImage()
    @State private var showSheet = false
    @State private var showSheet1 = false
    
    @State private var description = ""
    
    @State var selectedIndex = 0


    var body: some View {
        NavigationView{
            Form{
                Section("类别 & 描述"){
                    Picker(selection: $selectedIndex,label: Text("类型")){
                        ForEach(0 ..< Global.itemTypes.count){
                            Text(Global.itemTypes[$0].name ?? "NULL")
                        }
                    }
                    HStack{
                        Text("描述")
                        Spacer()
                        TextEditor(text: $description)
                            .lineSpacing(5)
                            .accentColor(.blue)
                    }
                }
                Section("价格 & 操作"){
                    
                }
                Section("实物图(点击上传)"){
                    HStack{
                        Image(uiImage: self.image)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                }
                                .onTapGesture {
                                    showSheet = true
                                }
                        Spacer()
                        Image(uiImage: self.image1)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet1) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image1)
                                }
                    }
                    HStack{
                        Image(uiImage: self.image)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                }
                                .onTapGesture {
                                    showSheet = true
                                }
                        Spacer()
                        Image(uiImage: self.image1)
                                .resizable()
                                .cornerRadius(50)
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet1) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image1)
                                }
                    }
                }
            }
            .navigationTitle("上闲置")
            .onAppear(){
            }
        }
    }
    
    private func upload(){
        
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
