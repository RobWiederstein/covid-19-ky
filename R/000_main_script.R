x <- c(  "./R/010_download_confirmed_case_data.R", 
         "./R/011_download_death_data.R", 
         "./R/012_download_recovered_data.R",
         "./R/020_filter_to_confirmed_us_cases.R", 
         "./R/021_filter_to_deaths_us_cases.R", 
         "./R/022_filter_to_recovered_us_cases.R", 
         "./R/030_combine_tidy_data_sets.R",
         "./R/040_add_variables_for_final_data_frame.R",
         "./R/050_convert_csv_to_json.R",
         "./R/060_build_confirm_case_growth.R"
         
)
run_scripts <- function(x){
        source(x,
               echo = FALSE,
               verbose = FALSE
               )
        rm(list = ls())
}
sapply(x, run_scripts)

