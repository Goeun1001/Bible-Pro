//
//  mac-SettingView.swift
//  Bible-mac
//
//  Created by GoEun Jeong on 2020/12/07.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI

struct mac_SettingView: View {
    @State private var select = UserDefaults.standard.value(forKey: "selectedIndex") as! Int
    @State private var optionsTitle = ["한", "영"]
    @State private var showingAlert = false
    @State private var showModal = false
    @EnvironmentObject var storeManager: StoreManager
    
    var body: some View {
        List {
            Section(header: Text("환경설정")) {
                HStack {
                    Text("성경 한/영 전환")
                    Spacer()
                    Picker("Articles", selection: $select) {
                        ForEach(0 ..< optionsTitle.count) { index in
                            Text(self.optionsTitle[index])
                        }
                    }.onReceive([self.select].publisher.first(), perform: { (value) in
                        if value == 0 {
                            UserDefaults.standard.set("GAE", forKey: "vcode")
                            UserDefaults.standard.set(0, forKey: "selectedIndex")
                            UserDefaults.standard.synchronize()
                        } else {
                            UserDefaults.standard.set("NIV", forKey: "vcode")
                            UserDefaults.standard.set(1, forKey: "selectedIndex")
                            UserDefaults.standard.synchronize()
                        }
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 90)
                }
            }
//            Section(header: Text("북마크")) {
//                NavigationLink(destination: BookmarkView()) {
//                    Text("북마크함")
//                }
//            }
            Section(header: Text("구매")) {
                ForEach(storeManager.myProducts, id: \.self) { product in
                    HStack {
                            Text("오디오 구매")
                        Spacer()
                        if storeManager.isPurchased {
                            Text("구매됨")
                                .foregroundColor(.green)
                        } else {
                            Button(action: {
                                storeManager.purchaseProduct(product: product)
                            }) {
                                Text("구매하기")
                            }
                                .foregroundColor(.blue)
                        }
                    }
                }
                HStack {
                    Text("구매 복원하기")
                }.onTapGesture {
                    storeManager.restoreProducts()
                }
            }
        }
    }
}


struct mac_SettingView_Previews: PreviewProvider {
    static var previews: some View {
        mac_SettingView()
    }
}
