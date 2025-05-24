//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by mac on 21/05/2025.
//


import XCTest
@testable import SportsApp

class NetworkManagerTests: XCTestCase {
    var fakeNetwork: FakeNetwork!
    
    override func setUpWithError() throws {
        // Initialize before each test
    }
    
    override func tearDownWithError() throws {
        // Clean up after each test
        fakeNetwork = nil
    }
    
    
    func testFetchLeaguesSuccess() {
    
        fakeNetwork = FakeNetwork(shouldReturnError: false)
        let expectation = self.expectation(description: "Fetch Leagues API")
        
        
        fakeNetwork.fetchLeagues(sport: "football") { result in
            
            XCTAssertNotNil(result, "Leagues response should not be nil")
            XCTAssertEqual(result?.result.count, 1, "Should return 1 league")
            XCTAssertEqual(result?.result.first?.leagueName, "Premier League", "League name should be Premier League")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLeaguesFailure() {

        fakeNetwork = FakeNetwork(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetch Leagues API Failure")
        
        
        fakeNetwork.fetchLeagues(sport: "football") { result in
    
            XCTAssertNil(result, "Leagues response should be nil on error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
   
    func testFetchLeagueTeamsSuccess() {
       
        fakeNetwork = FakeNetwork(shouldReturnError: false)
        let expectation = self.expectation(description: "Fetch League Teams API")
        
        
        fakeNetwork.fetchLeagueTeams(sport: "football", leagueid: 1) { result in
            // Assert
            XCTAssertNotNil(result, "Teams response should not be nil")
            XCTAssertEqual(result?.result.total?.count, 1, "Should return 1 team")
            XCTAssertEqual(result?.result.total?.first?.standingTeam, "Manchester United", "Team name should be Manchester United")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLeagueTeamsFailure() {
        
        fakeNetwork = FakeNetwork(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetch League Teams API Failure")
        
     
        fakeNetwork.fetchLeagueTeams(sport: "football", leagueid: 1) { result in
           
            XCTAssertNil(result, "Teams response should be nil on error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testFetchLeagueFixturesSuccess() {
       
        fakeNetwork = FakeNetwork(shouldReturnError: false)
        let expectation = self.expectation(description: "Fetch League Fixtures API")
        
        
        fakeNetwork.fetchLeagueFixtures(sport: "football", leagueid: 1, from: "2025-05-16", to: "2025-05-16") { result in
        
            XCTAssertNotNil(result, "Fixtures response should not be nil")
            XCTAssertEqual(result?.result?.count, 1, "Should return 1 fixture")
            XCTAssertEqual(result?.result?.first?.eventHomeTeam, "Manchester United", "Home team should be Manchester United")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLeagueFixturesFailure() {
        
        fakeNetwork = FakeNetwork(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetch League Fixtures API Failure")
        
     
        fakeNetwork.fetchLeagueFixtures(sport: "football", leagueid: 1, from: "2025-05-16", to: "2025-05-16") { result in
           
            XCTAssertNil(result, "Fixtures response should be nil on error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchLeaguePlayersSuccess() {
        fakeNetwork = FakeNetwork(shouldReturnError: false)
        let expectation = self.expectation(description: "Fetch Tennis Players API")
        
        fakeNetwork.fetchLeaguePlayers { result in
            XCTAssertNotNil(result, "Players response should not be nil")
            XCTAssertEqual(result?.result.count, 1, "Should return 1 player")
            XCTAssertEqual(result?.result.first?.player, "Novak Djokovic", "Player should be Novak Djokovic")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchLeaguePlayersFailure() {
        fakeNetwork = FakeNetwork(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetch Tennis Players API Failure")
        
        fakeNetwork.fetchLeaguePlayers { result in
            XCTAssertNil(result, "Players response should be nil on error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testFetchTeamDetailsSuccess() {
        fakeNetwork = FakeNetwork(shouldReturnError: false)
        let expectation = self.expectation(description: "Fetch Team Details API")
        
        fakeNetwork.fetchTeamDetails(sport: "football", teamId: 101) { result in
            XCTAssertNotNil(result, "Team details response should not be nil")
            XCTAssertEqual(result?.result.count, 1, "Should return 1 team")
            XCTAssertEqual(result?.result.first?.teamName, "Manchester United", "Team name should be Manchester United")
            XCTAssertEqual(result?.result.first?.players.first?.playerName, "Cristiano Ronaldo", "Player should be Cristiano Ronaldo")
            XCTAssertEqual(result?.result.first?.coaches.first?.coachName, "Erik ten Hag", "Coach name should be Erik ten Hag")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchTeamDetailsFailure() {
        fakeNetwork = FakeNetwork(shouldReturnError: true)
        let expectation = self.expectation(description: "Fetch Team Details API Failure")
        
        fakeNetwork.fetchTeamDetails(sport: "football", teamId: 101) { result in
            XCTAssertNil(result, "Team details response should be nil on error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    
   
}
