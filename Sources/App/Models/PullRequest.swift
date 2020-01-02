struct PullRequest: Decodable {
    let review: Review
}

struct Review: Decodable {
    let pull_request_url : String
}
