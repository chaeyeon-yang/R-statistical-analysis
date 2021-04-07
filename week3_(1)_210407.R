#데이터 가공: [4] 추가
#파생변수 추가: mutate
#1. 총합 변수 추가
#2. 평균 추가
#3. Pass/Fail 추가
#4. total에 따라 정렬

library(dplyr)
getwd()
exam=read.csv("csv_exam.csv")
exam%>%mutate(total=math+english+science,
              mean=(math+english+science)/3,
              test=ifelse(science>=60, "pass","fail")
              )%>%arrange(total)

#데이터 가공: [5] 집단별 요약
#집단별로 요약하기: group_by(), summarise()
exam%>%group_by(class)%>%summarise(mean=mean(science))

#데이터 가공 시습
# [반별로 수학 성적 요약하기(평균, 합계, 중앙값)]
exam%>%group_by(class)%>%summarise(mean_math=mean(math),
                                   sum_math=sum(math),
                                   median_math=median(math),
                                   n=n())
#데이터 가공: [6] 합치기
#가로로 합치기: left_join(data1,data2,by="기준변수명")
test1=data.frame(id=c(1,2,3,4,5), midterm=c(60,80,70,90,85))
test2=data.frame(id=c(1,2,3,4,5), final=c(70,83,65,95,80))
total=left_join(test1,test2,by="id")
total
#가로로 합치기: exam+담임선생님
#class 별 담임선생님 table 생성
name=data.frame(class=c(1,2,3,4,5), teacher=c("kim","lee","park","choi","jung"))
name
exam_new=left_join(exam,name,by="class")
exam_new

#세로로 합치기: bind_rows(data1, data2)
#※ 변수명이 다를 때는 rename을 이용하여 변수명을 동일하게 맞춘 후 합칠 것 
group_a=data.frame(id=c(1,2,3,4,5), test=c(60,80,70,90,85))
group_b=data.frame(id=c(6,7,8,9,10), test=c(70,83,65,95,80))
group_all=bind_rows(group_a, group_b)
group_all
