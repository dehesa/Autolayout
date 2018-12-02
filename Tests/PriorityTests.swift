import XCTest
import Autolayout

final class PriorityTests: XCTestCase {
    func testAssignment() {
        let priority: Priority = .required
        XCTAssertEqual(priority.rawValue, Priority.required.rawValue, accuracy: .epsilon)
    }
    
    func testIntegerAssignment() {
        let priority: Priority = 77
        XCTAssertEqual(priority.rawValue, 77, accuracy: .epsilon)
    }
    
    func testNumericAssignment() {
        let priority: Priority = 88.877
        XCTAssertEqual(priority.rawValue, 88.877, accuracy: .epsilon)
    }
    
    func testIntegerOperationAssignment() {
        let priority = Priority(97 + 32)
        XCTAssertEqual(priority.rawValue, 97 + 32, accuracy: .epsilon)
    }
    
    func testNumericOperationAssignment() {
        let priority = Priority(111.11 - 2.222)
        XCTAssertEqual(priority.rawValue, 111.11 - 2.222, accuracy: .epsilon)
    }
    
    func testNumericOperationsAssignment() {
        let priority: Priority = .low + 4 - 26 / 5 * 29.9
        XCTAssertEqual(priority.rawValue, Priority.low.rawValue + 4 - 26 / 5 * 29.9, accuracy: .epsilon)
    }
    
    func testIntegerOperations() {
        let priority: Priority = .high
        let result = priority - 5 + 2
        XCTAssertEqual(result.rawValue, Priority.high.rawValue - 5 + 2, accuracy: .epsilon)
    }
    
    func testNumericOperations() {
        let priority: Priority = .high
        let result = priority - 5.3 + 2
        XCTAssertEqual(result.rawValue, Priority.high.rawValue - 5.3 + 2, accuracy: .epsilon)
    }
}

final class PriorityConstraintTests: XCTestCase {
    let window = Window(frame: .init(x: 0, y: 0, width: 400, height: 300))
    let (viewA, viewB) = (View(), View())
    
    override func setUp() {
        self.viewA.enableAutolayout()
        self.viewB.enableAutolayout()
        self.window.addSubview(self.viewA)
        self.window.addSubview(self.viewB)
    }
    
    override func tearDown() {
        self.viewA.removeFromSuperview()
        self.viewB.removeFromSuperview()
    }
}

extension PriorityConstraintTests {
    /// Tests the basic priority setting for constraints.
    func testBasicConstraintPriority() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint ~ .high
        XCTAssertEqual(constraint.priority.rawValue, Priority.high.rawValue, accuracy: .epsilon)
    }
    
    /// Tests the numeric priority setting for constraints.
    func testBasicConstraintNumberPriority() {
        let constraint = NSLayoutConstraint(item: viewA, attribute: .width, relatedBy: .equal, toItem: viewB, attribute: .width, multiplier: 1, constant: 0)
        constraint ~ 501.2
        XCTAssertEqual(constraint.priority.rawValue, Priority(501.2).rawValue, accuracy: .epsilon)
    }
}