# 1. R 데이터 불러오기 & 저장하기
#(dat,csv,txt,Rdata)

#데이터의 저장 및 불러오기
getwd()
no=c(1,2,3,4)
name=c("Apple","Banana","Peach","Berry")
price=c(500,200,300,400)
qty=c(5,2,7,9)
fruit=data.frame(No=no,Name=name,Price=price,Quantity=qty)
fruit
save(fruit,file="test.dat")
fruit

load("test.dat")
fruit

#엑셀데이터의 저장 및 불러오기

score=read.csv("score.csv")
score

no=c(1,2,3,4)
name=c("apple","pear","banana","peach")
price=c(100,200,300,400)

fruit=data.frame(No=no,Name=name,Price=price)
fruit
write.csv(fruit,"fruit.csv")

#일반데이터의 저장 및 불러오기

getwd()
b=scan("birth.txt",what="")
b
c=read.table("birth.txt", header=T)
c

vec1=c(1,2,3)
vec2=c(4,5,6)
mat=rbind(vec1,vec2)
mat

save(mat,file="testmat.txt")
dfile=load("testmat.txt")
dfile
mat

#데이터 프레임 구조 확인하기
(x=read.csv("a.csv"))
str(x)

#header가 없는 경우
x=read.csv("b.csv",header=FALSE)
x
#header 삽입하기
names(x)=c("id","name","score")
x

#nil이 저장된 경우
x=read.csv("c.csv",na.strings = c("nil"))
x
str(x)

#객체의 파일 입출력
x=1:5
y=6:10
save(x,y, file="xy.RData")
rm(list=ls()) #모든 변수 삭제
x
y
load("xy.RData") #파일(데이터) 불러오기
x
y

# 2. 데이터 조작, 처리, 가공
# (기본함수)

#apply 계열 함수
#벡터, 행렬, 데이터 프레임에 임의의 함수를 적용한 결과를 얻기 위한 함수
#데이터 전체에 대해 함수를 한번에 적용하는 연산 수행을 통해 
#데이터 조작, 처리
#(apply(),lapply(),sapply(),tapply(),mapply())


#apply(X, MARGIN, FUN)
#X: 배열
#MARGIN: 함수를 적용하는 방향
#(1:행, 2:열, c(1,2): 행,열 모두)
#FUN: 적용할 함수

head(iris)
apply(iris[,1:4],2,sum)

#lapply(X, FUN, 추가인자)
#X: 배열,리스트,표현식
#FUN: 적용할 함수

#결과를 리스트로 반환

(x=list(a=1:3, c=4:6))
lapply(x,mean)

#sapply(X,FUN,추가인자)
#X: 배열,리스트,표현식
#FUN: 적용할 함수 

#결과를 행렬,벡터 등의 데이터 타입으로 변환

sapply(iris[,1:4],mean)
class(sapply(iris[,1:4], mean))
x=sapply(iris[,1:4],mean)
as.data.frame(x)

#tapply(X, INDEX, FUN)
#X: 배열
#INDEX: 데이터를 그룹으로 묶을 색인, factor를 지정해야 하며,
#factor가 아닐 때는 자동 변환

#iris 데이터들에 대해, Speceis별 Sepal.Length의 평균 구하기

tapply(iris$Sepal.Length, iris$Species, mean)

#mapply(FUN, 적용할 인자)
#FUN: 적용할 함수

#rnorm()을 다음 세가지 조합에 대해 호출할 때
# *rnorm(n(난수 개수), mean, sd)

mapply(rnorm, +c(1,2,3),+c(0,10,100),+c(1,1,1))

#데이터를 그룹으로 묶은 후 함수 호출
#doBy package

#summaryBy
#: 데이터 프레임을 컬럼 값에 따라 그룹으로 묶은 후 요약 값 계산

install.packages("doBy")
library(doBy)

summary(iris)
summaryBy(Sepal.Width+Sepal.Length~Species, iris)

#orderBy
#: 지정된 컬럼값에 따라 데이터 프레임을 정렬

order(iris$Sepal.Width)
orderBy(~Sepal.Width, iris)

#sampleBy
#: 데이터프레임을 컬럼 값에 따라 그룹으로 묶은 후 sample 추출

#iris 데이터에서 각 Species 별로 10%의 데이터(5개씩) 추출 
sampleBy(~Species, frac=0.1, data=iris)

# 데이터 분리 및 병합
#split(): 주어진 조건에 따라 데이터를 분리한다.

#iris 데이터를 iris$Species에 따라 분리하고 결과를 리스트에 저장
split(iris, iris$Species)

#subset(): 주어진 조건을 만족하는 데이터를 선택한다.

#iris 데이터 중 조건을 만족하는 특정 부분만 취하여 반환: setosa종만 추출
subset(iris, Species=="setosa")

#merge(): 데이터를 공통된 값에 기준해 병합한다.
x=data.frame(name=c("a","b","c"), math=c(1,2,3))
y=data.frame(name=c("c","b","a"), english=c(4,5,6))
merge(x,y)

#데이터 프레임 컬럼 접근
#with()
#: 코드 블록 안에서 필드 이름만으로 데이터를 곧바로 접근할 수 있도록 함
#within()
#: with()와 동일한 기능을 제공하지만 데이터에 저장된 값을 손쉽게 변경하는 기능 제공

#**with은 접근, within은 접근하여 변경

#iris$Sepal.Length와 같이 쓰지 않아도 각 컬럼에 곧바로 접근 가능
with(iris, {
   print(mean(Sepal.Length))
   print(mean(Sepal.Width))
   })

x=data.frame(val=c(1,2,3,4,NA,5,NA))
x  

#x$val로 표시하지 않더라도, NA값을 평균으로 교체
x=within(x,{
  val=ifelse(is.na(val),median(val, na.rm=TRUE),val)
})
x

#데이터 프레임 컬럼 접근
#attach()
# :attach()이후 코드에서는 필드 이름만으로 데이터에
#곧바로 접근할 수 있도록 함
#detach()
#: attach()의 반대 역할도 detach() 이후 코드에서 더 이상 필드
#이름으로 곧바로 접근할 수 없도록 함

Sepal.width
attach(iris)
head(Sepal.Width)
detach(iris)
Sepal.width
