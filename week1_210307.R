#1. R 기본 실습

#설치되어 있는 package 보기
search()
#지정한 페키지가 설치되어 있는지 확인,
#부착
library(igraph)
#지정한 패키지를 설치함
install.packages("igraph")

#상호대화형 모드: console에서 명령어를
#입력하고 바로 실행
#배치모드: 실행해야 할 명령어를 모아서 
#파일로 만들고 한번에 실행

# 1-1. R 기본 연산자 실습
#+-*/:덧셈,뺄셈,곱셈,나눗셈
#%/%:정수나눗셈
#%%: 나머지
#**: 거듭제곱

3+6*4/5
7%%4
7%/%4
4**3

#그 외에도 삼각함수, 로그함수, 지수함수 등이 있다.

#1-2. 변수 사용하기
#<=,=: 변수에 값 지정
#rm(): 변수 삭제
#ls(): 현재 사용중인 모든 변수 보기
#rm(list=ls()): 현재 사용중인 모든 변수 삭제

x<-2
x
y<-4
y
z=5
z
x+y
rm(z)
ls()
rm(list=ls())
ls()

#getwd: 현재 작업하는 working directory를 보여줌
#setwd: Working directory를 바꿈, sesstion->SetWorkingDirectory
#sink: 지정한 파일에 실행 결과를 저장
#cat: 특정 문자열을 화면에 보여줌
getwd()

cat("This is a test message")
sink("example.txt")
cat("This is a test message")
cat("you can find example.txt in your working directory")
cat("If you open the example.txt, you will see the texts you've typed")
cat("If you want to change a line, you must insert \n")
cat("Otherwise, all the texts are in one line\n")

sink()
cat("Now, back to the console")

#1-3. 기본적인 명령어 실습
#head, tail, summary, nrow, ncol, str

head(iris)
ls()
summary(iris)

#2. R's data type
#2-1. 벡터
#백터: 1차원형태로 동일한 타입의 자료로 구성
#c(): 백터를 생성하는 명령어
#N1:N2: 지정한 숫자 범위 만큼을 백터로 생성하는 명령어
#seq(): 설정한 규칙대로 백터를 생성하는 명령어
#rnorm(): N(0,1)에서 난수를 생성하는 명령어 

v1=c(1,2,3,4,5)
v1
v2=-5:5
v2
v3=seq(from=1, to=5, by=0.5)
v3

#rnorm(): 지정한 숫자 개수만큼 난수를 생성하는 명령어 
v4=rnorm(20)
v4

#백터의 자료에 대한 기본 연산
#mean(x): x의 평균
#order(x): x를 오름차순으로 정렬
#rev(x): x를 내림차순으로 정렬
#range(x): x의 범위를 구함
#sd(x): x의 표준편차
#sort(x): 오름차순 정렬
#cf) sort(x, decreasing=TRUE): 내림차순 정렬
#length(x): x의 길이

mean(v1)
mean(v2)
mean(v3)
order(v1)
rev(v1)
sd(v2)
sort(v4)
sort(v4, decreasing=TRUE)
length(v4)

#백터형 자료 조작
#x[2]: x행렬 2번째 값 출력
#x[-2]: 2번째 값을 제외한 x행렬 출력
#x[2<x & x<5]: 조건에 맞는 값 추출

x=c(1,4,6,8,9)
x
x[2]
x[-2]
x[3]=4
x
x[2<x & x<5]

#replace(x, c(2,4), c(32,24)): 바꿀위치에 바꿀 내용을 기입해 원래의 값을 바꾼다.
#append(x,y): x에 y값을 합쳐 나열한다.
#append(x,y,after=2): x의 2번째 값 뒤에 y값을 삽입한다.
#c(1,2)+c(4,5): 백터의 각 자릿수 덧셈
#c(1,2,3)+1: 벡터 각 자릿수에 값 더하기

x=c(1,4,6,8,9)
x
y=replace(x, c(2,4), c(32,24))
y
w=append(x,y)
w
z=append(x,y,after=2)
z
c(1,2)+c(4,5)
c(1,2,3)+1

#집합연산

#순서에 따른 집합 비교
x=c(1,2,3)
y=c(4,5,6)
x==y
#x,y의 합집합
union(x,y)
#x,y의 교집합
intersect(x,y)
#x,y의 차집합
setdiff(x,y)
#같은 집합인지 비교
setequal(x,y)
#지정한 원소가 집합에 존재하는지 확인
is.element(3,x)

#논리형 벡터

#runif(): 0~1사이의 값을 지정한 숫자 개수만큼 생성
x=runif(5)
x
(0.4<=x)&(x<=0.7)
any(x>0.8)
all(x<0.7)
is.vector(x)

#문자 자료 벡터

#rep(): 주어진 백터 값을 times 횟수만큼 반복하여 저장
(x=rep(c("a","b","c"), times=4))
unique(x)
match(x,c("a"))
y=c("d","e","f")
y
z=paste(x[1],y[3])
z

#2-2. 행렬
#행렬: 2차원 형태로 동일한 타입의 자료로 구성
#생성: 벡터 데이터 생성 후 합침

#rbind(): row(행)을 기준으로 백터를 합침
#cbind(): column(열)을 기준으로 백터를 합침
row1=c(1,2,3)
row1
row2=c(4,5,6)
row2
row3=c(7,8,9)
row3
mat1=rbind(row1,row2, row3)
mat1
(mat2=cbind(row1,row2,row3))

#문자열 행렬 데이터 생성
chars=c("a","b","c","d","e","f","g","h","i","j")
mat1=matrix(chars)
mat1
#column(열)의 개수가 5개인 행렬 데이터 생성
mat2=matrix(chars, ncol=5)
mat2

#행렬 데이터 조작&추출
mat3=matrix(1:8, nrow=2)
mat3
mat3*3; mat3
mat3*c(10,20); mat3

x=matrix(1:12,nrow=3,dimnames=list(c("R1","R2","R3")
                                   ,c("C1","C2","C3","C4")))
x
x[7]
x[,2:4]
x[,2]
x[,-2]

#실습: 행렬 덧셈
mat1=matrix(1:9,nrow=3); mat1
mat2=matrix(10:18,nrow=3); mat2
mat3=mat1+mat2
mat3

#2-3.데이터프레임
#2차원 형태로 각 컬럼별로 다른 형태의 데이터를 가짐
#Row name, Col name

#생성: 배열데이터를 모아 구성함
no=c(1,2,3,4)
name=c("Apple","Banana","Peach","Berry")
prices=c(500,200,200,50)
qty=c(5,2,7,9)
fruit=data.frame(No=no,Name=name,Prices=prices,QTY=qty)
fruit
rownames(fruit)=c("F1","F2","F3","F4")
fruit

#조작
#특정 행 추출
fruit['F1',]
fruit[1,]

#특정 컬럼 추출
fruit$Name
fruit$QTY

#연속된 컬럼 추출
fruit[,2:3]

#파생변수 만들기
fruit$TotalPrice=fruit$Prices&fruit$QTY
fruit

#실습: 데이터프레임
name=c("철수","영희","순이","영철")
english=c(90,80,60,70)
math=c(50,60,100,20)
score=data.frame(Name=name,English=english,Math=math)
score
score$AVG=(score$English+score$Math)/2
score

#2-4. Factor
#문자형 데이터가 저장되는 벡터의 일종
#범주형 자료의 저장에 사용:
#저장하는 문자값들이 어떠한 종류를 나타내는 값일 때
#예) 성별, 혈액형
#장점: 이미 지정된 값의 종류 이외의 값이 들어오는 것을 막을 수 있음

f=c("A","B","B","O","AB","A")
f_factor=factor(f)
f
f_factor #저장되는 값들에 따옴표가 표시되지 않음
levels(f_factor)
f[5]
f_factor[5]
f_factor[7]='B'
f_factor[8]='C'
#Factor의 문자값을 숫자로 바꾸어 분석 작업에 사용할 때 
as.integer(f_factor)

#2-5. 리스트
#(키, 값)의 형태로 데이터를 구성
#생성
member=list(name="Lee",address="seoul",tel=01088881111,ssn=010815)
member
#조작
member$name
member[1:3]
member$pay=100
member