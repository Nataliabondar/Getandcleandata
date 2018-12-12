runAnalysis <- function() {
  ##read Features and ActivityLabels vector
  features <- read.delim("features.txt", sep = " ", header = FALSE)
  activities <- read.delim("activity_labels.txt", sep = " ", header = FALSE)
  
  ##read test and training sets
  test_set <- read.delim("test/X_test.txt", sep = " ", header = FALSE)
  train_set <- read.delim("train/X_train.txt", sep = " ", header = FALSE)
  merged_set <- bind_rows(test_set,train_set)        
  
  ##Reading activity labels for test and training sets
  testlabels <- read.delim("test/Y_test.txt", sep = " ", header = FALSE)
  trainlabels <- read.delim("train/Y_train.txt", sep = " ", header = FALSE)
  mergedlabels <- bind_rows(testlabels, trainlabels)
  
  ##Reading subject ids
  testsubject <- read.delim("test/subject_test.txt", sep = " ", header = FALSE)
  trainsubject <- read.delim("train/subject_train.txt", sep = " ", header = FALSE)
  mergedsubject <- bind_rows(testsubject, trainsubject)
  
  ##Select columns which includes measurements on the mean and standard deviation 
  names(merged_set) <- features[ ,2]
  merged_set <- merged_set[grep("[Mm]ean|std", merged_set), ] 
  
  #Define descriptive names to variables
  mergedlabels <- merge(mergedlabels, activities, by.x = "V1", by.y = "V1")
  merged_set <- bind_cols(mergedsubject, mergedlabels, merged_set)
  names(merged_set)[1:2] <- c("SubjectID", "Activities")
  
  
  print(merged_set)
  
}
