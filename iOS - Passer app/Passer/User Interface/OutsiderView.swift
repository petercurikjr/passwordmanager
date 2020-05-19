//
//  Outsider.swift
//  Passer
//
//  Created by Peter Čuřík Jr. on 08/04/2020.
//  Copyright © 2020 Peter Čuřík Jr. All rights reserved.
//

import SwiftUI

struct OutsiderView: View {
    @State private var viewQRAlone = false
    @State private var viewDigitAlone = false
    @State private var oneOfThem = false
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var goBack: Bool
    
    @State private var animationAmount: CGFloat = 1
    @State private var doAnimation = false
    
    let chosenPasswords: [PasswordItem]
    let chosenBankCards: [BankCardItem]
    let chosenOthers: [OtherItem]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.goBack.toggle()
                    }) {
                        Image(systemName: "arrow.left")
                            .padding(.top, 20)
                            .padding(.leading, 25)
                    }.disabled(self.oneOfThem).opacity(self.oneOfThem ? 0 : 1).animation(Animation.easeInOut(duration: 0.5))
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .padding(.top, 20)
                            .padding(.trailing, 25)
                    }
                }
                 VStack {
                    HStack {
                        Text("Outsider")
                            .bold()
                            .font(.largeTitle)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Choose one of the verification methods below.")
                            .font(.subheadline)
                        Spacer()
                    }
                 }.padding(30).multilineTextAlignment(.leading).opacity(oneOfThem ? 0 : 1).animation(Animation.easeInOut(duration: 1).delay(0.2))
                
                VStack {
                    Button(action: {
                        self.triggerQR()
                    }) {
                        VStack {
                            OptionQR().opacity(viewDigitAlone ? 0 : 1).animation(Animation.easeInOut(duration: 1))
                        }.scaleEffect(self.animationAmount)
                        .animation(Animation.timingCurve(1, -1.3, 0.32, 1.6))
                        .contentShape(Rectangle())
                        
                    }.offset(y: viewQRAlone ? -120 : 0)
                    .animation(Animation.easeInOut.delay(0.5))
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .disabled(viewDigitAlone)

                    Button(action: {
                        self.triggerSixdigit()
                    }) {
                        VStack {
                            OptionSixdigit().opacity(viewQRAlone ? 0 : 1).animation(Animation.easeInOut(duration: 1))
                        }.scaleEffect(self.animationAmount)
                        .animation(Animation.timingCurve(1, -1.3, 0.32, 1.6))
                        .contentShape(Rectangle())
                    
                    }.offset(y: viewDigitAlone ? -300 : 0)
                    .animation(Animation.easeInOut.delay(0.5))
                    .buttonStyle(PlainButtonStyle())
                    .padding()
                    .disabled(viewQRAlone)
                }
                Spacer()
            }
           
            ZStack {
                ///condition so that it doesn't generate a new code once user closes the verification code option
                if self.viewDigitAlone {
                    CodeCountdownView(chosenPasswords: self.chosenPasswords, chosenBankCards: self.chosenBankCards, chosenOthers: self.chosenOthers)
                }
            }.opacity(viewDigitAlone ? 1 : 0).animation(Animation.easeInOut(duration: 0.4).delay(viewDigitAlone ? 1 : 0))
            
            ZStack {
                if self.viewQRAlone {
                QRScannerView(chosenPasswords: self.chosenPasswords, chosenBankCards: self.chosenBankCards, chosenOthers: self.chosenOthers)
                }
            }.opacity(viewQRAlone ? 1 : 0).animation(Animation.easeInOut(duration: 0.4).delay(viewQRAlone ? 1 : 0))
                
        }
    }
    
    func triggerSixdigit() {
        self.viewDigitAlone.toggle()
        self.viewQRAlone = false
        
        self.changeButton()
    }
    
    func triggerQR() {
        self.viewQRAlone.toggle()
        self.viewDigitAlone = false
        
        self.changeButton()
    }
    
    func changeButton() {
        if self.viewDigitAlone || self.viewQRAlone {
            oneOfThem = true
        }
        else {
            oneOfThem = false
        }
        
        if self.animationAmount == 1 {
            self.animationAmount += 0.1
        }
        else {
            self.animationAmount -= 0.1
        }
    }
}

struct Outsider_Previews: PreviewProvider {
    static var previews: some View {
        OutsiderView(goBack: .constant(false), chosenPasswords: [PasswordItem](), chosenBankCards: [BankCardItem](), chosenOthers: [OtherItem]())
    }
}
