# create a mermaid chart automatically from a dataset (time series sequence and labels)
# install.packages('DiagrammeR')
library(plyr)
library(dplyr)
library(DiagrammeR)


# sample data
df1 = data_frame(id = 1:5, state = c("Initiate", "Process", "Dispatch", "Receive", "Acknowledge"), 
                 time_in_hours = c(5, 2, 10, 3, NA))

df1.1= df1 %>%
  mutate(transition = paste(state, lead(state), sep = "->>")) %>%
  filter(!is.na(time_in_hours)) %>%
  mutate(mmd_row = paste0(transition, ": ", time_in_hours, " hours"))

seq = "sequenceDiagram"
eol = "\n"
mmd_op = paste(seq, paste(df1.1$mmd_row, collapse = eol), sep = eol)

write.table(mmd_op, file = "data/temp1.mmd", quote = FALSE, col.names = FALSE, row.names = FALSE)

DiagrammeR::mermaid("data/temp1.mmd")