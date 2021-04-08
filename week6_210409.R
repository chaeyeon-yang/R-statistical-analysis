#다양한 그래프 패키지 활용: ggplot
#ggplot::ggplot2 - 레이어 구조 형태로 그래프 생성
#Step1: 배경 설정 -> Step2: 그래프 추가(점,막대,선) -> 설정추가(축 범위, 색, 표식)
#+로 연결하여 원하는 그래프 생성

#(1) 산점도 그래프
#실습: MPG 데이터의 displ(배기량)과 hwy(고속도로 연비) 데이터를 표시
#X:displ, Y:hwy
library(ggplot2)
ggplot(data=mpg, aes(x=displ, y=hwy))+geom_point()+xlim(3,6)+ylim(10,30)

#(2) 막대 그래프
#geon_col()
library(dplyr)
df_mpg=mpg%>%group_by(drv)%>%summarise(mean_hwy=mean(hwy))
df_mpg
ggplot(data=df_mpg, aes(x=drv, y=mean_hwy))+geom_col()

#(3) 빈도 막대 그래프
#geom_bar()
#값의 개수(빈도)로 막대의 길이를 표현한 그래프
ggplot(data=mpg, aes(x=drv))+geom_bar()

#(4) 선그래프
#geom_line()
#시간에 따라 달라지는 데이터를 표현할 때 이용
#cf) 시계열 그래프: 일정 시간 간격을 두고 나열된 시계열 데이터를 선으로 표현
#예) 시간에 따른 미국 실업자 수의 추이
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()

#(5) 상자그림(box plot)
#geom_boxplot()
#구동방식별(drv) 고속도로 연비(hwy)
ggplot(data=mpg, aes(x=drv, y=hwy))+geom_boxplot()

#(6) qplot
data(iris)
dim(iris)
head(iris)
qplot(Sepal.Length, Petal.Length,
      data=iris, color=Species, size=Petal.Width)

data(Orange)
help(Orange)
View(Orange)
qplot(age,circumference, data=Orange,geom="line",
      colour=Tree,
      main="How does orange tree circumference vary with age?")

#R+구글맵을 이용한 시각화

#지도 시각화를 위한 R 패키지
#ggmap=구글 맵 또는 Stamen 맵을 정적으로 보여주는 기능들의 집합체
#ggplot2=그래픽 출력을 위한 기능을 제공
#        데이터 프레임 다수 데이터에 대한 풍부한 그래픽 시각화가 가능함
#       -> 지도에 그래프 정보를 추가
#openxlsx=Excel 파일 입출력 처리

#서울 세종문화회관 중심의 지도 출력

#패키지 설치 및 로딩
install.packages("ggmap")
library(ggmap)
#구글 지도 API키 설정
register_google(key="AIzaSyCDMA6obdL-jsF-3a0N1Of1Jq5BhdFlGHA")
#경도와 위도를 중심(세종문화회관)으로 하는 지도정보 생성
map<-get_googlemap(center=c(126.975684, 37.572752),
                   maptype = "roadmap", zoom=17,
                   size = c(320,320))

#지도 출력, 지도 여백 설정(여백이 없는 상태로)
ggmap(map,extent = "device")

#주소 이용 지도 출력
#지역명에 대한 경도, 위도 생성
#한글 지역명인 경우에는 utf-8형식으로 변환해야 함
gc<-geocode(enc2utf8("호미곶"))
#지도 중심 위치로 사용할 벡터 생성
lonlat<-c(gc$lon,gc$lat)
lonlat
#지도 중심과 마커 위치가 같은 상태
map<-get_googlemap(center=lonlat,marker=gc)
ggmap(map)

#예제: 지진 발생 지역 분포
#1. 구글 지도 API키 설정 (register_google())
#2. 지진 데이터 세트 읽기 (read.xlsx())
#3. 데이터 정제
#4. 지도 중심좌표 설정 (geocode())
#5. 구글 지도정보 생성 (get_googlemap())
#6. 지도 출력 (ggmap())
#7. 지진 규모 출력 (geom_point())

#외부 엑셀 파일을 읽기 위해 openxlsx 패키지를 추가로 설치
install.packages("ggplot2")
install.packages("openxlsx")
library(ggplot2)
library(openxlsx)
library(ggmap)

#구글 지도 API키 설정
register_google(key="AIzaSyCDMA6obdL-jsF-3a0N1Of1Jq5BhdFlGHA")
#외부 엑셀 데이터 세트 읽기 -> 첫째 시트의 4행부터 읽음
df<-read.xlsx(file.choose(),sheet=1,startRow=4)
head(df)
tail(df)

#위도 숫자 뒤 "N" 제거
#경도 숫자 뒤 "E" 제거
df[,6]=gsub("N","",df[,6])
df[,7]=gsub("E","",df[,7])
df2=data.frame(lon=df[,7],lat=df[,6], mag=df[,3])
str(df2)
df2[,1]=as.numeric(as.character(df2[,1]))
df2[,2]=as.numeric(as.character(df2[,2]))
df2[,3]=as.numeric(as.character(df2[,3]))
str(df2)

#지도 중심 좌표 설정
cen<-c((max(df2$lon)+min(df2$lon))/2,
       (max(df2$lat)+min(df2$lat))/2)
#지도 정보 생성
map<-get_googlemap(center=cen,zoom=6)
#지도 출력
gmap<-ggmap(map)

#지도 위해 도형(점)표시
#data: 데이터 프레임(df2)
#aes(): 위치 설정(df2에 있는 위치)
#size: 출력 도형 크기(df에 있는 지진 규모)
#alpha: 도형 색의 투명도(0~1, 숫자가 작을수록 투명도 증가)

gmap+geom_point(data=df2,
                aes(x=lon,y=lat),
                color="red",
                size=df2$mag,
                alpha=0.5)
