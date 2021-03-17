public enum DataModelError: Error {
    case emptyList(String)     // Associated value: List passed without elements
    case missingValue(String)  // Associated Value: JSON key missing value
    case emailNotFound(String)
}
