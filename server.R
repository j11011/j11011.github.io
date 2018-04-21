#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shiny)
library(shinyjs)
library(scales)

bsearch=function(nMin,nMax,nTarget){
  nTarget=round(nTarget)
  text1=paste("Search from",nMin,"to",nMax,"the number",nTarget,":\n")
  text2=""
  arr=c(nMin:nMax)
  
  arr2=arr
  
  while(1){
    if(nTarget>nMax | nTarget<nMin){
      text1 = "Number not in array"
      break()
    }
    search1=round(mean(arr2))
    
    if(search1==nTarget){
      #print(paste("Encontre",nTarget))
      text2=paste("Found",nTarget)
      text1=paste(text1,text2,"\n",sep="")
      break
    }else if(search1>nTarget){
      nMax=search1-1
      arr2=c(nMin:nMax)
      #print(paste(search1,"es mayor a", nTarget ,"ahora buscare de",nMin,"a",search1))
      text2=paste(search1,"is greater than", nTarget ,"now I will look from",nMin,"to",nMax)
    }else if(search1<nTarget){
      nMin=search1+1
      arr2=c(nMin:nMax)
      #print(paste(search1,"es menor a", nTarget ,"ahora buscare de",search1,"a",nMax))
      text2=paste(search1,"is less than", nTarget ,"now I will look from",nMin,"to",nMax)
    }
    text1=paste(text1,text2,"\n",sep="")
  }
  return(text1)
}


bubble_ord=function(arr){
  text1=""
  #print(any(is.na(arr)))
  if(any(is.na(arr))==F){
    for(i in (2:length(arr))){
      ii=i-1
      for(j in c(1:(length(arr)-ii))){
        if(arr[j]>arr[j+1]){
          aux=arr[j]
          arr[j]=arr[j+1]
          arr[j+1]=aux
        }
        text1=paste(text1,paste(arr,collapse=","),"\n")
      }
    }
  }else{
    text1="The vector is wrong"
  }
  
  return(text1)
}

qs<-function(vec,start=1,finish=length(vec),text1="") {
  if(length(vec)>1){
    if (finish>start) {
      
      pivot<-vec[start]
      N<-length(vec)
      window<-((1:N)>=start) & ((1:N)<=finish)
      low_part<-vec[(vec<pivot) & window]
      mid_part<-vec[(vec==pivot) & window]
      high_part<-vec[(vec>pivot) & window]
      
      if (start>1) text1=paste(text1,paste(vec[1:(start-1)],collapse = " "),"| ")
      
      text1=paste(text1,paste(low_part,collapse = " "),">>>",
                  paste(mid_part,collapse = " "),"<<<",paste(high_part,collapse = " "))
      #cat(low_part,">>>",mid_part,"<<<",high_part)
      if (finish<N) text1=paste(text1," |",paste(vec[(finish+1):N],collapse = " "))
      text1=paste(text1,"\n")
      
      vec[window]<-c(low_part,mid_part,high_part)
      if (length(low_part)>0) {
        low_top<-start+length(low_part)-1
        l_res<-qs(vec,start,low_top,text1=text1)
        text1=l_res[[2]]
        vec[start:low_top]=l_res[[1]][start:low_top]
      }
      if (length(high_part)>0) {
        high_bottom<-finish-length(high_part)+1
        l_res<-qs(vec,high_bottom,finish,text1=text1)
        text1=l_res[[2]]
        vec[high_bottom:finish]=l_res[[1]][high_bottom:finish]
      }
    }
  }else{
    vec=c(0)
    text1=""
  }
  
  
  return(list(vec,text1))
}


matrix_frame=function(n){
  if(n>1){
    text="  1"
    for(i in (2:n)){
      text=paste0(text,",",toString(i))
    }
    text=paste0(text,"\n")
    for(i in (1:n)){
      text=paste0(text,toString(i)," ")
      for(i2 in (1:(n-1))){
        text=paste0(text,",")
        #cat(text,"\n")
      }
      text=paste0(text,"\n")
    }
  }else{
    text="Error!"
  }
  
  
  return(text)
}




borrarFirstn=function(n,text1){
  for(i in (1:n)){
    text1=gsub(paste0("\n",toString(i)),"\n",text1)
  }
  text1=gsub(" \n",",\n",text1)
  con <- textConnection(text1)
  data <- read.csv(con)
  #cat(text1)
  colnames(data)=c(1:ncol(data))
  
  return(data)
}





# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  v <- reactiveValues(df_t= "0",df=data.frame())
  #binary
  observeEvent(input$buscar1,{
    nmin=isolate(as.numeric(input$min1))
    nmax=isolate(as.numeric(input$max1))
    ntarget=isolate(as.numeric(input$target1))
    output$text1 <- renderText({bsearch(nmin,nmax,ntarget)})
  })
  #bubble
  observeEvent(input$ord2,{
    arr2=as.numeric(unlist(strsplit(input$arr2, split=",")))
    output$text2 <- renderText({bubble_ord(arr2)})
  })
  
  #quicksort
  observeEvent(input$ord3,{
    text1=""
    
    arr2=as.numeric(unlist(strsplit(input$arr3, split=",")))
    output$text3 <- renderText({qs(arr2,text1=text1)[[2]]})
  })
  
  
})
