//
//  ViewPresentableProtocol.swift
//  SeSACLectureNetworkBasic
//
//  Created by Seokjune Hong on 2022/07/28.
//

import UIKit

// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다!
// 클래스, 구조체, 익스텐션, 열거형 ...
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 개수에 제한이 없다.
// @objc optional : 선택적 요청 (Optional Requirement)
// 프로토콜 프로퍼티, 프로토콜 메서드

// 프로토콜 프로퍼티: 연산 프로퍼티로 쓰던 저장 프로퍼티로 쓰던 상관X
// 명세하지 않기에, 구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수도 있고 연산 프로퍼티로 사용할 수 도 있다.
// 무조건 var로 선언해야 한다.
// 만약 get만 명시했다면, get 기능만 최소한 구현되어 있으면 된다! 그래서 필요하다면 set도 구현해도 괜찮다.

@objc
protocol ViewPresentableProtocol {
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    func congigureLabel()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}

@objc
protocol hanoTableViewProtocol {
    func numberOfRowsSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
