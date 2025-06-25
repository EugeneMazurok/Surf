//
//  Cafes.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import Foundation

let cafesData: [Cafe] = [
    Cafe(name: "Surf Coffee Garden", address: "ул. Большая Садовая, 81/31", city: "Ростов-на-Дону",
         imageURL: URL(string: "https://avatars.mds.yandex.net/get-altay/947364/2a0000016594b94e8a8fba235644ba095bfb/XXXL")!,
         latitude: 47.222078, longitude: 39.720349),
    
    Cafe(name: "Surf Coffee Soborniy", address: "пер. Соборный, 28/45", city: "Ростов-на-Дону",
         imageURL: URL(string: "https://avatars.mds.yandex.net/get-altay/5479189/2a0000017d762a5f3ee2734fc123add1bb37/XXXL")!,
         latitude: 47.222876, longitude: 39.720965),
    
    Cafe(name: "Surf Coffee Astor", address: "Будённовский просп., 49/97", city: "Ростов-на-Дону",
         imageURL: URL(string: "https://avatars.mds.yandex.net/get-altay/3598710/2a00000182d1a4a8b06079cc1679b447bb64/XXXL")!,
         latitude: 47.225295, longitude: 39.720703),
    
    Cafe(name: "Surf Coffee ASP", address: "ул. Пушкинская, 112", city: "Ростов-на-Дону",
         imageURL: URL(string: "https://avatars.mds.yandex.net/get-altay/5445147/2a0000017dcac126797724687c59bf7a72ac/XXXL")!,
         latitude: 47.225800, longitude: 39.718900),
    
    Cafe(name: "Surf Coffee Right Coast", address: "ул. Береговая, 12/1", city: "Ростов-на-Дону",
         imageURL: URL(string: "https://avatars.mds.yandex.net/get-altay/10589039/2a0000018b952b758043e44f81baca841532/XXXL")!,
         latitude: 47.222500, longitude: 39.710000),
    
    Cafe(name: "Surf Coffee Arbat", address: "ул. Новый Арбат, 7а", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.752220, longitude: 37.586870),
    
    Cafe(name: "Surf Coffee Solyanka", address: "ул. Солянка, 1/2", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.752023, longitude: 37.639110),
    
    Cafe(name: "Surf Coffee Secret Spot", address: "ул. Конный переулок, 12", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.723000, longitude: 37.610000),
    
    Cafe(name: "Surf Coffee Lips", address: "ул. Дмитрия Ульянова, 4к1", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.691000, longitude: 37.573000),
    
    Cafe(name: "Surf Coffee G-Spot", address: "ул. Мясницкая, 16", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.764000, longitude: 37.638000),
    
    Cafe(name: "Surf Coffee Mayak", address: "ул. Тверская, 25/12", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.765000, longitude: 37.604000),
    
    Cafe(name: "Surf Coffee Shore", address: "МКАД 66 км, Крокус Сити Молл", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.823000, longitude: 37.388000),
    
    Cafe(name: "Surf Coffee Dream", address: "ул. Новослободская, 16а", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.781000, longitude: 37.601000),
    
    Cafe(name: "Surf Coffee Anthill", address: "Пресненская наб., 12", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.749000, longitude: 37.539000),
    
    Cafe(name: "Surf Coffee Change", address: "Стремянный пер., 38", city: "Москва",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 55.726000, longitude: 37.624000),
    
    Cafe(name: "Surf Coffee G34", address: "ул. Гороховая, 34", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.927000, longitude: 30.321000),
    
    Cafe(name: "Surf Coffee Jetlag", address: "Малая Конюшенная, 7", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.936000, longitude: 30.322000),
    
    Cafe(name: "Surf Coffee MDT", address: "ул. Рубинштейна, 9/3", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.929000, longitude: 30.347000),
    
    Cafe(name: "Surf Coffee Soul", address: "Средний пр. В.О., 27", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.942000, longitude: 30.278000),
    
    Cafe(name: "Surf Coffee Lev Tolstoy", address: "ул. Льва Толстого, 1-3", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.966000, longitude: 30.311000),
    
    Cafe(name: "Surf Coffee Basque", address: "Басков пер., 6", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.934000, longitude: 30.353000),
    
    Cafe(name: "Surf Coffee Chizhik", address: "ул. Пестеля, 13-15", city: "Санкт-Петербург",
         imageURL: URL(string: "https://example.com/coffee_placeholder.jpg")!,
         latitude: 59.936000, longitude: 30.349000)
]
