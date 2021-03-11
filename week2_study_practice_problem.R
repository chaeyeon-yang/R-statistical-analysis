library(dplyr)
exam=read.csv("csv_exam.csv")
#1. 과목별 1,2,3 등 뽑기
exam%>%arrange(desc(math))%>%head(3)
exam%>%arrange(desc(english))%>%head(3)
exam%>%arrange(desc(science))%>%head(3)
#2. 평균 상위 3등 뽑기
means=exam%>%mutate((math+english+science)/3)
result=exam%>%arrange(desc(means))%>%head(3)
result
#3. 2번 생성된 데이터 excel.txt 저장
save(result,file="excel.txt")
#4. 과학성적 50점 이상 뽑기
exam%>%filter(science>=50)
#5. 과학성적 50정 이상, 영어성적 80점 이상 뽑기
exam%>%filter(science>=50 & english>=80)

