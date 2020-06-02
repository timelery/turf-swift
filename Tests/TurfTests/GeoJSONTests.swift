import XCTest
import Turf
#if os(macOS)
import struct Turf.Polygon
#endif
import CoreLocation

class GeoJSONTests: XCTestCase {
    
    func testPoint() {
        let coordinate = CLLocationCoordinate2D(latitude: 10, longitude: 30)
        let geometry = Geometry.Point(coordinates: Point(coordinate))
        let pointFeature = Feature(geometry)
        
        XCTAssertEqual((pointFeature.geometry.value as! Point).coordinates, coordinate)
    }
    
    func testLineString() {
        let coordinates = [CLLocationCoordinate2D(latitude: 10, longitude: 30),
                           CLLocationCoordinate2D(latitude: 30, longitude: 10),
                           CLLocationCoordinate2D(latitude: 40, longitude: 40)]
        
        let lineString = Geometry.LineString(coordinates: .init(coordinates))
        let lineStringFeature = Feature(lineString)
        XCTAssertEqual((lineStringFeature.geometry.value as! LineString).coordinates, coordinates)
    }
    
    func testPolygon() {
        let coordinates = [
            [
                CLLocationCoordinate2D(latitude: 10, longitude: 30),
                CLLocationCoordinate2D(latitude: 40, longitude: 40),
                CLLocationCoordinate2D(latitude: 40, longitude: 20),
                CLLocationCoordinate2D(latitude: 20, longitude: 10),
                CLLocationCoordinate2D(latitude: 10, longitude: 30)
            ],
            [
                CLLocationCoordinate2D(latitude: 30, longitude: 20),
                CLLocationCoordinate2D(latitude: 35, longitude: 35),
                CLLocationCoordinate2D(latitude: 20, longitude: 30),
                CLLocationCoordinate2D(latitude: 30, longitude: 20)
            ]
        ]
        
        let polygon = Geometry.Polygon(coordinates: .init(coordinates))
        let polygonFeature = Feature(polygon)
        XCTAssertEqual((polygonFeature.geometry.value as! Polygon).coordinates, coordinates)
    }
    
    func testMultiPoint() {
        let coordinates = [CLLocationCoordinate2D(latitude: 40, longitude: 10),
                           CLLocationCoordinate2D(latitude: 30, longitude: 40),
                           CLLocationCoordinate2D(latitude: 20, longitude: 20),
                           CLLocationCoordinate2D(latitude: 10, longitude: 30)]
        
        let multiPoint = Geometry.MultiPoint(coordinates: .init(coordinates))
        let multiPointFeature = Feature(multiPoint)
        XCTAssertEqual((multiPointFeature.geometry.value as! MultiPoint).coordinates, coordinates)
    }
    
    func testMultiLineString() {
        let coordinates = [
            [
                CLLocationCoordinate2D(latitude: 10, longitude: 10),
                CLLocationCoordinate2D(latitude: 20, longitude: 20),
                CLLocationCoordinate2D(latitude: 40, longitude: 10)
            ],
            [
                CLLocationCoordinate2D(latitude: 40, longitude: 40),
                CLLocationCoordinate2D(latitude: 30, longitude: 30),
                CLLocationCoordinate2D(latitude: 20, longitude: 40),
                CLLocationCoordinate2D(latitude: 10, longitude: 30)
            ]
        ]
        
        let multiLineString = Geometry.MultiLineString(coordinates: .init(coordinates))
        let multiLineStringFeature = Feature(multiLineString)
        XCTAssertEqual((multiLineStringFeature.geometry.value as! MultiLineString).coordinates, coordinates)
    }
    
    func testMultiPolygon() {
        let coordinates = [
            [
                [
                    CLLocationCoordinate2D(latitude: 40, longitude: 40),
                    CLLocationCoordinate2D(latitude: 45, longitude: 20),
                    CLLocationCoordinate2D(latitude: 45, longitude: 30),
                    CLLocationCoordinate2D(latitude: 40, longitude: 40)
                ]
            ],
            [
                [
                    CLLocationCoordinate2D(latitude: 35, longitude: 20),
                    CLLocationCoordinate2D(latitude: 30, longitude: 10),
                    CLLocationCoordinate2D(latitude: 10, longitude: 10),
                    CLLocationCoordinate2D(latitude: 5, longitude: 30),
                    CLLocationCoordinate2D(latitude: 20, longitude: 45),
                    CLLocationCoordinate2D(latitude: 35, longitude: 20)
                ],
                [
                    CLLocationCoordinate2D(latitude: 20, longitude: 30),
                    CLLocationCoordinate2D(latitude: 15, longitude: 20),
                    CLLocationCoordinate2D(latitude: 25, longitude: 25),
                    CLLocationCoordinate2D(latitude: 20, longitude: 30)
                ]
            ]
        ]
        
        let multiPolygon = Geometry.MultiPolygon(coordinates: .init(coordinates))
        let multiPolygonFeature = Feature(multiPolygon)
        XCTAssertEqual((multiPolygonFeature.geometry.value as! MultiPolygon).coordinates, coordinates)
    }
}
