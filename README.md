# mobalmobal_iOS
모발모발 iOS 🍎

[재희](https://github.com/jaehui327)

[서영](https://github.com/SongSeoYoung)

[수현](https://github.com/tngusmiso)

[민호](https://github.com/JeongMinHo)



### Pull Request

- Template

  ```markdown
  ### Related Issue
  
  resolve: #
  
  ### What does this PR do?
  
  -
  
  ### Why are we doing this?
  
  -
  
  ### Screenshots
  ```

- Merge Option

  - 해커톤 : 1명 이상의 코드리뷰
  - 이후 : 2명 이상의 코드리뷰

------

### Architecture

MVVM

------

## 코드 스타일

- 디렉토리 구성

  - 화면 하나당 큰 폴더를 갖는다.
  - 큰 폴더 내에는 cell 폴더, ViewController 파일,  ViewModel 파일을 갖는다.

- MARK 주석 순서

  ```markdown
  // MARK: - describe
  ```

  1. UIComponents
  2. Properties
  3. Initializer
  4. Lifecycle
  5. Actions
  6. Methods
  7. Protocols

- /// 주석 활용

  - 메서드를 선언했는데 설명이 부족하다고 느끼면,
  - 선언부 위에 `/// 주석`으로 Summary에 설명을 추가할 수 있다.
  - 또는 `command + 함수명 클릭`해서 Add documentation으로 추가할 수 있다.
  - 나중에 호출부에서 `option + 함수명 클릭`으로 Summary 내용 확인할 수 있다.

- 코드로 레이아웃 짤 때 여러개의 subview 추가하는 법

  ```markdown
  [subview1, subview2, subview3].forEach { superview.addSubView($0) }
  ```

- SnapKit

  - left, right 보다는 `leading`, `trailing` 사용

  - 제약조건 잡는 순서 : `top`, `leading`, `trailing`, `bottom`, `width`, `heigth` 순 -!

  - make

     vs 

    remake

     vs 

    update

    - `makeConstraints` : 처음 잡을 때
    - `remakeConstraints` : 잡혀있던 제약조건 초기화하고 다시 잡을 때
    - `updateConstraints` : 기존의 제약조건 유지한 채, 일부만 업데이트할 때

  - makeConstraints 클로저에 **make** 또는 **$0** ?? ⇒ `make`를 쓰자

- 뷰 선언 할 때 **lazy var** vs **let**

  - 큰 차이는 없지만.. 일단 **`let`**으로 통일하자.

  - let으로 안되는 경우가 있다. 그럴 때만 `**lazy var**` 를 사용하자.

    (ref 👉  https://stackoverflow.com/questions/47367454/swift-lazy-var-vs-let-when-creating-views-programmatically-saving-memory )

- 뷰 선언과 동시에 초기화 (클로저 활용)

  ```swift
  let gameImageView: UIImageView = {
      let imageView: UIImageView = UIImageView(frame: .zero)
      imageView.contentMode = .scaleAspectFill
      imageView.layer.masksToBounds = true
      imageView.layer.cornerRadius = 9
      imageView.layer.borderWidth = 1
      imageView.layer.borderColor = UIColor.veryLightPinkTwo.cgColor
      return imageView
  }()
  ```

- extension 활용

  - Zeplin에서는 UIColor를 extension 한 코드를 내보내기 해준다. → 피그마는 어떻게 나오나 봅시다!
  - label, button 등, 초기화해줘야 할 속성들이 많은데, 이를 한꺼번에 묶어서 초기화할 수 있는 메서드를 extension에 만들어서 넣어줄 수 있다.