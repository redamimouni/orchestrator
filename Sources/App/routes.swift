import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    
    router.post("payload") { req -> Future<HTTPStatus> in
        return try req.content.decode(PullRequest.self).map(to: HTTPStatus.self, { pullRequest in
            print(pullRequest.review.pull_request_url)
            return .ok
        })
    }

    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
