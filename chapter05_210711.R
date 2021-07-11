#### R을 이용한 데이터 조작 방법
#### 데이터의 대략적인 특징 파악

#head() 함수
#head() 함수는 첫밴째 행부터 6번째 행까지 추출한다.
#head() 함수의 첫번째 매개인자로 데이터, 두번째 매개인자로 추출할 행 개수를 지정할 수 있다.

head(Orange) #첫번째 행부터 6번째 행까지 추출
head(Orange,3) #첫번째 행부터 3번째 행까지 추출

#tail() 함수
#tail() 함수는 마지막 행부터 6개의 행까지 추출한다.
#tail() 함수의 첫번째 매개인자로 데이터, 두번째 매개인자로 추출할 행 개수를 지정할 수 있다.
tail(Orange) #마지막 행부터 6개의 행까지 추출
tail(Orange,3)

#str()함수
#str()함수는 데이터의 구조를 파악할 수 있다.
str(Orange)
#위 예제의 출력 결과 중
#35obs. of 3 variables: Orange 데이터프레임은 총 35개의 관측치와 3개의 컬럼(변수)가 존재한다는 의미이다.
#$Tree : Ord.factor w/5 levels : Tree 변수는 Ordered factor 데이터 타입이며 총 5개의 범주(level)이 있다는 것
#그 다음 라인의 출력 결과로 age변수와 circumference 변수는 각각 number 데이터 타입임을 알 수 있다.


#summary() 함수
#summary() 함수는 수치형 데이터의 각 컬럼(변수)별 최소값(Min), 1사분위수,
#중앙값(Median), 3사분위수3rd Qu, 최대값(Max), 평균(Mean)를 구할 수 있다.
#범주형(factor)데이터의 경우는 각 범주별로 관측치 개수를 구할 수 있다.
summary(Orange)

#CSV파일 불러오기
#read.csv()로 csv 파일을 불러올 수 있다.
#다음은 c:/data 디렉토리의 "NHIS_OPEN_GJ_EUC-KR.csv"파일을 읽어 오는 예이다.
nhis<-read.csv("c/data/NHIS_OPEN_GJ_EUC-KR.csv")
head(nhis)

#디렉토리에서 파일의 존재를 확인했는데도 에러가 발생한다면, 문자의 인코딩 문제일 수 있다.
#다음과 같이 csv 파일을 읽을 때 문자 인코딩을 지정할 수 있다.
nhis<-read.csv("c:/data/NHIS_OPEN_GJ_EUC-KR.csv", fileEncoding = "EUC-KR")
nhis<-read.csv("c:/data/NHIS_OPEN_GJ_EUC-KR.csv", fileEncoding = "UTF-8")

#첫번째 행에 열 이름이 없이 데이터부터 존재할때 header=F, 문자열 데이터를 범주형 데이터로 
#읽기를 원할 때 stringAsFactor=TRUE를 사용한다.
sample<-read.csv("c:/data/sample.csv",header=F,
                     fileEncoding = "EUC-KR", stringsAsFactors = TRUE)

#외부파일 읽기
#엑셀 파일 불러오기
#엑셀 파일을 읽으려면 패키지를 설치해야 한다. 엑셀 파일을 다루는 여러가지 패키지 중 본서에서는
#openxlsx 패키지의 read.xlsx()를 살펴본다.
#먼저, openxlsx 패키지를 설치한 후 로드한다.

install.packages("openxlsx") #openxlsx 패키지 설치
library(openxlsx)
nhis_sheet1=read.xlsx("c:/data/NHIS_OPEN_GJ_EUC-KR.xlsx")
#디폴트로 엑셀 파일의 첫번째 sheet를 읽음.
nhis_sheet2=read.xlsx("c:/data/NHIS_OPEN_GJ_EUC-KR.xlsx", sheet=2)
#두번째 sheet를 읽음

#빅데이터 파일 불러오기
#data.table 패캐지의 fread()는 빠른 속도로 데이터를 읽어올 수 있어, 빅데이터 파일을 읽을 때 매우 유용하다.
#먼저, data.table 패키지를 설치한 후 로드한다.

install.packages("data.table")
library(data.table)
#fread()을 이용하여 대용량 csv 파일을 읽어온다.
nhis_bigdata=fread("c:/data/NHIS_OPEN_GJ_BIGDATA_UTF-8.csv",encoding="UTF-8")
str(nhis_bigdata)

#데이터 추출
#행제한 
#- 행 인덱스를 이용하여 행 제한
Orange[1,] #1행만 추출
Orange[1:5,] #1행부터 5행까지 추출
Orange[6:10,] #6행부터 10행까지 추출
Orange[c(1,5),] #1행과 5행 추출
Orange[-c(1:29),] #1~29행 제외하고 모든 행 추출

#- 데이터를 비교하여 행 제한
#  대괄호 안에서 데이터를 비교하여 추출할 행을 제한하는 코드를 작성할 수 있다.
Orange[Orange$age==118,] #age 컬럼의 데이터가 118인 행만 추출
Orange[Orange$age %in% c(118,484),]
#age 컬럼의 데이터가 118 또는 484인 행만 추출
Orange[Orange$age>=1372,]
#age 컬럼의 데이터가 1372와 같거나 큰 행만 추출


#열제한
#-열이름을 이용하여 열 제한
# 추출할 열(변수)이름을 대괄호 안 콤마(,)뒤에 작성하면 된다.

#Orange의 circumference 열만 추출. 행은 모든 행 추출
Orange[,"circumference"]
#Orange의 Tree와 circumference열만 추출. 행은 1행만 추출
Orange[1,c("Tree","circumference")]

#-열인덱스를 이용하여 열 제한
# 추출할 열 인덱스를 대괄호 아나 콤마(,)뒤에 작성하면 된다.
Orange[,1]
Orange[,c(1,3)]
Orange[,c(1:3)]
Orange[,-c(1:3)]

#행과 열 제한
#행과 열을 모두 제한하여 추출하는 예를 보도록 하자.
#데이터프레임의 대괄호 안에 행 인덱스나 비교 연산자를 이용하여 행을 제한하고 콤마(,)뒤 추출할 열이름이나 열 인덱스를 작성하면 된다.

#1행~5행, circumference 열 추출
Orange[1:5, "circumference"]
#Tree열이 3또는 2인 행의 Tree 열과 circumference 열 추출
Orange[Orange$Tree %in% c(3,2), c("Tree","circumsference")]


#정렬
#order()
#다음은 Orange 데이터프레임에서 circumference가 50보다 작은 행을 대상으로
#circumference 값을 기준으로 정렬한 후 출력하는 예이다.
OrangeT1<-Orange[Orange$circumference<50,]
OrangeT1[order(OrangeT1$circumference), ]
#내림차순 정렬은 order()안에 마이너스(-) 기호를 사용하면 됨
OrangeT1[order(-OrangeT1$circumference),]

#그룹별 집계
#Tree 별 circumference 평균
aggregate(circumference~Tree, Orange, mean)