# 당근마켓 중고거래 작성 화면 클론 코딩

## Requirements

- Swift 5
- iOS 13+
- Xcode 12

## Dependencies

- RxSwift, 6.1.0
- RxCocoa, 6.1.0
- SwiftLint, 0.43.1
- SnapKit, ~> 5.0.0
- Then, 2.7.0

## 요구사항 분석

<div style="clear: both">
<img src="images/Write-View.png" width="350" align="left" />

### 요구사항
1. 사진 선택 화면으로 이동한다.
   - 현재 선택된 사진의 개수를 표시한다.
2. 현재 선택된 사진을 가로로 나열해 표시한다.
   - 썸네일을 선택하면 원본 사진을 보여준다.
   - X를 선택하면 사진을 삭제한다.
3. 글 제목을 입력 받는다.
   - 글자 수가 늘어나면 입력폼이 한 줄씩 늘어난다.
   - 글 제목에 따라 카테고리를 추천해준다. (구현 X)
4. 카테고리 선택 화면으로 이동한다.
5. 숫자 키보드로 가격을 입력 받는다.
    - 99,999,999원을 초과하면 99,999,999원으로 고정한다.
6. 가격이 입력되지 않으면 활성화하지 않는다.
7. 게시글 내용을 입력 받는다.
8. 동네 범위 선택 화면으로 이동한다.
9. 자주 사용하는 문구 모달을 띄운다.

</div>

<div style="clear: both">

<img src="images/Choose-Image-View.png" width="350" align="left" />

### 요구사항

1. 여러장의 사진을 선택할 수 있다.
2. 선택한 사진의 개수를 표시한다.
    - 선택한 사진을 글쓰기 작성 화면으로 넘겨준다.

</div>

<div style="clear: both">
<img src="images/Choose-Category-View.png" width="350" align="left" />

### 요구사항

1. 카테고리 목록을 표시한다.

</div>

<div style="clear: both">
<img src="images/Show-Keyboard-View.png" width="350" align="left" />

### 요구사항

1. 키보드가 올라왔을 때 키보드를 숨기는 버튼을 표시한다.

</div>

<div style="clear: both">
<img src="images/Choose-Town-Range-View.png" />

### 요구사항

1. 선택한 범위에 따라 텍스트를 변경한다.
2. 슬라이더를 이용해 동네 범위를 선택한다.
3. 2에서 조절한 범위에 따라 이미지를 변경한다.

</div>

<div style="clear: both">
<img src="images/Frequently-Used-Phrases-Modal-View.png" width="350" align="left" />

### 요구사항

1. 모달 타이틀을 표시한다.
2. 자주쓰는 문구 목록을 표시한다.
3. 자주쓰는 문구를 입력 받는다.
4. 텍스트가 없으면 비활성화한다.
5. 선택하면 현재 문구를 삭제한다.

</div>