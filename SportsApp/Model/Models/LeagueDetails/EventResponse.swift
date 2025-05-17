// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
class EventResponse: Codable {
    var success: Int?
    var result: [EventModel]?

    init(success: Int?, result: [EventModel]?) {
        self.success = success
        self.result = result
    }
}

// MARK: - Result
class EventModel: Codable {
    var eventKey: Int?
    var eventDate, eventTime, eventHomeTeam: String?
    var homeTeamKey: Int?
    var eventAwayTeam: String?
    var awayTeamKey: Int?
    var eventHalftimeResult, eventFinalResult, eventFtResult, eventPenaltyResult: String?
    var eventStatus, countryName, leagueName: String?
    var leagueKey: Int?
    var leagueRound, leagueSeason, eventLive, eventStadium: String?
    var eventReferee: String?
    var homeTeamLogo, awayTeamLogo: String?
    var eventCountryKey: Int?
    var leagueLogo, countryLogo: String?
    var eventHomeFormation, eventAwayFormation: String?
    var fkStageKey: Int?
    var stageName: String?
    var leagueGroup: JSONNull?
    var goalscorers: [Goalscorer]?
    var substitutes: [Substitute]?
    var cards: [Card]?
    var vars: Vars?
    var lineups: Lineups?
    var statistics: [Statistic]?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventHalftimeResult = "event_halftime_result"
        case eventFinalResult = "event_final_result"
        case eventFtResult = "event_ft_result"
        case eventPenaltyResult = "event_penalty_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventStadium = "event_stadium"
        case eventReferee = "event_referee"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventCountryKey = "event_country_key"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case eventHomeFormation = "event_home_formation"
        case eventAwayFormation = "event_away_formation"
        case fkStageKey = "fk_stage_key"
        case stageName = "stage_name"
        case leagueGroup = "league_group"
        case goalscorers, substitutes, cards, vars, lineups, statistics
    }

    init(eventKey: Int?, eventDate: String?, eventTime: String?, eventHomeTeam: String?, homeTeamKey: Int?, eventAwayTeam: String?, awayTeamKey: Int?, eventHalftimeResult: String?, eventFinalResult: String?, eventFtResult: String?, eventPenaltyResult: String?, eventStatus: String?, countryName: String?, leagueName: String?, leagueKey: Int?, leagueRound: String?, leagueSeason: String?, eventLive: String?, eventStadium: String?, eventReferee: String?, homeTeamLogo: String?, awayTeamLogo: String?, eventCountryKey: Int?, leagueLogo: String?, countryLogo: String?, eventHomeFormation: String?, eventAwayFormation: String?, fkStageKey: Int?, stageName: String?, leagueGroup: JSONNull?, goalscorers: [Goalscorer]?, substitutes: [Substitute]?, cards: [Card]?, vars: Vars?, lineups: Lineups?, statistics: [Statistic]?) {
        self.eventKey = eventKey
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventHomeTeam = eventHomeTeam
        self.homeTeamKey = homeTeamKey
        self.eventAwayTeam = eventAwayTeam
        self.awayTeamKey = awayTeamKey
        self.eventHalftimeResult = eventHalftimeResult
        self.eventFinalResult = eventFinalResult
        self.eventFtResult = eventFtResult
        self.eventPenaltyResult = eventPenaltyResult
        self.eventStatus = eventStatus
        self.countryName = countryName
        self.leagueName = leagueName
        self.leagueKey = leagueKey
        self.leagueRound = leagueRound
        self.leagueSeason = leagueSeason
        self.eventLive = eventLive
        self.eventStadium = eventStadium
        self.eventReferee = eventReferee
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamLogo = awayTeamLogo
        self.eventCountryKey = eventCountryKey
        self.leagueLogo = leagueLogo
        self.countryLogo = countryLogo
        self.eventHomeFormation = eventHomeFormation
        self.eventAwayFormation = eventAwayFormation
        self.fkStageKey = fkStageKey
        self.stageName = stageName
        self.leagueGroup = leagueGroup
        self.goalscorers = goalscorers
        self.substitutes = substitutes
        self.cards = cards
        self.vars = vars
        self.lineups = lineups
        self.statistics = statistics
    }
}

// MARK: - Card
class Card: Codable {
    var time, homeFault, card, awayFault: String?
    var info, homePlayerID, awayPlayerID: String?
    var infoTime: InfoTime?

    enum CodingKeys: String, CodingKey {
        case time
        case homeFault = "home_fault"
        case card
        case awayFault = "away_fault"
        case info
        case homePlayerID = "home_player_id"
        case awayPlayerID = "away_player_id"
        case infoTime = "info_time"
    }

    init(time: String?, homeFault: String?, card: String?, awayFault: String?, info: String?, homePlayerID: String?, awayPlayerID: String?, infoTime: InfoTime?) {
        self.time = time
        self.homeFault = homeFault
        self.card = card
        self.awayFault = awayFault
        self.info = info
        self.homePlayerID = homePlayerID
        self.awayPlayerID = awayPlayerID
        self.infoTime = infoTime
    }
}

enum InfoTime: String, Codable {
    case the1StHalf = "1st Half"
    case the2NdHalf = "2nd Half"
}

// MARK: - Goalscorer
class Goalscorer: Codable {
    var time, homeScorer, homeScorerID, homeAssist: String?
    var homeAssistID, score, awayScorer, awayScorerID: String?
    var awayAssist, awayAssistID, info: String?
    var infoTime: InfoTime?

    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case homeScorerID = "home_scorer_id"
        case homeAssist = "home_assist"
        case homeAssistID = "home_assist_id"
        case score
        case awayScorer = "away_scorer"
        case awayScorerID = "away_scorer_id"
        case awayAssist = "away_assist"
        case awayAssistID = "away_assist_id"
        case info
        case infoTime = "info_time"
    }

    init(time: String?, homeScorer: String?, homeScorerID: String?, homeAssist: String?, homeAssistID: String?, score: String?, awayScorer: String?, awayScorerID: String?, awayAssist: String?, awayAssistID: String?, info: String?, infoTime: InfoTime?) {
        self.time = time
        self.homeScorer = homeScorer
        self.homeScorerID = homeScorerID
        self.homeAssist = homeAssist
        self.homeAssistID = homeAssistID
        self.score = score
        self.awayScorer = awayScorer
        self.awayScorerID = awayScorerID
        self.awayAssist = awayAssist
        self.awayAssistID = awayAssistID
        self.info = info
        self.infoTime = infoTime
    }
}

// MARK: - Lineups
class Lineups: Codable {
    var homeTeam, awayTeam: Team?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }

    init(homeTeam: Team?, awayTeam: Team?) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

// MARK: - Team
class Team: Codable {
    var startingLineups, substitutes: [StartingLineup]?
    var coaches: [Coach]?
    var missingPlayers: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case startingLineups = "starting_lineups"
        case substitutes, coaches
        case missingPlayers = "missing_players"
    }

    init(startingLineups: [StartingLineup]?, substitutes: [StartingLineup]?, coaches: [Coach]?, missingPlayers: [JSONAny]?) {
        self.startingLineups = startingLineups
        self.substitutes = substitutes
        self.coaches = coaches
        self.missingPlayers = missingPlayers
    }
}

// MARK: - Coach
class Coach: Codable {
    var coache: String?
    var coacheCountry: JSONNull?

    enum CodingKeys: String, CodingKey {
        case coache
        case coacheCountry = "coache_country"
    }

    init(coache: String?, coacheCountry: JSONNull?) {
        self.coache = coache
        self.coacheCountry = coacheCountry
    }
}

// MARK: - StartingLineup
class StartingLineup: Codable {
    var player: String?
    var playerNumber, playerPosition: Int?
    var playerCountry: JSONNull?
    var playerKey: Int?
    var infoTime: String?

    enum CodingKeys: String, CodingKey {
        case player
        case playerNumber = "player_number"
        case playerPosition = "player_position"
        case playerCountry = "player_country"
        case playerKey = "player_key"
        case infoTime = "info_time"
    }

    init(player: String?, playerNumber: Int?, playerPosition: Int?, playerCountry: JSONNull?, playerKey: Int?, infoTime: String?) {
        self.player = player
        self.playerNumber = playerNumber
        self.playerPosition = playerPosition
        self.playerCountry = playerCountry
        self.playerKey = playerKey
        self.infoTime = infoTime
    }
}

// MARK: - Statistic
class Statistic: Codable {
    var type, home, away: String?

    init(type: String?, home: String?, away: String?) {
        self.type = type
        self.home = home
        self.away = away
    }
}

// MARK: - Substitute
class Substitute: Codable {
    var time: String?
    var homeScorer: AwayScorerUnion?
    var homeAssist: String?
    var score: Score?
    var awayScorer: AwayScorerUnion?
    var awayAssist, info: String?
    var infoTime: InfoTime?

    enum CodingKeys: String, CodingKey {
        case time
        case homeScorer = "home_scorer"
        case homeAssist = "home_assist"
        case score
        case awayScorer = "away_scorer"
        case awayAssist = "away_assist"
        case info
        case infoTime = "info_time"
    }

    init(time: String?, homeScorer: AwayScorerUnion?, homeAssist: String?, score: Score?, awayScorer: AwayScorerUnion?, awayAssist: String?, info: String?, infoTime: InfoTime?) {
        self.time = time
        self.homeScorer = homeScorer
        self.homeAssist = homeAssist
        self.score = score
        self.awayScorer = awayScorer
        self.awayAssist = awayAssist
        self.info = info
        self.infoTime = infoTime
    }
}

enum AwayScorerUnion: Codable {
    case anythingArray([JSONAny])
    case awayScorerClass(AwayScorerClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([JSONAny].self) {
            self = .anythingArray(x)
            return
        }
        if let x = try? container.decode(AwayScorerClass.self) {
            self = .awayScorerClass(x)
            return
        }
        throw DecodingError.typeMismatch(AwayScorerUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AwayScorerUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .anythingArray(let x):
            try container.encode(x)
        case .awayScorerClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AwayScorerClass
class AwayScorerClass: Codable {
    var scorerIn, out: String?
    var inID, outID: Int?

    enum CodingKeys: String, CodingKey {
        case scorerIn = "in"
        case out
        case inID = "in_id"
        case outID = "out_id"
    }

    init(scorerIn: String?, out: String?, inID: Int?, outID: Int?) {
        self.scorerIn = scorerIn
        self.out = out
        self.inID = inID
        self.outID = outID
    }
}

enum Score: String, Codable {
    case substitution = "substitution"
}

// MARK: - Vars
class Vars: Codable {
    var homeTeam, awayTeam: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }

    init(homeTeam: [JSONAny]?, awayTeam: [JSONAny]?) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
