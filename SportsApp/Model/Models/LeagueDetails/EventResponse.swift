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
    var firstPlayer, secondPlayer: String?
    var eventHomeTeamLogo, eventAwayTeamLogo: String?

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
        case firstPlayer = "event_first_player"
        case secondPlayer = "event_second_player"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
    }

    init(eventKey: Int?, eventDate: String?, eventTime: String?, eventHomeTeam: String?, homeTeamKey: Int?, eventAwayTeam: String?, awayTeamKey: Int?, eventHalftimeResult: String?, eventFinalResult: String?, eventFtResult: String?, eventPenaltyResult: String?, eventStatus: String?, countryName: String?, leagueName: String?, leagueKey: Int?, leagueRound: String?, leagueSeason: String?, eventLive: String?, eventStadium: String?, eventReferee: String?, homeTeamLogo: String?, awayTeamLogo: String?, eventCountryKey: Int?, leagueLogo: String?, countryLogo: String?, eventHomeFormation: String?, eventAwayFormation: String?, fkStageKey: Int?, stageName: String?,
         firstPlayer: String?, secondPlayer: String?) {
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
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
    }
}
