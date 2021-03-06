# 3. 단순선형회귀
# 3-1. 단순선형회귀
# 회귀(regression)의 사전적 의미: 한 바퀴 돌아서 본디의 자리나 상태로
# 돌아오는 것
# 선형회귀(linear regression): 종속변수 Y와 한 개 이상의 독립변수 
# (또는 설명변수) X와의 선형 상관관계를 모델링하는 회귀분석 기법
# -종속변수: 영향을 받는 변수, 예측의 대상이 되는 변수로 관심변수, 반응변수
# -단순선형회귀: 한 개의 설명변수에 기반한 경우
# -다중선형회귀: 둘 이상의 설명변수에 기반한 경우

# 추세선 그리기
# -오차가 가장 작은 가운데 선이 가장 좋은 추세선
# -예측한 데이터와 실제 데이터의 차이 계산
# -차이가 가장 작은 선 선택
# 차이=오차(error)/잔차(residual) 또는 손실(loss)/비용(cost)

# 하나의 종속변수와 하나의 독립변수에 대한 산점도 그래프, 추세선 선택하기 

# 선형회귀 모델: 췟선을 이요하여 종속변수의 값을 예측하는 모델
# -단순선형회귀 모델: 독립변수가 하나인 경우
# -기울기와 절편을 구해 단순선형회귀 모델을 만들 수 있음

# 하나의 종속변수(Y)와 하나의 독립변수(X)가 있고 오차항(e)이 있는 단순선형회귀 모델식
# Y = B0 + B1X + e [실제 값]

# 회귀계수(Coefficients): 졀편(B0)과 기울기(B1)
# 오차항이 없는 단순 선형회귀 모델의 식
# Y햇 = B0 + B1X [예측 값]

# 최소제곱법: 잔차의 단순합이 아닌 제곱합을 구하여 그 값이 최소인 회귀모델을 생성
# ==> 이상치(오차가 큰 값)에 더 높은 가중치를 주기 위함임!!!
# ==> 최소제곱볍 == 평균 오차 제곱합

# 최소 제곱 추정량(Least Squares Estimator, LSE): 최소제곱법으로 구해진 회귀 계수
# (Coefficients) 추정량

# 3-2. 결정계수
# 결정계수(R-squared, coefficient of determination, R^2)
# : 추정한 선형모델이 주어진 데이터에 적합한 정도를 재는 척도

# 전체 분산(SST) 값, 회귀 모델로 설명되는 분산(SSR) 값으로 계산 가능
# 결정계수(R-squared, R^2): 전체 분산의 크기(SST) 중 모델이 설명하는 부분
# (SSR)의 비중을 구하는 것
# - 0에서 1 사이의 값을 가지며, **1에 가까울수록 설명력이 좋은 모델

# SSR(설명되는 분산)/SST(전체 분산)
# == SST-SSE/SST

# [실습1] 단순선형회귀|모델 생성
# 예제) Orange 데이터는 다음과 같이 각 나무의 종류(Tree)와 나무 나이
# (age), 나무 둘레(circumference) 변수의 관측값이 존재한다.
data(Orange)
head(Orange)

# Orange 데이터프레임의 나무 둘레를 나타내는 circumference 변수를 종속변수로,
# 나무 나이를 나타내는 age 변수를 설명변수로 하는 단순선형회귀 모델을 다음과 같이 생성할 수 있다.

# circumference = B0 + B1age + e

# lm() 함수로 단순선형회귀 모델을 생성한 예
model<-lm(circumference~age, Orange)
model

# 포뮬러(formula)매개인자: 무엇이 종속변수 이고, 무엇이 설명변수인지를 표현하는 식
# -'종속변수-설명변수'와 같이 표현하므로 lm() 함수의 첫 번째 인자로 circumference~age를 쓰고
#  두 번째 인자로 Orange 데이터를 사용
# 회귀계수는 각각 17.3997, 0.1068로 추정되어 다음과 같은 모델이 생성되었다.

# circumference = 17.3997 + 0.1068age + e

# coef() 함수를 이용하여 회귀계수만 출력하기
# 회귀계수
coef(model)

# residuals() 함수로 잔차(residuals)확인
# ==> 학습데이터와 실제 데이터와의 잔차 확인 가능
# 잔차
r<-residuals(model)
r[0:4]

# 생성한 선형회귀 모델이 예측한 값과 잔차를 더하면 실제값과 동일해야 한다.
# 예측한 값과 잔차를 구하여 그 합이 실제값과 같은지 비교해보자.

# fitted() 함수로 model이 예측한 값 구하기
f<-fitted(model)

# residuals() 함수로 잔차 구하기
r<-residuals(model)

# 예측한 값에 잔차를 더하여 실제 값과 동일한지 확인해보자.
# 예측한 값과 잔차 더하기
f[0:4]+r[0:4]

# 위의 값이 다음의 실제 데이터와 동일함을 확인할 수 있다.
# 실제 값
Orange[0:4, 'circumference']

# 잔차 제곱합 구하기
# 잔차 제곱합
deviance(model)

# predict.lm() 함수로 나이가 100인 나무의 둘레를 예측하기
# 예측
predict.lm(model, newdata=data.frame(age=100))

summary(model) # 모델의 설명률은 83%
cor(Orange$circumference, Orange$age)
cor(Orange$circumference, Orange$age) ^2
