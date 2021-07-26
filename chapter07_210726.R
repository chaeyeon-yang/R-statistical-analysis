# 3-1. 백분위수와 사분위수
# 백분위수: 데이터를 정렬한 후, 특정 퍼센트 지점의 수
# 최소값: 0% 지점의 수
# 최대값: 100% 지점의 수
# 중앙값: 50% 지점의 수

# 백분위수-quantile()로 상위 10%에 해당되는 지점의 두 회사의 연봉이 궁금하다면
# 90% 지점의 백분위 수 구하기
# -90% 백분위 수
quantile(A_salary, 0.9)
quantile(B_salary, 0.9)

# 사분위수: 백분위수 중 0%, 25%, 50%, 75%, 100% 지점의 수
# -사분위수
quantile(A_salary)
quantile(B_salary)

# 3-2. 상자그림
# 상자그림(boxplot): 전체 관측값 범위와 사분위수, 그리고 이상값까지 시각적으로 확인해 볼 수 있는 그래프
# 상자그림-boxplot(): A기업과 B기업의 연봉 데이터를 상자그림으로 비교
boxplot(A_salary, B_salary, names=c("A회사 salary", "B회사 salary"))

# 3-3. 히스토그램
# 히스토그램: 구간별 값의 분포 시각화, 데이터가 연속형 수치데이터인 경우
# 데이터의 분포를 시각화하기에 좋은 그래프
# hist(): breaks 매개인자의 숫자만큼 구간을 나누어 X축에 배치하고, 그 구간의
# 데이터 개수를 Y축의 막대 길이로 표현
hist(A_salary, xlab="A사 salary", ylab="인원수", breaks=5)
hist(B_salary, xlab = "B사 salary", ylab="인원수", breaks=5)

# 막대그래프: 이산형 수치 데이터나 범주형 데이터의 경우 사용한다.
# 막대와 막대 사이를 떨어뜨려 표현한다.

# 히스토그램: 연속형 수치 데이터의 경우 사용한다.
# 막대와 막대 사이를 붙여서 그린다.

# 3-4. 도수분포표
# 도수분포표: 수집된 변수의 데이터를 범주 또는 동일한 크기의 구간으로 분류하고 
# 각 구간마다 몇 개의 데이터가 존재하는지를 정리한 표로 많은 데이터를 알기 쉽게 정리하는 통계적인 방법 중의 하나
# - 데이터 특성을 요약하고 정리하는 기술 통계학에서 가장 기본적인 역할

# 수치 데이터-> 도수분포표 생성시 cut() 함수
# -A_salary 변수의 데이터를 5구간으로 나눈 후 도수분포표를 생성하는 예

A_salary<-c(25,28,50,60,30,35,40,70,40,70,40,100,30,30)
cut_value<-cut(A_salary, breaks=5)
freq<-table(cut_value)

freq
# 범주형 데이터->table()함수로 도수분포표 생성
# -회사별 남녀의 도수분포 표를 새엇ㅇ하는 예
A_salary<-c(25,28,50,60,30,35,40,70,40,70,40,100,30,30)
B_salary<-c(20,40,25,25,35,25,20,10,55,65,100,100,150,300)
A_gender<-as.factor(c('남','남','남','남','남','남','남','남','남','여','여','여','여','여'))
B_gender<-as.factor(c('남','남','남','남','여','여','여','여','여','여','여','남','여','여'))
A<-data.frame(gender<-A_gender, salary<-A_salary)
B<-data.frame(gender<-B_gender, salary<-B_salary)
# 도수분포표를 생성
freqA<-table(A$gender)
freqA
freqB<-table(B$gender)
freqB

# 상대적 빈도표 -prop.table(): 한 범주에 속하는 빈도가 전체 관찰 수에 비하여 어느정도의 비중을
# 차지하고 있는가를 알아보는 상대적인 빈도가 유용한 경우

# A사의 남녀 도수분포표를 구해 저장한 freqA를 이용
prop.table(freqA) # 64.28% 남자, 35.71% 여자

# B사의 남녀 도수분포표를 구해 저장한 freqB를 이용
prop.table(freqB)

# 3-5. 막대그래프
# 막대그래프-barplot(): 범주형 데이터나 이산형 수치 데이터의 도수분포표를 시각화

# A사의 남녀 도수분포표를 구해 저장한 freqA를 이용
barplot(freqA, names=c("남","여"), col=c("skyblue","pink"), ylim=c(0,10))
title(main="A사")

# B사의 남녀 도수분포표를 구해 저장한 freqB를 이용
barplot(freqB, names=c("남","여"), col=c("skyblue","pink"), ylim=c(0,10))
title(main="B사")

# 3-6. 파이그래프
# 파이그래프-pie(): 분포의 시각화를 위해 사용, 범주가 몇 개 되지 않고, 차이가 확연한 경우
pie(x=freqA, col=c("skyblue","pink"), main="A사")
pie(x=freqB, col=c("skyblue","pink"), main="B사")
