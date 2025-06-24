//
//  HomeView.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import SwiftUI
import PhotosUI

struct HomeView: View {
    @State private var selectedImage: UIImage?
    @State private var showingPicker = false
    @State private var isRefreshing = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text("Моя бонусная карта")
                            .font(.title.bold())
                        Text("Загрузите вашу бонусную карту")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                            .cornerRadius(16)
                            .shadow(radius: 6)
                            .padding(.horizontal)
                    } else {
                        VStack(spacing: 12) {
                            Image(systemName: "creditcard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .foregroundColor(.gray.opacity(0.5))

                            Text("Карта не загружена")
                                .font(.headline)
                                .foregroundColor(.secondary)

                            Text("Нажмите кнопку ниже, чтобы загрузить изображение вашей бонусной карты")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding()
                    }

                    Button(action: {
                        showingPicker = true
                    }) {
                        Label("Загрузить карту", systemImage: "plus.circle")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .photosPicker(isPresented: $showingPicker, selection: Binding(
                        get: { nil },
                        set: { newItem in
                            if let newItem = newItem {
                                Task {
                                    if let data = try? await newItem.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                    }
                                }
                            }
                        }
                    ))
                }
                .refreshable {
                    isRefreshing = true
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    isRefreshing = false
                }
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}
