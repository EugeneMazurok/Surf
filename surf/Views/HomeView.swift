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
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Namespace private var animation

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text("Моя бонусная карта")
                            .font(.title.bold())
                            .foregroundColor(.primary)

                        Text("Загрузите вашу бонусную карту")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)

                    Group {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .cornerRadius(16)
                                .shadow(radius: 6)
                                .padding(.horizontal)
                                .matchedGeometryEffect(id: "card", in: animation)
                                .transition(.asymmetric(insertion: .scale.combined(with: .opacity),
                                                        removal: .opacity.combined(with: .scale)))
                            Text("Ваша карта будет здесь даже когда вы перезайдёте, перезагрузите телефон или будете оффлайн.")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                        } else {
                            VStack(spacing: 12) {
                                Image(systemName: "creditcard")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 64, height: 64)
                                    .foregroundColor(.secondary)

                                Text("Карта не загружена")
                                    .font(.headline)
                                    .foregroundColor(.secondary)

                                Text("Нажмите кнопку ниже, чтобы загрузить изображение вашей бонусной карты")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                            .padding()
                            .matchedGeometryEffect(id: "card", in: animation)
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity.combined(with: .scale)))
                        }
                    }
                    .animation(.easeInOut(duration: 0.35), value: selectedImage)

                    Button(action: {
                        showingPicker = true
                    }) {
                        Label("Загрузить карту", systemImage: "plus.circle")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.opacity(0.15))
                            .foregroundColor(.accentColor)
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
                                        withAnimation(.easeInOut) {
                                            selectedImage = uiImage
                                        }
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
            .background(Color(.systemBackground).ignoresSafeArea())
            .navigationTitle("Главная")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.spring()) {
                            isDarkMode.toggle()
                        }
                    }) {
                        Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                            .imageScale(.large)
                            .foregroundColor(.primary)
                            .transition(.scale)
                    }
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
