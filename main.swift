//
//  main.swift
//  BaseballGame
//
//  Created by 박중권 on 3/13/24.
//

import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨
let baseball = Baseball ()
baseball.start()

class Baseball {
    
    var answer = 0
    
    init(answer: Int = 0) {
        self.answer = answer
    }
    
    func start() { // 시작 시키는 함수
        answer = makeAnswer()
        print("정답:", answer)
        
        var playerGuess: Int? // 플레이어의 답
        repeat {
            playerGuess = validPlayerGuess()
            if let guess = playerGuess {
                provideFeedback(playerGuess: guess, answer: answer)
            } else {
                print("잘못된 입력입니다. 다시 시도하세요.")
            }
        } while playerGuess != answer
        
        print("축하합니다! 정답은:", answer)
    }
    
    
    func validPlayerGuess() -> Int? { //플레이어의 숫자가 옳바른 판단하는 함수
        print("세자리 수 입력: ")
        guard let input = readLine(), let guess = Int(input), guess >= 100 && guess <= 999 else {
            print("다시 입력: ")
            return nil
        }
        return guess
    }
    
    //피드백을 주는 함수
    func provideFeedback(playerGuess: Int, answer: Int) {
        let playerGuessString = String(playerGuess) //인덱스에 접근하기 위해서 타입을 변경
        let answerString = String(answer)           //인덱스에 접근하기 위해서 타입을 변경
        var strike = 0
        var ball = 0
        
        // 스트라이크/볼 체크
        // zip 펑션을 사용해 각 자리의 수를 비교할 수 있음
        for (guessDigit, answerDigit) in zip(playerGuessString, answerString) {
            if guessDigit == answerDigit {
                strike += 1
            } else if answerString.contains(guessDigit) {
                ball += 1
            }
        }
        
        // 피드백
        if strike == 1 {
            print("1 strike")
        } else if strike > 1 {
            print("\(strike) strikes")
        }
        if ball == 1 {
            print("1 ball")
        } else if ball > 1 {
            print("\(ball) balls")
        }
        if strike == 0 && ball == 0 {
            print("스트라이크, 볼 없음")
        }
    }
    
    func makeAnswer() -> Int {
        var a: Int
        var b: Int
        var c: Int
        
        repeat {
            a = Int.random(in: 1...9)
            b = Int.random(in: 1...9)
            c = Int.random(in: 1...9)
        } while a == b || b == c || c == a
        
        return a * 100 + b * 10 + c
    }
}
