//
//  TeamMemberInfo.swift
//  Parkfuchs
//
//  Created by Ruotger Deecke on 19.02.22.
//  Modified by Sven Raskin | maxxweb on 05.04.23.
//  Copyright © 2022 Parkfuchs. All rights reserved.
//

import Foundation

struct TeamMemberInfo {
    let imagename: String
    let name: String
    let job: String
    let mastodonName: String?
    let twitterName: String?
    let emailAddress: String?
    let twitterURL: URL?
    let mastodonURL: URL?

    static var malik: TeamMemberInfo {
        TeamMemberInfo(imagename: "team_malik", name: "Malik", job: "Designfuchs", mastodonName: "@malik", twitterName: nil, emailAddress: "malik@ladefuchs.app", twitterURL: nil, mastodonURL: ExternalURLs.malikmastodonURL)
    }
    static var dominic: TeamMemberInfo {
        TeamMemberInfo(imagename: "team_dominic", name: "Dominic", job: "Entwicklerfuchs", mastodonName: "@dominic", twitterName: nil, emailAddress: nil, twitterURL: nil, mastodonURL: ExternalURLs.dominicmastodonURL)
    }
    static var kay: TeamMemberInfo {
        TeamMemberInfo(imagename: "team_kay", name: "Kay", job: "Moderatorfuchs", mastodonName: nil, twitterName: "@4lau", emailAddress: nil, twitterURL: ExternalURLs.kayTwitterURL, mastodonURL: nil)
    }

    static var sven: TeamMemberInfo {
        TeamMemberInfo(imagename: "team_sven", name: "Sven", job: "iOSfuchs", mastodonName: "@hexer", twitterName: nil, emailAddress: "fuchs@maxxweb.net", twitterURL: nil, mastodonURL: ExternalURLs.svenmastodonURL)
    }

}
