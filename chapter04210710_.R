#비교연산자
10<=10
10>5
10>=5

n<-20
n %in% (c(10,20,30))

n<-10
n>=0 & n<=100

n<-1000
n>=0 & n<=100

!(10==10)
#연산
#벡터연산

#벡터와 스칼라의 연산
#벡터: 1차원 배열, 스칼라: 0차원 배열(하나의 값)
score<-c(10,20)
score+2 #score 벡터의 모든 데이터에 각각 2를 더하여 반환
score #score 벡터 자체는 변경되지 않아서 이전 값을 가지고 있음
#연산 결과를 score 변수에 반영하려면 다음과 같이 score에 연산 결과 저장
score<-score+2 #score벡터의 모든 데이터에 각각 2를 더하고,
#연산 결과를 score에 저장
#score가 변경된 것을 확인할 수 있음
score

#벡터와 벡터의 연산
#벡터 안의 각 데이터들 간에 연산이 발생된다.
score1<-c(100,200)
score2<-c(90,91)

sum_score<-score1+score2
sum_score
diff<-score1-score2
diff

#행렬과 스칼라 연산
#행렬 안의 각 데이터들 간에 연산이 발생된다..
m1<-matrix(c(1,2,3,4,5,6), nrow=2)
m1<-m1*10
m1
#행렬과 행렬의 연산
m1<-matrix(c(1,2,3,4,5,6,7,8,9), nrow=3)
m2<-matrix(c(2,2,2,2,2,2,2,2,2), nrow=3)
m1
m2
m1+m2

#흐름제어문 (조건문)
#if문
#조건문은 어떤 문장들을 실행할 지 하지 않을 지를 판단하는 문장이다.
#if문 소괄호 뒤에 조건을 쓰고, 그 조건이 TRUE이면 if 문 뒤 {} 안의 문장들이 수행된다.
#if(조건){} 문장
score<-95
if(score>=80){ #조건이 TRUE이므로 아래 문장들이 실행
  print("조건이 TRUE인 경우만 수행할 문장")
}
#if~else문
#if(조건){}else{}문장
score<-86
if(score>=91){     #이 조건의 결과는 FALSE
  print("A")       #조건이 TRUE일 때 수행할 문장
}else{
  print("B or C or D") #조건이 FALSE일 때 수행할 문장
}
#if~else if문
#if(조건){}else if(조건){}else{}문을 연속해서 사용
score<-86
if(score>=91){print("A")
}else if(score>=81){print("B")
}else if(score>=71){print("C")
}else if(score>=61){print("D")
}else{print("F")}
#ifelse()함수
#if~else 문장과 동일한 기능을 한다.
#ifelse(조건, "조건이 TRUE일 때 수항할 문장","조건이 FALSE일 때 수행할 문장")
score<-85
ifelse(score>=91,"A","FASLE일 때 수행")

#for 문
#문장들이 여러 번 수행할 수 있도록 제어하는 반복문 중 하나이다.

#다음 for문은 첫 수행 시 num에 1이 저장된다, 그 다음 1씩 증가된 값이 저장
#num이 5가 될 때까지 {print(num)}의 문장이 반복 수행
for (num in 1:3) {
  print(num)
}
#for 문 안에 if문이나 다른 제어문을 중첩해서 사용할 수 있다.
for (num in 1:5) {
  if(num%%2==0)
    print(paste(num,"짝수"))
  else
    print(paste(num,"홀수"))
}

#함수
#변수는 데이터를 저장하고 있는 반면에 함수는 프로그램 코드를 저장하고 있다.

#함수 생성
#변수에 데이터를 저장하는 대신 프로그램 코드를 저장하면 변수가 아니라 함수가 생성된다.
#함수를 생성하려면 function이라는 키워드가 필요하다. 함수에 저장할 프로그램 코드를 function()뒤 중괄호{}안에 작성한다.
a<-function(){  #a는 변수가 아닌 함수로 생성
  print("testa")
  print("testa")
}
#함수 생성이 함수의 실행을 의미하지는 않음
#a()라는 함수가 생성되었을 뿐임.

#함수 호출
#함수를 생성하는 것과 실행하는 것은 다르다.
#함수에 저장된 프로그램 코드를 실행하는 것을 함수 호출이라고 부른다.
#함수 호출의 방법은 함수 이름 뒤에 소괄호()를 붙이면 된다,
a() #a()함수가 호출되어 a() 함수에 저장된 프로그램 코드가 실행

#매개변수가 있는 함수
#함수를 생성할 때 함수 외부에서 데이터를 전달받아 이용하도록 만들 수 있다.
#함수 외부에서 데이터를 받아 저장할 변수를 매개변수라고 부른다. 
#매개변수 생성은 function 뒤 소괄호()에 변수명을 작성하면 된다.
#함수 프로그램 코드 안에서 이 변수의 데이터를 활용하여 프로그램을 작성할 수 있다.
a<-function(num){
  print(num)
}
#num 매개변수에 20을 넘겨주고, 함수를 호출. 이때, 20을 매개인자라고 부름
a(20)
a(10)

#두 개 이상의 매개변수가 있는 함수 정의
a<-function(num1, num2){
  print(paste(num1,"",num2))
}
#두 개 이상의 매개변수에 값을 전달하며 함수를 호출하는 방법은 여러가지가 있다.
#-순서대로 매핑
a(10,20)
#-매개변수 이름을 직접써서 데이터(매개인자) 전달
a(num1=10,num2=20)
a(num2=20,num1=10)
#매개변수이름을 직접 작성하는 경우는 순서는 상관이 없음.

#리턴 데이터가 있는 함수
calculator<-function(num1, op,num2){
  result<-0
  if(op=="+"){
    result<-num1+num2
  }else if(op=="-"){
    result<-num1-num2
  }else if(op=="*"){
    result<-num*num2
  }else if(op=="/"){
    result<-num1/num2
  }
  return (result)
}

n<-calculator(1,"+",2) #n은 calculator()로부터 반환받은 3을 저장
print(n)
