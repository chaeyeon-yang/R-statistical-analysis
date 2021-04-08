fibolist=function(size){
  if(size<=2){
    stop("The size should be greater than 2")
  }
  num1=1
  num2=1
  fibonacci=c(num1,num2)
  count=2
  repeat{
    count=count+1
    now=num1+num2
    fibonacci=c(fibonacci,now)
    num1=num2
    num2=now
    if(count>=size)break
  }
  print(fibonacci)
}

fibolist(5)
