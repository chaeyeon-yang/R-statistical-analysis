#Statistical Analysis in R
#5. 상관 분석
#두 확률 변수 사이의 관련성을 파악하는 분석 방법
#상관 계수: 두 변수 간 관련성의 정도
#-0: 두 변수가 서로 독립인 경우 상관 관계가 없음.
#   P(X,Y)=P(X)*P(Y) 성립, 독립성 검정을 통해 검증할 수 있음
#-상관계수 값이 0이 아닌 경우: 데이터 간의 관계가 존재함
#분석방법
#-피어슨 상관계수
#-스피어만 상관계수
#켄달의 순위 상관계수

#(1)피어슨 상관계수
#두 변수의 선형적 상관 관계를 측정: [-1,1] 사이의 값

#상관 분석 in R
#R function: cor
#cor: 상관 계수를 구한다
cor(
  x, #숫자 벡터,행렬,데이터프레임
  y=NULL #NULL, 벡터,행렬,데이터프레임
  method=c("pearson","kendall","spearman")
  #계산할 상관 계수 종류 지정, 기본값은 pearson
)
#기타
symnum(
  x #숫자 또는 논리값의 벡터, 배열
    #x가 숫자인 경우 0.3,0.6,0.8,0.9,0.5를 기준으로 숫자들을
    #공백, 마침표, 쉼표, 더하기, 별표로 대체해 보여준다.
)
corrgram::corrgram(
  x, #한 행에 한 관측값들이 저장된 데이터 프레임 또는 상관계수 행렬
)
#예제: 상관 분석
#iris data에서 Sepal.Width, Sepal.Length의 피어슨 상관 계수
cor(iris$Sepal.Width, iris$Sepal.Length)
#상관계수 값이 작아 두 값 사이에 큰 상관 관계는 없으나
#Sepal.Width가 커짐에 따라 Sepal.Length가 작아지는 경향이 있음

#iris data에서 Species를 제외한 모든 컬럼의 피어슨 상관 계수
cor(iris[,1:4]) #-> 한 눈에 파악하기 힘듬!

symnum(cor(iris[,1:4]))
install.packages("corrgram")
library(corrgram)
corrgram(iris,upper.panel=panel.conf)

#상관 계수 검정
#상관 계수의 통계적 유의성을 판단하는 기법
#귀무가설 H0: 상관계수가 0이다
#대립가설 H1: 상관계수가 0이 아니다.
#R: cor.test()
cor.test(c(1,2,3,4,5),c(1,0,3,4,5),method = "pearson")
#Spearman, kendall로 method를 다르게 하여 검정해보고 
#3개 상관 계수가 서로 다른 경우 더 작은 숫자를 사용하는 것이 바람직

#실습: 상관분석
#Data: economics
#Question: 실업자 수와 개인 소비 지출에는 상관관계가 있는가?
economics=as.data.frame(ggplot2::economics)
cor.test(economics$unemploy,economics$pce)
#실습: 상관 행렬 히트맵 만들기
#상관 행렬: 여러 변수의 관련성을 한 번에 알아볼 수 있음
#data: mtcars
head(mtcars)
car_cor=cor(mtcars)
round(car_cor,2)
library(corrplot)
corrplot(car_cor)
corrplot(car_cor, method="color",
         type="lower",order="hclust",
         addCoef.col="black",
         tl.col="black",t1.srt=45,diag=F)

#Spearman 상관계수
#상관 계수를 계산할 두 데이터의 실제값 대신 두 값의 순위(rank)를 사용해
#상관 계수를 계산하는 방식
#값의 범위[-1,1]
#특성
#-데이터의 순위만 매길 수 있다면 적용 가능하므로 이산형, 순서형 데이터에 적용 가능
# 예) 국어점수와 영어 점수 간의 상관 관계? -Spearman(rho)

#6. 회귀 분석
#Question:
#cars 데이터는 1920년대에 측정한 데이터로 자동차의 주행 속도 speed와 브레이크를 밟았을때의 제동거리 dist를 저장하고 있다.
#(1) 자동차의 주행속도 speed와 브레이크 제동거리 dist는 서로 관련이 있는가?
#(2) 관련이 있다면 얼마나 밀접하게 관련이 있는가?
#(3) 주행 속도로 부터 제동거리를 예측할 수 있을까?
data(cars)
cor.test(cars$speed,cars$dist,method="pearson")
#ans: (1)주행속도 speed와 제동거리 dist는 관련이 있다 (p-value<0.05)
#     (2)cor값이 0.80이므로 강한 양적 상관관계를 가진다.
#     (3)의 해답을 얻을 수 있는 새로운 통계 기법, 회귀분석(Regression)

#회귀분석(Regression)
#하나 또는 둘 이상의 독립변수(설명변수)가 한 단위 증가할 때 그것이 종속 변수(반응 변수)에
#미치는 영향을 측정하기 위한 통계적 예측 모형
#-> 독립 변수의 값에 대응하는 종속 변수의 값을 예측하고자 할 때 사용
#-단순 선형 회귀 : 종속 변수 Y를 하나의 독립 변수 X로 설명하는 경우
#-다중 선형 회귀 : 종속 변수 Y를 두개 이상의 독립 변수로 설명하는 경우

#단순 선형 회귀 모델
#y=a+bx+e
#a(intercept), b(slope) -> 선형 관계로 설명되는 부분
#e -> 선형 관계로 설명 되지 않는 부분

#회귀 계수 추정 방법: 최소 제곱법
#잔차의 제곱의 합을 최소화하여 회귀 계수 추정
#회귀식의 추정 정도: 관측값 y의 편차로 추정

#SST=SSE+SSR
#(총제곱합)=(잔차제곱합)+(회귀제곱합)
#SSE가 작고 SSR이 클수록 회귀 모형이 자료들을 잘 설명해준다고 할 수 있음

#실습: 단순 선형 회귀 모델(생성)
#Question -(3)주행 속도로 부터 제동거리를 예측할 수 있을까?

#R의 단순 선형 회귀: lm(response_variable~explanatory_variable)
m=lm(dist~speed, cars)
m
#dist=-17.579+3.932*speed+e

#실습: 단순 선형 회귀 모델(검증)
summary(m)
#Intercept, speed 계수가 통계적으로 유의한지 알려줌(*)
#H0: coefficient is equal to zero
#H1: coefficient is not equal to zero

#Multiple R-squared and Adjusted R-squared
#->> 종속변수의 Regression model 이 독립 변수 데이터의 분산을 어느정도 설명하는지 비율

plot(m)

#실습: 단순 선형 회귀 모델(예측)
data(cars)
(m=lm(dist~speed), data=cars)
predict(m,newdata = data.frame(speed=3))
coef(m)
#-17.579095+3.972*3 = predict 값

#실습: 단순 선형 회귀 모델(예측&검정)
#(1) regression 모델 생성에 필요한 데이터(80%)와 테스트 데이터(20%) 마련
set.seed(100)
trainingRowIndex=sample(1:nrow(cars), 0.8*nrow(cars))
trainingData=cars[trainingRowIndex,]
testData=cars[-trainingRowIndex,]
#(2)Training data를 통해 regression 모델 생성
lmMod=lm(dist~speed, data=trainingData)
summary(lmMod)
#(3)Test data를 통해 예측 수행
distPred=predict(lmMod, testData)
#(4)Predicted data vs. Actual data: 예측 정확성 검증
actuals_preds=data.frame(cbind(actuals=testData$dist,
                               predict=distPred))
head(actuals_preds)
correlation_accuracy=cor(actuals_preds)
correlation_accuracy

#실습: 키와 몸무게 간의 관계 분석
#문제: 몸무게와 키와의 연관 관계 알아내기
#dataset: regression.csv

#1. 데이터 특성 파악: 산점도, boxplot 등
#2. 키와 몸무게 사이의 상관관계 확인
#3. 선형 회귀 모델 생성
#4. 검증
#5. 예측

reg=read.csv("regression.csv")
head(reg)
tail(reg)

cor(reg$height,reg$weight) #두 변수 사이에 상관관계가 매우 높음
r=lm(reg$height~reg$weight)#회귀 분석 실시
plot(r)
abline(r)
#회귀 분석 결과 확인
summary(r)
#Y=70.9418+1.5218*X
#height=70.9418+1.5218*weight
#추적 회귀선은 관측값을 약 93% 설명할 수 있다.
#reg$height의 coefficient가 통계적으로 유의미하다
plot(r)

#다중 선형 회귀
#독립변수가 2개 이상인 경우의 회귀분석
#R의 다중 회귀 분석
#lm(response_variable~explanatory_variables)

#실습1-1: 다중선형회귀
#Question
#iris data의 Sepal.Length를 Sepal.Width, Petal.Length, Petal.Width를 사용해 예측하시오
attach(iris)
m=lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width)
summary(m)
#Intercept Sepal.Width, Petal.Length, Petal.Width 의 p-value<0.05 이므로 모두 중요한 데이터이다.
#추적 회귀선은 관측값을 약 85% 설명할 수 있다.
#H0: 모든 계수가 0이다.
#H1: 하나 이상의 설명 변수의 계수가 0이 아니다.
#-> p-value값이 0.05보다 작으므로 대립가설을 채택한다.

#종속 변수를 제외한 모든 변수
m=lm(Sepal.Length~., data = iris)
summary(m)
#Species에는 versicolor, virginica, setosa가 있는데, 왜 setosa 계수가 없는가?

#범주형 변수는 가변수를 이용하여 표현함
#3개의 Species를 2개의 가변수를 사용해 표현할 수 있다.

#코딩 상태 확인
model.matrix(m)[c(1,51,101),]

#다중선형회귀(검증)
anova(m)
#다중선형회귀 시각화
#Species와 Sepal.Width를 사용하여 다중선형회귀 모델을 시각화
with(iris, plot(Sepal.Width, Sepal.Length, cex=.7,
                pch=as.numeric(Species)))
(m=lm(Sepal.Length~Sepal.Width+Species, data=iris))
coef(m)

#실습1-3: 다중선형회귀(상호작용)
#Question
#iris data의 Petal.Length를 Petal.Width와 Species와의 상호작용으로 예측하여라
#상호작용
#Petal.Length~Petal.Width
#Petal.Length~Petal.Width+Species
#Petal.Length~Petal.Width+Species+Petal.Width:Species
with(iris, plot(Species, Petal.Length, xlabs="Species",ylab="Petal.Length"))
m2=lm(Petal.Length~Petal.Width*Species, data=iris)
anova(m2)
summary(m2)

install.packages("interactions")
library(interactions)
interact_plot(m,pred="Petal.Width",modx="Species",plot.points=TRUE)

#선형 회귀 정확도 향상을 위한 기법
#(1) Data Transformation
#(2) Stepwise algorithm
#(3) Dealing with outliers

#1. Data Transformation
#선형회귀모델 조건 중에서 linearity에 문제가 있는 경우 사용할 수 있음

#실습: 몸무게와 뇌의 무게간의 관계 분석: 선형모델 생성
#생성된 모델 검증
library(MASS)
attach(mammals)
head(mammals)
plot(body,brain)

model1=lm(brain~body)
summary(model1)
#Median을 기준으로 Min과 Max가 동등거리 아님 =>Skewed
plot(model1)
mammals[19,]
mammals[32,]

#normality of residuals
with(mammals, plot(body, brain))
#원래 data에는 cluster가 있고 몇몇 큰 값들이 있음
#=>> 이 차이를 줄이기 위해 log를 취함
with(mammals, plot(body,brain,log="xy"))

model2=lm(log(brain)~log(body))
summary(model2)

par(mfrow=c(2,2), mar=c(2,3,1.5,0.5))
plot(model2)

plot(density(model1$resid), main="model1")
plot(density(model2$resid), main="model2")

#2. Stepwise Algorithm
#변수의 통계적 특성을 고려해 기계적으로 설명 변수를 채택하는 방법
#기준 통계치
#-F 통계량, AIC
#단계적 변수 선택 방법
#(1) 전진 선택법: 절편만 있는 모델에서 기준 통계치를 가장 많이 개선시키는 변수를 차례로 추가하는 방법
#(2) 변수 소거법: 모든 변수가 포함된 모델에서 기준 통계치에 가장 도움이 되지 않는 변수를 하나씩 제거하는 방법
#(3) 단계적 방법: 양방향

#실습: Stepwise Algorithm
#Question: attitude에 따른 overall rating 점수를 예측하시오
m=lm(rating~., data=attitude)
summary(m)

#예측식
#y=10.78+0.61*com+(-0.07)*pri+0.32*learn+0.08*rai+0.3*cri+(-0.21)*adv

#p값이 0.05보다 작으므로 통계적으로 의미가 있어서 이것을 이용해 예측이 가능하고
#예측 정확성은 Adjusted R-squared 값인 66%이다.
#하지만, 각 항목별 평가치의 p값을 보면 complaints와 learning만 유의하다고 판단된다(=0.05보다 작다)
#=> 유의하지 못한 항목을 제거하고 통계적 정확성을 높이기 위한 과정을 진행

install.packages("mlbench")
library(mlbench)
data(attitude)
m=lm(rating~., data=attitude)
m2=step(m,direction="backward")

summary(m)
summary(m2)
# stepwise algorithm 수행결과 Adjusted R-squared 값이 증가 한것을 확인할 수 있다.

#참고: 모든 경우에 대한 비교
data("BostonHousing")
m=lm(medv~., data=BostonHousing)
m2=step(m, direction="both")

#3. Dealing with Outliers
#Outliers(unusual data points)가 선형 회귀 모델에 영향을 주는 경우(influential),
#해당 outliers를 제거하여 선형 회귀 모델을 향상시킬 수 있음

#예제
#Long-Jump Example: 멀리 뛰기 예제
#Question: avg_takeoff 거리에 따른 best_jump 예측
dev.off()
best_jump=c(5.30,5.55,5.47,5.45,5.07,5.32,6.15,4.70,5.22,5.77,5.12,5.77,6.22,5.82,5.15,4.92,5.20,5.42)
avg_takeoff=c(.09,.17,.19,.24,.16,.22,.09,.12,.09,.09,.13,.16,.03,.50,.13,.04,.07,.04)
plot(avg_takeoff, best_jump)
jump_model=lm(best_jump~avg_takeoff)
abline(reg=jump_model, col="red")
summary(jump_model)
