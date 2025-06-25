//
//  Promos.swift
//  surf
//
//  Created by Eugene on 6/24/25.
//

import Foundation

let promos: [Promo] = [
    Promo(title: "☕ Первый кофе дня бесплатно", description: "Только для первого клиента с 8:00 в Surf Coffee Right Coast", cafe: cafesData.first(where: { $0.name.contains("Right Coast") })!),
    Promo(title: "🎉 2 по цене 1", description: "На капучино весь день в Surf Coffee Arbat", cafe: cafesData.first(where: { $0.name.contains("Arbat") })!),
    Promo(title: "🍪 Печенье в подарок", description: "К каждому фильтру кофе – печенье бесплатно в Surf Coffee Jetlag", cafe: cafesData.first(where: { $0.name.contains("Jetlag") })!),
    Promo(title: "🏄 Футболка SURF за репост", description: "Выложи сторис и получи мерч в Surf Coffee MDT", cafe: cafesData.first(where: { $0.name.contains("MDT") })!),
    Promo(
        title: "🌅 Утренний флет уикенд",
        description: "Скидка 30% на флет уайт до 11:00 по выходным в Surf Coffee Garden",
        cafe: cafesData.first(where: { $0.name.contains("Garden") })!
    ),
    Promo(
        title: "💬 Кофе за отзыв",
        description: "Оставь отзыв в Яндекс.Картах и получи американо бесплатно в Surf Coffee Soborniy",
        cafe: cafesData.first(where: { $0.name.contains("Soborniy") })!
    ),
    Promo(
        title: "🎨 Арт-часы + латте",
        description: "Принеси свой скетчбук и получи скидку 50% на латте в Surf Coffee Astor",
        cafe: cafesData.first(where: { $0.name.contains("Astor") })!
    ),
    Promo(
        title: "👕 Скидка за SURF-лук",
        description: "Приди в одежде Surf и получи бесплатный фильтр в Surf Coffee ASP",
        cafe: cafesData.first(where: { $0.name.contains("ASP") })!
    )
]
