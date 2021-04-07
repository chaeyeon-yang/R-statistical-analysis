#R 프로그래밍
#흐름제어(조건문)

#if문 / ifelse문
x=4
if(x>=5){
  print("greater than 5")
}else{
  print("less than 5")
}

x=c(1,2,3,4,5)
ifelse(x%%2==0,"even","odd")

#switch: 다중조건문
x=c(1:10)
x
switch (x[2],
        "1" =print("one"),
        "2" =print("two"),
        "3" =print("three"),
        print("something else"))

#for, while, repeat
sum1<-0
for (i in seq(1,10,by=1)) {
  sum1<-sum1+i
}
sum1

sum1<-0
for (i in 1:5) {
  for (j in 1:5) {
    sum1<-sum1+i*j
  }
}
sum1

sum2<-0
i<-1
while(i<=10){
  print(i)
  i=i+1
}

sum2<-0
i<-1
while(i<=5){
  j<-1
  while(j<=5){
    sum2<-sum2+i*j
    j<-j+1
  }
  i<-i+1
}
sum2
#흐름 제어(사용자 정의 제어)
#break, next
#next:  현재 수행 중인 반복문 블록의 수행을 중단하고
#       다음 반복을 시작(=파이썬의 continue)
i<-1
repeat{
  print(i)
  i<-i+1
  if(i>10)break
}

sum3<-0
i<-1
repeat{
  sum3<-sum3+i
  i<-i+1
  if(i>10)break
}
sum3

i=0
while (i<=30) {
  i=i+1
  if(i%%2==0)print(i)
}

i=0
while (i<=30) {
  i=i+1
  if(i%%2!=0)next
  print(i)
}

#함수
#피보나치수열
fibo=function(n){
  if(n==1||n==2){
    return (1)
  }
  return(fibo(n-1)+fibo(n-2))
}
fibo(1)
fibo(2)
fibo(3)
fibo(4)

#계산기(calculator)
calculator<-function(x, type){
  switch (type,
          mean=mean(x),
          sum=sum(x),
          print("unexpected type"))
}
x<-c(1:10)
calculator(x,"mean")
calculator(x,"sum")
calculator(x,"sd")

#인자 전달 방식: 위치, 이름
f=function(x,y){
  print(x)
  print(y)
}
f(1,2)
f(y=2,x=1)

f=function(...){
  args=list(...)
  for (a in args) {
    print(a)
  }
}
f('3','4')
f('1','2','3')

#중첩함수
#함수안에 또 다른 함수를 정의하여 사용
#함수안에서 반복되는 동작을 한 함수로 만들고 이를 호출하여
#코드를 간결하게 표현할 수 있음
f=function(x,y){
  print(x)
  g=function(y){
    print(y)
  }
  g(y)
}
f(1,2)

#함수의 영역 규칙(scope)
#1.
n=1
f=function(){
  print(n)
}
f()
#2.
n=100
f=function(){
  n=1
  print(n)
}
f()
#3.
f=function(){
  a=1
  g=function(){
    a=2
    print(a)
  }
  g()
  print(a)
}
f()
#4.
b=0
f=function(){
  a=1
  g=function(){
    a<<-2       #전역변수로 만듬
    b<<-2
    print(a)
    print(b)
  }
  g()
  print(a)
  print(b)
}
f()

#함수 저장 및 활용
#save: 저장
#load: 불러오기
myF<-function(x){
  return(x*x)
}
myF(2)
save(myF, file = "myF,Rdata")
ls()
rm("myF")
myF(3)
load("myF.Rdata")
myF(4)
ls()
rm("myF")
myF<-function(x){return(x*x)}
myF2<-function(x){return(x)}
save(myF, myF2, file = "myFF.Rdata")
rm("myF","myF2")
ls()
load("myFF.Rdata")
ls()

#참고: 사용자 입력
#한 문자를 입력 받는 경우
fun=function(){
  answer=readline("y/n을 입력하세요: ")
  if(substr(answer,1,1)=="n")
    cat("n을 입력받았습니다.")
  else
    cat("y를 입력받았습니다.")
}
fun()
#한 문장을 입력 받는 경우
fun2=function(){
  x=readline("문장을 입력하세요: ")
  unlist(strsplit(x," "))
}
fun2()

#참고: 메뉴 생성
funMenu=function(){
  answer=menu(c("오렌지","포도","딸기"))
  if(answer==1){
    cat("your input is 오렌지")
  }else if(answer==2){
    cat("you input is 포도")
  }else{
    cat("your input is 딸기")
  }
}
funMenu()