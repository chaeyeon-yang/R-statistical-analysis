#R 데이터 정제
#: 결측치 및 이상치 제거

#데이터 정제: (1)결측치 정제
#결측치: 누락된 값, 비어있는 값
#R에서는 NA로 표시됨
#R의 결측치 확인 함수: is.na()
library(dplyr)
df=data.frame(gender=c("M","F",NA,"M","F"), score=c(5,4,3,4,NA))
df
is.na(df)
table(is.na(df))

#데이터 정제: (1)결측치 정제 -제거
#1. 결측지 찾기
#2. 결측치 제거
#  - 결측치가 있는 행만 추출하여 제거: filter
#  - 여러변수에 동시에 결측치가 없는 데이터만 추출
#    (=결측치가 하나라도 있으면 제거)

table(is.na(df$gender))
table(is.na(df$score))
mean(df$score)
df
df_nomiss=df%>%filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
df_nomiss=df%>%filter(!is.na(score)&!is.na(gender))
df_nomiss
mean(df_nomiss$score)
df_nomiss=na.omit(df)
mean(df_nomiss$score)

#데이터 정제: (1)결측치 정제 -제외
#함수의 결측치 제외 기능 이용하기: na.rm=T
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)
df%>%summarise(mean_score=mean(score, na.rm = T))

#데이터 정제: (1)결측치 정제-대체
#데이터가 작고 결측치가 많은 경우 사용
#결측치를 제거하는 대신 다른 값을 채워 넣는 방법
#-평균, 최빈값으로 일괄 대체
#-통계 분석 기법으로 각 결측치의 예측값을 추정해 대체
df$score
#결측치를 평균값으로 대체
df$score=ifelse(is.na(df$score), mean(df$score, na.rm=T),df$score)
df$score

#데이터 정제: (2)이상치 제거
#이상치(Outlier): 정상 범주에서 크게 벗어난 값
#제거 순서
#1. 결측치(na)로 변환
#2. 분석에서 제외
outlier=data.frame(gender=c(1,2,1,3,2,1), score=c(5,4,3,4,2,600))
outlier
table(outlier$gender)
table(outlier$score)
outlier$gender=ifelse(outlier$gender==3,NA,outlier$gender)
outlier$score=ifelse(outlier$score>5,NA,outlier$score)
mean(outlier$gender)
mean(outlier$score)
outlier%>%filter(!is.na(gender)&!is.na(score))%>%group_by(gender)%>%
  summarise(mean_score=mean(score))
