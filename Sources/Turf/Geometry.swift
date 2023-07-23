import Foundation
#if !os(Linux)
import CoreLocation
#endif

/**
 A [Geometry object](https://datatracker.ietf.org/doc/html/rfc7946#section-3.1) represents points, curves, and surfaces in coordinate space. Use an instance of this enumeration whenever a value could be any kind of Geometry object.
 */
public enum TurfGeometry: Equatable {
    /// A single position.
    case point(_ geometry: TurfPoint)
    
    /// A collection of two or more positions, each position connected to the next position linearly.
    case lineString(_ geometry: TurfLineString)
    
    /// Conceptually, a collection of `Ring`s that form a single connected geometry.
    case polygon(_ geometry: TurfPolygon)
    
    /// A collection of positions that are disconnected but related.
    case multiPoint(_ geometry: TurfMultiPoint)
    
    /// A collection of `LineString` geometries that are disconnected but related.
    case multiLineString(_ geometry: TurfMultiLineString)
    
    /// A collection of `Polygon` geometries that are disconnected but related.
    case multiPolygon(_ geometry: TurfMultiPolygon)
    
    /// A heterogeneous collection of geometries that are related.
    case geometryCollection(_ geometry: TurfGeometryCollection)
    
    /// Initializes a geometry representing the given geometry–convertible instance.
    public init(_ geometry: TurfGeometryConvertible) {
        self = geometry.geometry
    }
}

extension TurfGeometry: Codable {
    private enum CodingKeys: String, CodingKey {
        case kind = "type"
    }
    
    enum Kind: String, Codable, CaseIterable {
        case TurfPoint
        case TurfLineString
        case TurfPolygon
        case TurfMultiPoint
        case TurfMultiLineString
        case TurfMultiPolygon
        case TurfGeometryCollection
    }
    
    public init(from decoder: Decoder) throws {
        let kindContainer = try decoder.container(keyedBy: CodingKeys.self)
        let container = try decoder.singleValueContainer()
        switch try kindContainer.decode(Kind.self, forKey: .kind) {
        case .TurfPoint:
            self = .point(try container.decode(TurfPoint.self))
        case .TurfLineString:
            self = .lineString(try container.decode(TurfLineString.self))
        case .TurfPolygon:
            self = .polygon(try container.decode(TurfPolygon.self))
        case .TurfMultiPoint:
            self = .multiPoint(try container.decode(TurfMultiPoint.self))
        case .TurfMultiLineString:
            self = .multiLineString(try container.decode(TurfMultiLineString.self))
        case .TurfMultiPolygon:
            self = .multiPolygon(try container.decode(TurfMultiPolygon.self))
        case .TurfGeometryCollection:
            self = .geometryCollection(try container.decode(TurfGeometryCollection.self))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .point(let point):
            try container.encode(point)
        case .lineString(let lineString):
            try container.encode(lineString)
        case .polygon(let polygon):
            try container.encode(polygon)
        case .multiPoint(let multiPoint):
            try container.encode(multiPoint)
        case .multiLineString(let multiLineString):
            try container.encode(multiLineString)
        case .multiPolygon(let multiPolygon):
            try container.encode(multiPolygon)
        case .geometryCollection(let geometryCollection):
            try container.encode(geometryCollection)
        }
    }
}

/**
 A type that can be represented as a `Geometry` instance.
 */
public protocol TurfGeometryConvertible {
    /// The instance wrapped in a `Geometry` instance.
    var geometry: TurfGeometry { get }
}

extension TurfGeometry: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return self }
}

extension TurfPoint: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .point(self) }
}

extension TurfLineString: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .lineString(self) }
}

extension TurfPolygon: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .polygon(self) }
}

extension TurfMultiPoint: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .multiPoint(self) }
}

extension TurfMultiLineString: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .multiLineString(self) }
}

extension TurfMultiPolygon: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .multiPolygon(self) }
}

extension TurfGeometryCollection: TurfGeometryConvertible {
    public var geometry: TurfGeometry { return .geometryCollection(self) }
}
