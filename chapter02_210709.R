age<-20 #age 변수에 20을 저장함
age #age 변수에 저장된 데이터를 불러오기

age<-30 #저장되어 있던 20이 30으로 수정됨
age #age 변수에 저장된 데이터를 불러오기

#(1) 숫자 데이터 타입
age<-20 #age 변수에 20을 저장
class(age) #데이터 타입 확인

#(2) 문자 데이터 타입
name<-"LJl" #또는 name<-'LJl'
class(name) #데이터 타입 확인

#(3) 논리 데이터 타입
is_effective<-TRUE #is_effective <-T 와 동일
is_effective

is_effective<-FALSE #is_effective<-F와 동일
is_effective

class(is_effective) #데이터 타입 확인

#(4) 팩터(factor) 데이터 타입
#범주형 데이터를 저장하기 위한 데이터 타입이다.
#범주형 데이터는 명목형 데이터와 순서형 데이터가 있다.
#명목형은 크고 작음을 비교할 수 없는 범주 데이터를 말한다.
#순서형은 크고 작음이 비교가 가능한 범주 데이터를 말한다.

#("서울","부산","제주")의 전체 범주(factor)중 "서울" 저장
sido<-factor("서울",c("서울","부산",'제주'))
sido
class(sido) #데이터 타입 확인
levels(sido) #전체 범주(Category) 확인

#상수
#NULL 과 NA
#NULL: 변수에 값이 아직 정해지지 않았다는 의미로 변수를 초기화 할때 사용하는 상수이다.
#NA: 데이터 분석에서 중요한 용어인 '결측치'를 의미하는 상수이다.
a<-NULL
jumsu<-c(NA,90,100)

#Inf 와 NaN
#Inf: 무한대 실수를 의미하는 상수
#NaN: Not a Number를 의미하는 상수
10/0
0/0

