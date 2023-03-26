import Vapor

struct TechEffect: Content {
    let building: Building
    let type: TechEffectType
    let score: Int?
    let yield: [ResourceQty]
    let bonus: [String: ResourceQty]
}

enum TechEffectType: String, Codable {
    case bonus, yield, score
}
