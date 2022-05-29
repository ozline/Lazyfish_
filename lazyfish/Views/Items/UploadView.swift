//
//  UploadView.swift
//  lazyfish
//
//  Created by ozline on 2022/5/27.
//

import SwiftUI

struct UploadView: View {
    
    @State private var image1 = UIImage()
    @State private var image2 = UIImage()
    @State private var image3 = UIImage()
    @State private var image4 = UIImage()
    @State private var showSheet1 = false
    @State private var showSheet2 = false
    @State private var showSheet3 = false
    @State private var showSheet4 = false
    
    @State private var description = ""
    @State var selectedIndex = 0
    @State var oldPrice = ""
    @State var price = ""
    @State var title = ""


    var body: some View {
        NavigationView{
            Form{
                Section("实物图(点击上传)"){
                    HStack{
                        Image(uiImage: self.image1)
                                .resizable()
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet1) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image1)
                                }
                                .onTapGesture {
                                    showSheet1 = true
                                }
                        Spacer()
                        Image(uiImage: self.image2)
                                .resizable()
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet2) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image2)
                                }
                                .onTapGesture {
                                    showSheet2 = true
                                }
                    }
                    HStack{
                        Image(uiImage: self.image3)
                                .resizable()
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet3) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image3)
                                }
                                .onTapGesture {
                                    showSheet3 = true
                                }
                        Spacer()
                        Image(uiImage: self.image4)
                                .resizable()
                                .padding(.all, 4)
                                .frame(width: 100, height: 100)
                                .background(Color.black.opacity(0.2))
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Rectangle())
                                .padding(8)
                                .sheet(isPresented: $showSheet4) {
                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image4)
                                }
                                .onTapGesture {
                                    showSheet4 = true
                                }
                    }
                }
                Section("类别 & 描述"){
                    Picker(selection: $selectedIndex,label: Text("类型")){
                        ForEach(0 ..< Global.itemTypes.count){
                            Text(Global.itemTypes[$0].name ?? "NULL")
                        }
                    }
                    HStack{
                        Text("名称")
                        Spacer()
                        TextField("必填",text: $title)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.leading)
                    }
                    HStack{
                        Text("介绍")
                        Spacer()
                        TextEditor(text: $description)
                            .lineSpacing(5)
                            .accentColor(.blue)
                    }
                }
                Section("价格 & 操作"){
                    HStack{
                        Text("原价")
                        Spacer()
                        TextField("0.00",text: $oldPrice)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.leading)
                            .keyboardType(.numberPad)
                        Text("元")
                    }
                    HStack{
                        Text("现价")
                        Spacer()
                        TextField("0.00",text: $price)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.leading)
                            .keyboardType(.numberPad)
                        Text("元")
                    }
                    Button(action: upload){
                        Text("提交并审核")
                            .foregroundColor(.red)
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
