//
//  SettingView.swift
//  Bible
//
//  Created by jge on 2020/08/18.
//  Copyright © 2020 jge. All rights reserved.
//

import SwiftUI
import StoreKit

struct SettingView: View {
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
                    }.onAppear {
                        print(product)
                    }
                }
                HStack {
                    Text("구매 복원하기")
                }.onTapGesture {
                    storeManager.restoreProducts()
                }
            }
        }
//        .listStyle(GroupedListStyle())
//        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("설정")
    }
}
//
//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView(storeManager: <#Binding<StoreManager>#>)
//    }
//}
