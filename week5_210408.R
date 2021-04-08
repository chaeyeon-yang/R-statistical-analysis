#화면 분할
#Split screens for multiple graphs

plot(10:1)
close.screen(all=TRUE)
split.screen(c(2,1))
split.screen(c(1,3), screen=2)
screen(1)
plot(10:1)
screen(4)
plot(1:10)

#그래프 지우기
dev.off()
#그래프를 pdf로 저장하기
dev.copy(pdf,"samplegraph.pdf")


#GRAPHS
#범주비교 - Bar Graph
#부분과 전체의 관계 - Pie Chart
#시간에 따른 변화 - Line Chart
#연결과 관계 구성 - Scatter Plot
#분포 파악 - Histogram
#여러 항목을 비교 - Box Chart

#산포도(Scatter Chart)
#데이터를 x축과 y축에 점으로 표현한 그래프
#연속값으로 된 두 변수의 관계를 표현할 때 사용

x=seq(1,10,0.1)
y=exp(x)

plot(x,y)
title("Exponential value")

#산포도 Options
#main="Title" : 제목설정
#Sub="sub=title" : 부제목 설정
#xlab="X lab", ylab="Y lab" :x축과 y축의 제목 설정

#그래프의 타입 지정
#type="p": 점 모양 그래프(기본값)
#|: 선모양, b:점과 선모양 ..

#선의 모양 설탕
#lty=0, lty="blank": 투명선
#lty=1, lty="solid": 실선 ..등등

#색 기호 등
#col=1, col="blue"..

#산포도 실습
data(ToothGrowth)
head(ToothGrowth)
dim(ToothGrowth)
plot(ToothGrowth)

#Vitamin C dose에 따른 치아 길이 그래프
plot(ToothGrowth$len, ToothGrowth$dose, main="Tooth Growth 
     according to Dose", xlab="Length", ylab="Dose")

#막대그래프
#데이터의 크기를 막대의 길이로 표현
#집단간 차이를 표현할 때 주로 사용

#season별 공 판매량
B_QTY=c(110,300,150,280,310)
S_QTY=c(180,200,210,190,170)
P_QTY=c(210,150,260,210,70)
B_TYPE2=matrix(c(B_QTY,S_QTY,P_QTY),5,3)
B_TYPE2

barplot(B_TYPE2, main="Ball Type별 시즌 판매량", beside=T,
        names.arg=c("BaseBall","SoccerBall","PingpongBall"),
        border="blue",col=rainbow(5),ylim=c(0,400))
legend(16,400,c("Season A","Season B","Season C","Season D", "Season E",
                "Season F"), cex=0.8, fill=rainbow(5))

#t(B_TYPE2)는 B_TYPE의 행과 열을 반대로 적용
barplot(t(B_TYPE2), main="시즌별 Ball 판매량", xlab="Season",ylab="판매량",
        beside=T, names.arg=c("A","B","C","D","E"),border="black", col=rainbow(3),
        ylim=c(0,400))

#막대그래프
barplot(t(B_TYPE2), main="시즌별 Ball 누적 판매량", xlab="season",ylab="판매량",
        names.arg=c("A","B","C","D","E"),border="black",col=rainbow(3), ylim=c(0,1000))
legend(4.5,1000,c("Baseball","Soccerball","PingpongBall"), cex=0.8, rainbow(3))

#점그래프
x=c(1:10)
dotchart(x,label=paste("Test",1:10),pch=11)

#선그래프
#데이터의 변화를 선으로 나타냄
x=c(1,2,3,4,5,6,7,8,9)
y=x*2
z=x*3
plot(x,y,type="o")
points(x,z,pch="+")
lines(x,z,col="blue")

plot(x,y,type="o",ylim=c(0,30))
points(x,z,pch="*")
lines(x,z,col="dark red")

#히스토그램
#데이터의 빈도를 나타내는데 사용
b=c(1,2,1,4,3,5,4,5,3,2,5,6,7,2,6,5,9,3,5)
hist(b)

#파이그래프
#전체와 부분의 관계를 나타내는데 쓰임
T_sales=c(210,110,400,550,700,130)
pie(T_sales, init.angle = 90, col = rainbow(length(T_sales)),
    main = "주간 매출 변동",labels=c("Mon","Tue","Wed","Thur","Fri","Sat"))
legend(1,1,c("Mon","Tue","Wed","Thur","Fri","Sat"),cex=0.8,fill = rainbow(length(T_sales)))

install.packages("plotrix")
library("plotrix")
erase.screen()
dev.off()
week=c("Mon","Tue","Wed","Thur","Fri","Sat")
ratio=round(T_sales/sum(T_sales)*100,1)
label=paste(week,"\n",ratio,"%")
pie3D(T_sales, main="주간 매출 동향", col=rainbow(length(T_sales)),cex=0.8, labels=label)
legend(-0.8,1.0,c("Mon","Tue","Wed","Thur","Fri","Sat"),cex=0.8,fill=rainbow(length(T_sales)))

#상자모양 차트
#데이터의 분포(퍼져있는 형태)를 직사각형 상자 모양으로 표현

#상자아래 세로선 : 아랫수염(하위 0~25%내 값)
#상자 밑면: 1사분위수 (하위 25% 위치 값)
#상자 내 굵은 선: 2사분위수 (하위 50% 위치 값)
#상자 윗면: 3사분위수 (하위75% 위치 값)
#상자 위 세로선: 윗수염 (하위 75~100%내 값)
#상자 밖 점 표식: 극단치 (범위를 벗어난 값)
A=c(110,300,150,280,310)
B=c(180,200,210,190,170)
C=c(210,150,260,210,70)
boxplot(A,B,C,col=c("yellow","cyan","green"), names=c("Baseball","Soccerball","Pingpongball"),
        horizontal=TRUE)

#부가적 그래프 기능
#그림을 그렸는데 그림을 지우고 싶은 경우
plot.new()
#현재의 그림을 유지하고, 그 위에 그림을 그리고 싶은 경우
par(new=T)
#화면에 점을 찍고 싶은 경우
points(x,y,options)

#부가적 그래프 기능: 실습
plot.new()
plot(-4:4, -4:4, type="n") #점을 찍기 위한 바탕 사각형과 눈금을 그린다
# +표시의 빨간 점을 200개 그린다
points(rnorm(200), rnorm(200), pch="+", col="red")

#앞의 그림을 유지하라
par(new=T)
#그림을 그 위에 그려라
points(rnorm(200), rnorm(200), pch="o",col="cyan")

#Sunflower 그래프
#산포도 그래프 중에서 중복되는 데이터가 많은 경우
#한 점에 여러 데이터가 있는 경우 점의 주변에 겹쳐진 만크 꽃잎을 그림
x=c(1,1,1,2,2,2,2,2,2,3,3,4,5,6)
y=c(2,1,4,2,3,2,2,2,2,2,1,1,1,1)
zz=data.frame(x,y)
zz
sunflowerplot(zz)

#Symbol 그래프
#Symbols: 3차원 데이터를 대상으로 그들간의 관계성을 직관적으로 보여줌
xx=c(1,2,3,4,5)
yy=c(2,3,4,5,6)
zz=c(10,5,100,20,10)
symbols(xx,yy,zz)

#3차원 그래프
#Persp
x1=seq(-3,3,length=50)
x2=seq(-4,4,length=60)
f=function(x1,x2){x1^2+x2^2+x1*x2}
y=outer(x1,x2,FUN=f)
persp(x1,x2,y)

#Contour
x1=seq(-3,3,length=50)
x2=seq(-4,4,length=60)
f=function(x1,x2){x1^2+x2^2+x1*x2}
y=outer(x1,x2,FUN=f)
contour(x1,x2,y)

