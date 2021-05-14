#Statistical Analysis in R
#1. 난수 생셩 및 분포 함수

#실습: 난수 생성
rnorm(100, 0, 10) #평균 0, 표준편차 10인 정규 분포로 부터 난수 100개를 생성
plot(density(rnorm(100000,0,10))) #많은 수의 난수를 만들고 밀도 그림을 그리면 데이터의 분포를 알 수 있음
pnorm(0) #0.5
qnorm(0.5) #0

#실습: 확률 밀도 함수 활용
#12세 미만인 어린이가 하루에 마시는 평균 물의 양은 7.5이고 표준편차가 1.5인 정규분포를 따른다 가정
#어린이가 4리터 이하의 물을 마실 확률은?

x=seq(0,16,length=100)
y=dnorm(x, mean=7.5, sd=1.5)
plot(x,y, type="l",
     xlab="Liters per day",
     ylab="Density",
     main="Liters of water drunken by school children < 12 years old")
#4 이하의 물을 마실 확률: Lower tail
pnorm(4, mean=7.5, sd=1.5, lower.tail = TRUE)

#어린이가 8리터 이상의 물을 마실확률은? 정규 곡선에 해당 영역을 지정하여 색칠
plot.new()
plot(x,y,type="l",
     xlab="Liters per day",
     ylab="Density")
#8리터 이상 물을 마실 확률
lower=8
upper=15
#8과 15사이에 있는 x값 모으기
i=x>=lower & x<upper
polygon(c(lower, x[i], upper), c(0,y[i],0), col="red")
abline(h=0, col="gray")
#확률 계산
pb=round(pnorm(8, mean=7.5, sd=1.5, lower.tail = FALSE),2)
pb
pb.results=paste("Cumulative probaility of a child drinking > 8L/day", pb, sep=":")
title(pb.results)

#2. 기초 통계량
#평균: 수 많은 데이터를 대표하는 값 -> mean()
#분산: 흩어져 있는 데이터 상태를 추정하는 통계량 -> var()
#표준편차: 분산에 루트를 적용 -> sd()
#다섯수치 요약: 최솟값, 최댓값, 중앙값, 제 1사분위 수(25%), 제 3사분위 수(75%) -> fivenum(), summary()
#최빈값: 데이터에서 가장 자주 나타난 값 -> table(), xlabs()
#        table을 이용하여 데이터가 출현한 횟수를 센 분할표를 만들고, which, max()를 사용해 
#        최대 빈도가 저장된 색인을 찾는 방법으로 구함

#기초통계량 실습
mean(1:5)
var(1:5)
sd(1:5)
fivenum(1:11)
summary(1:11)
x=factor(c("a","b","c","c","c","d","d"))
x
table(x)
which.max(table(x))
names(table(x))[3]
#실습1: Incentive 데이터 분석
#다양한 조건에 따라 incentive를 분할하여 histogram으로 그려보고,
#전체 incentive 분포를 형성시킬 수 있는 요인들을 찾아 보기
employee=read.csv("employees_ex.csv")
str(employee)
hist(employee$incentive, breaks = 50)
summary(employee)
hist(employee$incentive[employee$year==2007], breaks = 50)
hist(employee$incentive[employee$year==2008], breaks = 50)
hist(employee$incentive[employee$gender=="F"], breaks = 50)
hist(employee$incentive[employee$gender=="M"], breaks=50)
hist(employee$incentive[employee$negotiate==FALSE], breaks = 50)
hist(employee$incentive[employee$negotiate==TRUE], breaks = 50)

#3. 데이터 추정
#데이터에 분포를 적합(fit)시키기
#propagate 패키지
# :표본의 분포를 여러가지 타입의 분포에 적합 시킨 후 가장 적절한 분포를 고를 수 있도록 지원
#-fitDistr()
# :데이터를 다양한 분포에 적합 시켜 봄
#  각 적합 결과를 AIC(Akaike information criterion), BIC(Bayesian information criterion) 값의 순서대로
#  오름차순으로 정렬하여 보여줌 -> AIC 혹은 BIC 값이 최소인 것이 좋은 모형 (Relative quality!)

#실습
install.packages("propagate")
library("propagate")
set.seed(275)
observations=rnorm(10000,5)
distTested=fitDistr(observations)

incentiveDis=fitDistr(employee$incentive)
#적합도 검정&가설 검정
#표본의 분포가 이론적인 분포에 잘 적합 하는지 확인 하는 과정
#방법: 단변량분포의 최대우도 적합 (검정법) -> 함수 fitdistr() -> 패키지 MASS

#가설검정
#H0: 귀무 가설(null hypothesis)
#    - 대립 가설의 반대 주장으로 통계적 검정의 대상이 되는 가설
#    - 두 현상간에 관련이 없다. 예) 차이가 없다, 00이다, 독립이다.
#H1: 대립 가설(alternative hypothesis)
#    - 연구자가 적극적으로 입증하고자 하는 가설
#    - 두 현상간에 관련이 있다. 예) 차이가 있다, 00이 아니다.
#    - "같지 않다","작다","크다"의 형태가 있음
#       -> Two sided test: 양측검정으로 같지 않음을 검정
#       -> One sided test: 크거나 작음을 검정
#p-value
#: 귀무가설을 참이라고 생각했을 때 주어진 데이터 또는 그보다 극단적인 데이터가 관측될 확률
#  예) "크다" 형태의 대립가설: 관측값 또는 그 값보다 큰 값을 볼 확률
#-- 기각역을 0.05(귀무 가설에 95%의 신뢰를 줌)로 둔 경우 p-value가 0.05보다 작으면
#   -> 귀무 가설을 참이라 믿었는데 관찰된 데이터는 그 가정하에서는 좀처럼 볼 수 없는 값임
#   -> 같은 분포라 볼 수 없음 
#   -> 귀무 가설이 사실이 아니라고 볼 수 밖에 없으므로 대립가설을 참이라고 판단
#   -> 귀무 가설 기각, 대립 가설 채택
#   기각역을 0.05(귀무 가설에 95%의 신뢰를 줌)로 둔 경우, p-value가 0.05보다 크면 귀무 가설 채택

#4. 기술통계: 빈도분석을 위한 분할표
#기술통계: 대표치로 자료 전체를 요약/ 정리된 표, 그래프를 통해 자료의 특징을 파악
#          -> 기초통계량, 빈도 분석
#추론통계: 둘 혹은 셋 이상의 집단 간의 차이/ 변수 간에 상관 혹은 영향관계를 표본 자료로 파악하여 모집단에 적용하는 분석 방법
#          -> 교차분석, T-test 분석, 분산분석, 상관관계, 회귀분석

#분할표
#데이터를 발췌: 한 개가 아닌 2개 이상의 데이터 군이 발췌될 때 사용되는 분석 과정
#: 대상이 되는 데이터의 성격에 따라 명목형 또는 순서형 데이터로 분류한 후에 도수를 표 형태로 나타낸 것
#: 작성된 분할표를 통해 정리된 자료에 대해 기본적인 검증을 수행하여 어떤 분석을 적용할 수 있는지 판단하게 됨
#교차분석 과정에 활용 될 수 있음
#- 독립변수와 종속변수가 모두 범주형(명목형/순서형)인 경우 두 변수 간 관계를 파악하는 기법

#예: 분할표 제작 실습
#R 분할표 작성 함수
#table(data frame 이름)
#xtabs(도수저장변수~분류를 나타내는 변수)
# *도수 저장 변수가 없을 때는 xtabs(~분류를 나타내는 변수)

#(1) 주어진 데이터에서 특정 문자의 출현 횟수를 기반으로 분할표를 작성하는 예
table(c("a","b","a","d","e","d","a","c","a","b"))
#(2) table을 이용하여 분할표를 작성하는 예
CTable=data.frame(x=c("3","7","9","10"),
                  y=c("A1","B2","A1","B2"),
                  num=c(4,6,2,9))
CTable
#(3) xtabs를 이용하여 분할표를 작성하는 예
xtabs(num~x, data=CTable) #x값에 대한 num의 값이 매칭되어 있다.
xtabs(num~y, data=CTable) #y값은 A1,B2의 2가지가 있는데, 이것에 대한 num의 y합이 분할표로 구성된다.

#예: 분할표 조작 실습
#분할표의 조작: margin.table 명령어 이용
CTable=data.frame(x=c("3","7","9","10"),
                  y=c("A1","B2","A1","B2"),
                  num=c(4,6,2,9))
CTable
temp=xtabs(num~x+y,data = CTable)
temp
#num의 값을 x와 y로 구성된 테이블에 넣는다.
#예: x가 3이고 y가 A1인 곳에는 4의값

#temp->margin.table 명령어에 적용할 데이터의 모습
margin.table(temp,1) #행에 대한 합(1이 행이라는 의미)
margin.table(temp,2) #열에 대한 합(2가 열이라는 의미)
margin.table(temp) #전체 데이터의 합

#분할표 실습: Cars93
library(MASS)
library(vcd)

#타입과 cylinder를 기준으로 빈도 계산
car_table_3=with(Cars93, table(Type,Cylinders))
car_table_3

car_table_4=xtabs(~Type+Cylinders, data=Cars93)
car_table_4
addmargins(car_table_4)
mosaic(car_table_4, gp=gpar(fill=c("Red","blue")),
       direction="v",
       main="Mosaic plot of CarType vs. Type+Cylinders", 
       main_gp=gpar(fontsize=10),
       gp_varnames=gpar(fontsize=10),
       gp_labels=gpar(fontsize=10))

#분할표 실습: UCBAdmissions:: graphics
data(UCBAdmissions)
str(UCBAdmissions)
UCBAdmissions.df=as.data.frame(UCBAdmissions)
ucb_table1=xtabs(Freq~Gender+Admit, data=UCBAdmissions)
ucb_table1
mosaic(ucb_table1,
       gp=gpar(fill=c("Red","Blue")),
       direction="v",
       main="Mosaic plot of UCB Admission vs. Gender")
options("digit"=3)
ucb_table2=prop.table(ucb_table1)
ucb_table2
chisq.test(ucb_table1)

#Incentive Data Analysis
employee=read.csv("employees_ex.csv")
str(employee)
hist(employee$incentive, breaks = 50)

#5. 추론통계(검증)

#변수의 유형
#독립변수: 입력값, 원인
#종속변수: 결과물, 효과

#분석방법
#교차분석-> 범주-범주 -> X2 -> p<0.05 =>대립
#독립표본, t-test -> 범주-연속 -> t-value -> p<0.05 =>대립
#분산분석 -> 범주-연속 -> F-value -> p<0.05 =>대립
#상관관계 분석 -> 연속-연속 -> r(rh 0-o) -> p<0.05 =>대립
#회귀분석 -> 연속-연속 -> F-value, t-value -> p<0.05 =>대립

#통계분석방법의 귀무/대립 가설 예제
#Chi-square Test, p>0.05 귀무가설 채택
#Fisher Test, p>0.05 귀무가설 채택
#Kolmogorov-Smirnov, p>0.05 귀무가설 채택
#Shapiro-Wilk normality test(정규성 검증), p>0.05 귀무가설 채택

#[1] 카이제곱 검정
#독립성 검정: 두 명목 변수 사이에 관계가 있는지 확인
#독립: 두 사건(혹은 변수)가 서로 영향을 주고 받지 않는 경우
#P(i,j)=P(i)*P(j)

#적합도 검정: 관측 결과가 특정한 분포로부터의 관측값인지 검정
#예) 이론에 의하면 A와 B가 3:1로 나와야한다.
#    실험결과가 A가 6022개, B가 2001개인 경우, 이 실험 결과는 이 이론과 
#    일치하는가 어긋나는가를 조사

#동질성 검정: 두 집단의 분포가 동일한지 검정
#예) 남학생과 여학생의 성별에 따라 국어, 영어, 수학에 대한 선호도가 같은가 다른가를 검증하는데 사용

#실습: 독립성 분석
#Question: 학생들의 성별에 따른 운동량에 차이가 있는가?
#H0: 성별과 운동은 독립이다. H1: 성별과 운동은 독립적이지 않다.
library(MASS)
data(survey)
SexExer=xtabs(~Sex+Exer, data=survey)
SexExer
chisq.test(SexExer)
#결론: p-value가 0.05보다 크므로 귀무가설을 기각할 수 없다.

#실습2
#child1과 child2 사이에 가지고 있는 장난감 비율의 차이는?
child1=c(5,11,1)
child2=c(4,7,3)
Toy=cbind(child1, child2)
rownames(Toy) =c("car","truck","doll")
Toy
chisq.test(Toy)
x=seq(0,10,0.1)
plot(x, dchisq(x,2), type="l")

#[2] 피셔검정
#피셔검정은 표본수가 적거나 분할표가 치우치게 분포된 경우에 적용
#카이제곱 검정을 했으나 경고가 있으므로, 정확한 결과를 위하여 피셔 검정을 수행한다.

#실습
fisher.test(Toy)

#[3] KS 검정
#KS(Kolmogorov-Smirnov Test): 두 분포가 같은지를 검정
#데이터의 누적 분포 함수와 비교하고자 하는 분포의 누적 분포 함수간의 최대거리를 통계량으로 사용하여 가설 검정
#[콜모고로프-스미노프 검정의 예]
x=rnorm(50)
y=runif(30)
#Do x and y come from the same distribution?
ks.test(x,y)

#[4] Shapiro Wilk 검정
#데이터가 정규분포를 하는지 검정
shapiro.test(rnorm(100, mean=5, sd=3))
shapiro.test(runif(100, min-2, max=4))