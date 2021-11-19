import Foundation

struct NetworkCharacterModel: Codable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let titles: [String]
    let aliases: [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let bookUrls: [String]
    let povBookUrls: [String]
    let tvSeries: [String]
    let playedBy: [String]

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case name = "name"
        case gender = "gender"
        case culture = "culture"
        case born = "born"
        case died = "died"
        case titles = "titles"
        case aliases = "aliases"
        case father = "father"
        case mother = "mother"
        case spouse = "spouse"
        case allegiances = "allegiances"
        case bookUrls = "books"
        case povBookUrls = "povBooks"
        case tvSeries = "tvSeries"
        case playedBy = "playedBy"
    }
}
