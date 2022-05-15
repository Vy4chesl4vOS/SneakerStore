import SwiftUI

struct DeliveView: View {
    @StateObject var vm = DeliveViewModel()
        
    @Environment(\.presentationMode) var mod
    @EnvironmentObject var authVm: AuthViewModel
    @EnvironmentObject var cartVm: CartListViewModel
    
    @State private var showLocationPicker = false
    
    var body: some View {
        VStack {
       headerView
        .padding()
           subHeaderView
            mainInterface
            Spacer()
            Text("Delivery time: 3-7 day's")
                .foregroundColor(.black)
                .font(Font.custom("Poppins-Medium", size: 18))
                .padding()
            if vm.location != nil {
                Button {
                 vm.makeOrder(totalPrice: Int(cartVm.computeTotalPrice()), status: "In Work", longitude: vm.location?.coordinate.longitude ?? 10, latitude: vm.location?.coordinate.latitude ?? 10, sneakers: cartVm.sneakers)
                    cartVm.deleteAll()
                    NotificationManager.shared.sendDeliveryNotification()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        mod.wrappedValue.dismiss()
                    }
                } label: {
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .foregroundColor(.white)
                        Text("Pay")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 18))
                    }
                    .padding(.horizontal, 100)
                    .padding(.vertical, 15)
                    .background(.black)
                    .cornerRadius(15)
                }
            }

    }
        .sheet(isPresented: $showLocationPicker) {
            PlacePickerView()
                .environmentObject(vm)
        }
}
    private var headerView : some View {
        HStack {
            Button {
                mod.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.red)
                    .font(.title2)
            }
            Spacer()
            Text("Delivery")
                .font(Font.custom("Poppins-Bold", size: 28))
            Spacer()
        }
    }
    
    private var subHeaderView : some View {
        VStack(alignment: .leading) {
            let username = authVm.currentUser?.fullname.components(separatedBy: " ")
            Text("Hey, \(username?.first ?? "User")")
                .font(Font.custom("Poppins-Bold", size: 30))
                .padding()
            HStack( spacing: 5) {
//
                Image(systemName: "airplane.departure")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                Text("Let's choose place to ship")
                    .font(Font.custom("Poppins-Bold", size: 20))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 60)
            .background(.linearGradient(colors: [.purple, .orange], startPoint: .top, endPoint: .bottom))
            .cornerRadius(30)
            .padding(.horizontal, 10)
            }
    }
    
    private var mainInterface : some View {
        VStack {
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 45))
                Button {
                    vm.checkLocationManagerWork()
                } label: {
                    Text("Use current location")
                        .foregroundColor(.white)
                        .padding(.horizontal, 70)
                        .padding(.vertical, 15)
                        .background(.orange)
                        .cornerRadius(30)
                        .font(Font.custom("Poppins-Medium", size: 16))
                }
                

            }
            .background(.gray.opacity(0.2))
            .cornerRadius(30)
            HStack {
                Image(systemName: "map.circle.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 45))
                    .cornerRadius(45)
                Button {
                    showLocationPicker.toggle()
                } label: {
                    Text("Choose location")
                        .foregroundColor(.white)
                        .padding(.horizontal, 90)
                        .padding(.vertical, 15)
                        .background(.linearGradient(colors: [.orange, .yellow], startPoint: .top, endPoint: .bottom))
                        .cornerRadius(30)
                        .font(Font.custom("Poppins-Medium", size: 16))
                }

            }
            .background(.gray.opacity(0.2))
            .cornerRadius(30)
            
            VStack(alignment: .leading ,spacing: 20) {
                HStack(spacing: 2) {
                    Text("Correct address: ")
                        .font(Font.custom("Poppins-Medium", size: 16))
                    if vm.location == nil {
                        Image(systemName: "multiply")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
            }
            .padding(.top, 20)
        }
    }
}

struct DeliveView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveView()
            .environmentObject(AuthViewModel())
    }
}
