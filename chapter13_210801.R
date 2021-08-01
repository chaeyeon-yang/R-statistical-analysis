# 5. 시계열 분석
# 5-1. 시계열 데이터의 개요
# 시계열 데이터(Timeseries Data): 시간에 따라 관측된 데이터
# -시간에 따른 기후 데이터, 주가지수 등

# 추세요인(trend factor): 데이터의 값이 시간에 따라 커지거나
# 작아지거나 수평인 추세

# 계절요인(seasonal factor): 짧은 구간으로 반복되는 트랜드가 있는 경우
# - 일주일 단위, 일년 단위, 사분기 단위, 계절 단위 등의 고정된 
#   주기에 따라 트랜드가 있는 경우

# 순환요인(cyclic factor): 명확한 이유 없이 알려지지 않은 주기를 가지고 
# 변화하는 데이터

# 불규칙 요인(irregular facor): 추세/계절/순환요인에 해당하지 않으면
# 불규칙 요인 또는 노이즈(noise)

# 5-2. 정상성
# 시계열 데이터의 통계 모델 -> 데이터가 정상성을 갖는다는 가정하에 사용

# 정상성 특징
# (1) 평균이 시간 흐름에 영향을 받지 않고 안정화
# (2) 분산이 시간 흐름에 영향을 받지 않고 안정화
# (3) 공분산이 시간 흐름에 영향을 받지 않고 안정화, 시차에만 의존

# 정상(stationary) 시계열 데이터: 어느 구간에서도 평균이 비슷
# 비정상(non-stationary) 시계열 데이터: 구간별로 평균이 다름

# 평균이 시간 흐름에 영향을 받지 않고 안정화되어 있는지 그래프 비교 

# 5-3. 비정상 시계열을 정상 시계열로 전환하는 방법

# ARIMA 모델은 시계열 데이터가 정상성 특징을 보일 때 효과적
# -시계열 데이터가 정상성인지 테스트하는 과정 필요
# -대부분의 시계열 데이터는 비정상성이며, 이 경우 정상 시계열 데이터로 만든 후 분석 수행

# 비정상 시계열 데이터를 정상 데이터로 만드는 방법
# (1) 평균이 일정하지 않은 경우 차분(difference)을 이용
# (2) 시간에 따라 분산이 일정하지 않은 경우 자연로그(변환, transformation)를 이용
# (3) 계졀요인을 갖는 비정상 시계열을 정상 시계열로 바꿀 때는 Season을 기준으로
#     차분. 예를 들어, 1년 주기의 계절성을 갖는 월간 (1월~12월) 데이터를 처분할 때 12를 기준으로 처분

# **차분이란 이전 시점의 데이터를 빼는 것

# 5-4. 시계열 모델
# 모델: 자기회귀 모델, 이동평균 모델, 자기호귀 누적이동평균 모델, 분해시계열
# -기존의 회귀 모델(AR 모델)은 서로 다른 피쳐(feature)/속성 간의 관계에 기반함

# 자기회귀(AR, AutoRegression)모델: 자신의 과거 값과의 관계에 기반함

# AR모델: 현재의 데이터가 몇 번째 이전 데이터까지 영향을 받는지 알아냄
# -과거 하나 이전 데이터만, 1차 AR 모델, AR(1) 모델: Yt = a1Y(t-1)+e
# -두 개의 과거 데이터까지, 2차 AR 모델, AR(2) 모델: Yt = a1Y(t-1)+a2Y(t-2)+e

# 5-5. 이동평균 모델
# 이동평균 모델(MA 모델): 백색잡음의 현재 값에서부터 q-시간 지연된 값까지 
# q+1개 항의 선형 가중합 모델

# 5-6. 자기회귀 누적이동평균 모델과 분해시계열
# 자기회귀 누적이동평균 (ARIMA, Autoregressive Integrated Moving Average) 모델:
# AR 모델과 MA 모델을 통합한 모델

# ARIMA(p,d,q) 모델
# -d는 비정상 시계열을 정상화하기 위해 몇번의 차분을 하는지를 의미
# -d=0이면 ARMA(p,q) 모델이라고도 부름
# -p는 AR모델과 관련이 있고, q는 MA 모델과 관련이 있음

# p=0이면 IMA(d,q) 모델이라고 부른다. d번 처분하면 MA(q) 모델이 된다.
# q=0이면 AR(p,d) 모델이라 부른다. d번 처분하면 AR(p) 모델이 된다.

# 분해시계열: 추세요인, 계절요인, 순환요인, 불규칙요인을 분해하여 분석하는 것



# [실습1]차분
# diff() 함수로 간단히 차분
n<-head(Nile)
n

# 1차 차분
n.diff1<-diff(n, differences=1)
n.diff1

# 2차 차분
n.diff2<-diff(n, differences=2)
n.diff2

# [실습2] 자기회귀 누적이동평균 모델
# forecast 패키지의 auto.arima() 함수를 이용하여 적절한 p,d,q 인자 결정하기

# (1) 먼저 forecast 패키지를 설치하고 불러온다
install.packages("forecast")
library(forecast)

# (2) 다음으로 auto.arima() 함수를 이용하여 Nile 시계열 데이터의 ARIMA 모델의 
# p,d,q 인자를 추정한다. 실행결과를 보면 ARIMA(1,1,1) 모델로 추정한 것을 알 수 있다.

auto.arima(Nile)

# (3) arima() 함수의 첫 번째 매개인자에는 시계열 데이터인 Nile을, 두 번째 매개인자에는
# 앞서 추정한 p=1, d=1, q=1 값을 order 매개변수의 값으로 전달하여 ARIMA(1,1,1) 모델을 생성하는 예를 보자

Nile.arima<-arima(Nile, order=c(1,1,1))
Nile.arima

# (4) 마지막으로 앞서 생성한 모델로 미래 수치를 예측하는 예를 살펴본다.
# H=5는 5개년도를 예측한다는 의미이다.

forecast(Nile.arima, h=5)

plot(forecast(Nile.arima, h=5))

# [실습3] 분해시계열
# ldeaths 데이터 분해하여 분석해보기
# (1) R에 내장되어 있는 ldeaths 데이터를 선 그래프로 확인해보면 다음과 같다.
plot(ldeaths)

# (2) ldeaths 시계열 데이터를 decompose() 함수로 분해하여 그래프로 표현해보자
ldeaths.decomp<-decompose(ldeaths)
plot(ldeaths.decomp)

# (3) 추세요인(trend)만 따로 확인해볼 수 있다.
ldeaths.decomp.trend<-ldeaths.decomp$trend
plot(ldeaths.decomp.trend)

# (4) 계절성(seasonality)만 따로 확인해볼 수 있다.
ldeaths.decomp.seasonal<-ldeaths.decomp$seasonal
plot(ldeaths.decomp.seasonal)

