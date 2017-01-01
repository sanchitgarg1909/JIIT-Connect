
enum Days: String {
    case Monday = "monday"
    case Tuesday = "tuesday"
    case Wednesday = "wednesday"
    case Thursday = "thursday"
    case Friday = "friday"
    case Saturday = "saturday"
}

enum BackendError: Error {
    case objectSerialization(reason: String)
}
