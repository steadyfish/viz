# create a mermaid chart automatically from a dataset (time series sequence and labels)
# install.packages('DiagrammeR')
library(plyr)
library(dplyr)
library(DiagrammeR)


# sample data
df1 = data_frame(id = 1:5, state = c("Initiate", "Process", "Dispatch", "Receive", "Acknowledge"), 
                 avg_time = c(5, 2, 10, 3, NA), 
                 med_time = c(6, 3, 9, 2, NA), 
                 min_time = c(1, 0, 0, 1, NA), 
                 max_time = c(10, 4, 15, 5, NA))

df1.1= df1 %>%
  mutate(transition = paste(state, lead(state), sep = "->>")) %>%
  filter(!is.na(avg_time)) %>%
  mutate(mmd_row = paste0(transition, ": {", avg_time, ", ", 
                          med_time, ", ", min_time, ", ", max_time, "} hours"))

seq = "sequenceDiagram"
eol = "\n"
mmd_op = paste(seq, paste(df1.1$mmd_row, collapse = eol), sep = eol)

write.table(mmd_op, file = "data/temp1.mmd", quote = FALSE, col.names = FALSE, row.names = FALSE)

DiagrammeR::mermaid("data/temp1.mmd")
