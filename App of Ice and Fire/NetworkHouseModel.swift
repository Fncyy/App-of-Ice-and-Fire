import Foundation

struct NetworkHouseModel: Codable {
    let url: String
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLordUrl: String
    let heirUrl: String
    let overlordUrl: String
    let founded: String
    let founderUrl: String
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranchUrls: [String]

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case name = "name"
        case region = "region"
        case coatOfArms = "coatOfArms"
        case words = "words"
        case titles = "titles"
        case seats = "seats"
        case currentLordUrl = "currentLord"
        case heirUrl = "heir"
        case overlordUrl = "overlord"
        case founded = "founded"
        case founderUrl = "founder"
        case diedOut = "diedOut"
        case ancestralWeapons = "ancestralWeapons"
        case cadetBranchUrls = "cadetBranches"
    }
}
