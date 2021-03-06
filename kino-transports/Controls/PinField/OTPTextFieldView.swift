//
//  CustomPinField.swift
//  kino-transports
//
//  Created by Alfredo Vidinhas on 20/12/21.
//

import SwiftUI
import SwiftUIX

public struct OTPTextFieldView: View {
    
    var maxDigits: Int = 6
    
    @State var pin: String = ""
    @State var isDisabled = false
    @State var error = false

    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            ZStack {
                pinDots
                backgroundField
            }
        }
        
    }
    
    private var pinDots: some View {
        HStack(spacing:10) {
            ForEach(0..<maxDigits) { index in
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.clear)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 5)            .stroke(Color(.lightGray), lineWidth: 0.5))
                        .frame(width: 45, height: 50)
                    
                    
                    Text(self.getDigits(at: index))
                        .font(.system(size: 40, weight: .thin, design: .default))
                }
                

            }
        }
        .padding(.horizontal)
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return CocoaTextField("", text: boundPin, onCommit: submitPin)
            .keyboardType(.numberPad)
            .isFirstResponder(true)
            .foregroundColor(.clear)
            .accentColor(.clear)
    }
    
    

    private func submitPin() {
        guard !pin.isEmpty else {
            return
        }
        
        if pin.count == maxDigits {
            isDisabled = true
            
            handler(pin) { isSuccess in
                if isSuccess {
                    error = false
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    //pin = ""
                    isDisabled = false
                    error = true
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getDigits(at index: Int) -> String {
        if index >= self.pin.count {
            return ""
        }
        
            return self.pin.digits[index].numberString
    }
}

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}

struct PasscodeField_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView { otp, completionHandler in }
        
    }
}
