#import data and insert into object
#note: when browsing for file, start with ./ and use tab

iris <- read_csv("./data/iris.csv", comment = "#", 
         col_types = cols(
           Sepal.Length = col_double(),
           Sepal.Width = col_double(),
           Petal.Length = col_double(),
           Petal.Width = col_double(),
           Species = col_factor(c("setosa", "versicolor", "virginica"))
         ))

dplyr::glimpse(iris)
View(iris)

#Bat dataset
batdata <- read_csv("./data/bat_dat.csv")
View(batdata)

#Filter data
#Get the sites from Season 1, and where there were more than 100 recordings of Chgouldii
dplyr::filter(.data = batdata, Season == 1)
dplyr::filter(.data = batdata, Season == 1, Chgouldii > 100)
# give a variable as an argument, that var will determine uniqueness
distinct(batdata, Site)
#Subsetting Variables (Columns)
#Get only the following columns with dplyr::select(): Site, Habitat, Season, Chgouldii
dplyr::select(batdata, Site, Habitat, Season, Chgouldii)
#filter by distances
select(batdata, starts_with("dist")) # not case sensitive unless we tell R so

#Alter existing or create new variables with mutate()
#compute the sum of the counts for Taustralis and Vdarlingtoni species
dplyr::mutate(batdata, Taust_Vdarl = Taustralis + Vdarlingtoni)
#To alter an existing variable we use the name of that variable in the name-value pair 
#argument to mutate(), and then provide some computation to that variable on the right.
#e.g. Imagine there was an error at some point during data collation and a decimal place 
#was shifted, let's pretend it was for the variable House500.
mutate(batdata, House500 = House500 / 10)

#summarising data. This also changes the structure of your data frame.
summarise(batdata, mean_Chgouldii = mean(Chgouldii))

#renaming variables
rename(batdata, Cg = Chgouldii, Cm = Chmorio)

#====================================================================================

# select entries and compute mean and se
# note: source se function - open se function script and select "source on save"

# Apply the function to the Chgouldii column
batdata %>%
  select(1:4, Bioregion) %>%
  group_by(Bioregion, Season) %>%
  summarise(mean_Cg = mean(Chgouldii),
            se_Cg = se(Chgouldii))
