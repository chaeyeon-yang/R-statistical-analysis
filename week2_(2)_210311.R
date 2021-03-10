#2. 데이터 조작,처리,가공
#: dplyr package

#dplyr 패키지
#데이터 전처리: 분석에 적합하게 데이터를 가공하는 작업
#(일부 추출, 종류별로 나누기, 여러데이터 합치기 등의 작업 수행)

#dplyr: 데이터 전처리 작업에 많이 사용되는 패키지 
#Piple operator 제공: %>%

#filter(): 행추출
#select(): 열(변수)추출
#arrange(): 정렬
#mutate(): 변수 추가
#summarize(): 통계치 산출
#group_by: 집단별로 나누기
#left_join(): 데이터 합치기(열)
#bind_rows(): 데이터 합치기(행)

#데이터 가공 [1]: 추출

#조건에 맞는 데이터만 추출
#: object_name %>% filter(조건식)

install.packages(c("dplyr","flights"))
library(dplyr)

getwd()
exam=read.csv("csv_exam.csv")
exam%>%filter(class==1)
exam%>%filter(class!=1)
exam%>%filter(math>50)
exam%>%filter(class==1 & math>50)
exam%>%filter(math>90 | english>90)
exam%>%filter(class %in% c(1,3,5))

#데이터가공: [2] 변수 추출
#조건에 맞는 변수만 추출
#: object_name%>%select

exam%>%select(class,english)
exam%>%select(-english)

#1반 학생들의 영어점수 추출 실습
exam%>%filter(class==1)%>%select(english)

#데이터가공: [3]정렬
#정렬하기: arrage()

exam %>% arrange(math)
exam %>% arrange(class,desc(math))

