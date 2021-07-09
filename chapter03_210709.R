#벡터(Vector)
#하나 이상의 데이터를 저장할 수 있는 1차원 저장 구조(1차원 배열)
students_age<-c(11,12,13,20,15,21)
students_age

class(students_age)
length(students_age)

#벡터 인덱싱
#R의 인덱스는 1부터 시작한다.
students_age[1]
students_age[3]
students_age[-1] #1번 인덱스의 데이터만 제외하고 추출하기

#벡터 슬라이싱
#대괄호 안에 [시작인덱스:끝인덱스]라고 쓰면, 시작 인덱스의 데이터부터 끝 인덱스의 데이터 까지 접근한다.
students_age[1:3]
students_age[4:6]

#벡터에 데이터 추가, 갱신
score<-c(1,2,3)
score[1]<-10
score[4]<-4
score

#벡터의 데이터 타입
#벡터는 하나의 원시 데이터 타입으로 저장된다. 만약, 다양한 데이터 타입을
#섞어 저장하면 하나의 타입으로 자동 형변환 된다.
code<-c(1,12,"30") #문자 데이터 타입으로 모두 변경됨
class(code)
code

#순열 생성
#연속된 숫자를 생성하는 다양한 예
data<-c(1:10) #1부터 10까지 1씩 증가시켜 생성하기
data

data1<-seq(1,10)
data1

data2<-seq(1,10,by=2)
data2

data3<-rep(1,times=5)
data3

data4<-rep(1:3, each=3)
data4

#행렬(Matrix)
#표 형태와 같은 2차원 데이터 저장 구조를 가진다.
#메트릭스는 벡터와 마찬가지로 모두 같은 데이터 타입이어야 한다.

var1<-c(1,2,3,4,5,6)
#var1을 이용해서 2행 3열 행렬을 생성. 기본적으로 열 우선으로 값이 채워짐

x1<-matrix(var1, nrow = 2, ncol = 3)
x1
#var1을 이용해서 2열 행렬을 생성. 행의 개수는 자동 계산됨
x2<-matrix(var1, ncol=2)
x2

#일부 데이터만 접근
x1[1,]
x1[,1]
x1[2,2]

#행렬에 데이터 추가
#rbind()로 행을 추가할 수 있고, cbind()로 열을 추가할 수 있다.
x1
x1<-rbind(x1, c(10,10,10))
x1<-cbind(x1, c(20,20,20))
x1

#데이터프레임(Dataframe)
#행과 열을 가진 2차원 저장 구조
#벡터, 메트릭스와 다른 점은 각 열이 서로 다른 데이터 타입을 가질 수 있다는 것이다.
#데이터 프레임은 data.frame()함수로 생성할 수 있다.
no<-c(10,20,30,40,50,60,70)
age<-c(18,15,13,12,10,9,7)
gender<-c("M","M","M","M","M","F","M")

#데이터프레임 생성 예
students<-data.frame(no,age,gender)
students

#열의 이름과 행의 이름 확인
#각 열의 이름은 colnames()로, 각 행의 이름은 rownames()로 확인할 수 있고, 수정할 수도 있다.
colnames(students)
rownames(students)

colnames(students)<-c("no","나이","성별")
rownames(students)<-c('A','B','C','D','E','F','G')
students
#다시, 원래의 영문 열 이름으로 수정하자
colnames(students)<-c("no","age","gender")

#일부 데이터만 접근
#열 이름으로 특정 열에 접근하는 예
#데이터 프레임의 변수이름$열이름 또는 대괄호 안에 콤마(,)뒤 열의 이름을 써도 된다.

#- 데이터 프레임의 변수이름$열이름으로 특정 열에 접근하기
students$no
students$age
#- 대괄호 안에 열이름으로 특정 열에 접근하기
#  대괄호 안에 콤마(,)를 쓴 후 열이름을 쓴다. 열이름은 "" 또는 ''로 감쌈
students[,"no"]
students[,"age"]

#- 열 인덱스로 특정 열에 접근하는 예
students[,1]
students[,2]

#행 이름으로 특정 행만 접근하는 예
students["A",]
#행 인덱스로 특정 행만 접근하는 예
students[2,]
#행 인덱스, 열 인덱스 또는 행이름, 열이름으로 데이터에 접근
students[3,1]
students["A","no"]

#열 데이터 추가
#기존에 존재하지 않은 열 이름 또는 열 인덱스로 벡터를 저장하면 열이 추가된다.
#만약, 기존에 존재하는 열 이름이면 데이터가 갱신된다.
students$name<-c("이용","준희","이훈","서희","승희","하정","하준") #열 추가
students

#행 데이터 추가
#기존에 존재하지 않는 행 이름 또는 행 인덱스를 사용하여 행을 추가할 수 있다. 
#만약, 존재하는 행 이름 또는 행 인덱스이면 데이터가 갱신된다.
students["H",]<-c(80,10,"M","홍길동") #행 추가
tail(students)

#배열(Array)
#배열은 다차원 데이터 저장 구조이다.
#벡터나 매트릭스처럼 하나의 원시 데이터 타입으로 저장된다.
#array()로 배열을 만들 수 있다,.
var1<-c(1,2,3,4,5,6,7,8,9,10,11,12) #벡터 생성하기

arr1<-array(var1, dim=c(2,2,3)) #var1 벡터를 이용하여 3차원 배열 생성 
#2행 2열의 3차원 배열을 생성한다는 뜻
arr1

#리스트(List)
#배열과 다른 점은 키와 값 쌍으로 저장할 수 있고, 값에 해당하는 데이터가 벡터,행렬,배열,리스트 등
#어떠한 데이터 구조의데이터도 가능하다는 점이다.
#list()로 리스트를 생성하는 예를 보도록 하자.

#먼저, 리스트에 저장할 다양한 데이터 구조를 생성한다.
v_data<-c("02-111-2222","01022223333") #벡터
m_data<-matrix(c(21:26),nrow=2) #행렬
a_data<-array(c(31:36), dim = c(2,2,2)) #배열
d_data<-data.frame(address=c("seoul","busan"), #데이터프레임
                   name<-c("Lim","Kim"), stringAsFactors=F)

#list(키1=값, 키2=값, ...)와 같이 키와 값 쌍으로 리스트 생성
list_data<-list(name="홍길동", #name 키에 "홍길동" 값 저장
                tel=v_data, #tel 키에 v_data를 값으로 저장
                score1=m_data, #score1 키에 m_data를 값으로 저장
                score2=a_data, #score2 키에 a_data를 값으로 저장
                friends=d_data #friends 키에 d_data를 값으로 저장
)
#리스트는 다차원 데이터 저장 구조이다.
#- 리스트이름$키 또는 리스트이름[숫자]로 리스트의 일부 데이터에 접근할 수 있다.

#리스트이름$키
list_data$name #list_data에서 name키와 쌍을 이루는 데이터
list_data$tel #list_data에서 tel키와 쌍을 이루는 데이터

#리스트이름[숫자]
list_data[1] #list_data에서 첫 번째 서브 리스트

