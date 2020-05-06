//
//  PasserItemView.swift
//  Passer
//
//  Created by Peter Čuřík Jr. on 02/05/2020.
//  Copyright © 2020 Peter Čuřík Jr. All rights reserved.
//

import SwiftUI

struct PasserItemCell: View {
    
    let expanded: Bool
    let passwordItem: PasswordItem?
    let bankCardItem: BankCardItem?
    let otherItem: OtherItem?
    
    @State var chosenName = ""
    
    @State private var showOutsider = false
    @EnvironmentObject var vault: Vault
    
    var body: some View {
        VStack {
            if expanded && passwordItem != nil {
                VStack {
                    VStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Username or an email: ")
                                    .bold().font(.headline)
                                Text(passwordItem!.getUsername() ?? "")
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Password: ")
                                    .bold().font(.headline)
                                Text(passwordItem!.getPassword())
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Website: ")
                                    .bold().font(.headline)
                                Text(passwordItem!.getUrl() ?? "")
                            }
                        }.padding().padding(.top).padding(.bottom)
                        
                        Divider()
                        
                        VStack {
                            Text("Password strength:")
                                .bold()
                            Text("Good")
                                .foregroundColor(Color.green)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            self.showOutsider = true
                            print("Outsider button tapped")
                        }) {
                            ButtonUI(name: "Outsider")
                            
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            
                        }) {
                            ButtonUI(name: "Edit")
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }.background(Color("gray2").opacity(0.1).shadow(radius: 30)).cornerRadius(25)
                .onAppear(perform: {
                    self.chosenName = self.passwordItem!.getItemName()
                })
            }
                    
            else if expanded && bankCardItem != nil {
                VStack {
                    VStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Card number: ")
                                    .bold().font(.headline)
                                Text(bankCardItem!.getCardNumber())
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Expire date: ")
                                    .bold().font(.headline)
                                Text(bankCardItem!.getExpireDate())
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("CVV/CVC number: ")
                                    .bold().font(.headline)
                                Text(bankCardItem!.getCvv())
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("PIN: ")
                                    .bold().font(.headline)
                                Text(bankCardItem!.getPin() ?? "")
                            }
                        }.padding().padding(.top).padding(.bottom)
                        
                        Divider()
                        
                        VStack {
                            Text("Password strength:")
                                .bold()
                            Text("Good")
                                .foregroundColor(Color.green)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            self.showOutsider = true
                            print("Outsider button tapped")
                        }) {
                            ButtonUI(name: "Outsider")
                            
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            
                        }) {
                            ButtonUI(name: "Edit")
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }.background(Color("gray2").opacity(0.1).shadow(radius: 30)).cornerRadius(25)
                .onAppear(perform: {
                    self.chosenName = self.bankCardItem!.getItemName()
                })
            }
                
            else if expanded && otherItem != nil {
                VStack {
                    VStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Field1: ")
                                    .bold().font(.headline)
                                Text(otherItem!.getField1() ?? "")
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Field2: ")
                                    .bold().font(.headline)
                                Text(otherItem!.getField2() ?? "")
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Field3: ")
                                    .bold().font(.headline)
                                Text(otherItem!.getField3() ?? "")
                            }.padding(.bottom)
                            VStack(alignment: .leading) {
                                Text("Field4: ")
                                    .bold().font(.headline)
                                Text(otherItem!.getField4() ?? "")
                            }
                        }.padding().padding(.top).padding(.bottom)
                        
                        Divider()
                        
                        VStack {
                            Text("Password strength:")
                                .bold()
                            Text("Good")
                                .foregroundColor(Color.green)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack(alignment: .center) {
                        Button(action: {
                            self.showOutsider = true
                        }) {
                            ButtonUI(name: "Outsider")
                            
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            
                        }) {
                            ButtonUI(name: "Edit")
                        }.scaleEffect(0.8)
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }.background(Color("gray2").opacity(0.1).shadow(radius: 30)).cornerRadius(25)
                .onAppear(perform: {
                    self.chosenName = self.otherItem!.getItemName()
                })
            }
        }
        .sheet(isPresented: self.$showOutsider) {
            OutsiderFirstView(chosenPassword: self.passwordItem, chosenBankCard: self.bankCardItem, chosenOther: self.otherItem, chosenName: self.chosenName)
                .environmentObject(self.vault)
        }
    }
}

struct PasserItemCell_Previews: PreviewProvider {
    static var previews: some View {
        PasserItemCell(expanded: true, passwordItem: nil, bankCardItem: nil, otherItem: nil)
    }
}
