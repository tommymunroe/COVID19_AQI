clear all

cd "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA"

*Open Utah PM2.5 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/slc air pollution/SLC_PM25.csv", clear


*Data Cleaning
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if siteid==490351007
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile SLCPM25
save `SLCPM25'


*Prep Utah NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/slc air pollution/SLC_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid


tempfile SLCNO2
save `SLCNO2'


*Merge PM2.5 and NO2
use `SLCPM25', clear
merge m:m date1 siteid using `SLCNO2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile SLCNO2PM25
save `SLCNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/slc air pollution/SLC_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile OZONE
save `OZONE'


*Merge SLCNO2PM25 & OZONE
use `OZONE', clear
merge m:m date1 siteid using `SLCNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalslc
save`totalslc'



*Prep Boise Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/boise air pollution/Boise_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile boisepm25
save `boisepm25'


*Prep Boise NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/boise air pollution/Boise_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile boiseno2
save `boiseno2'


*Merge Boise PM25 and NO2
use `boisepm25', clear
merge m:m date1 siteid using `boiseno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile boiseNO2PM25
save `boiseNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/boise air pollution/Boise_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile boiseozone
save `boiseozone'

*Merge boiseNO2PM25 & boiseozone
use `boiseozone', clear
merge m:m date1 siteid using `boiseNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalboise
save `totalboise'


*Merge Boise and SLC
use `totalboise', clear
merge m:m date cbsa_code using `totalslc'
drop _m
move cbsa_name siteid

tempfile slcboi
save `slcboi'

*Prep Denver Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/denver air pollution/Denver_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile denverpm25
save `denverpm25'


*Prep Denver NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/denver air pollution/Denver_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile denverno2
save `denverno2'


*Merge Denver PM25 and NO2
use `denverpm25', clear
merge m:m date1 siteid using `denverno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile denverNO2PM25
save `denverNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/denver air pollution/Denver_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile denverozone
save `denverozone'

*Merge denverNO2PM25 & denverozone
use `denverozone', clear
merge m:m date1 siteid using `denverNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totaldenver
save `totaldenver'

*Merge slcboi and totaldenver
use `totaldenver', clear
merge m:m date cbsa_code using `slcboi'
drop _m

tempfile slcboid
save `slcboid'


*Prep Seattle Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/seattle air pollution/SEA_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile seapm25
save `seapm25'


*Prep Seatlle NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/seattle air pollution/SEA_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile seano2
save `seano2'


*Merge Seattle PM25 and NO2
use `seapm25', clear
merge m:m date1 siteid using `seano2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile seaNO2PM25
save `seaNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/seattle air pollution/SEA_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile seaozone
save `seaozone'

*Merge seaNO2PM25 & seaozone
use `seaozone', clear
merge m:m date1 siteid using `seaNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalseattle
save `totalseattle'

*Merge slcboid and totalseattle
use `totalseattle', clear
merge m:m date cbsa_code using `slcboid'
drop _m

tempfile seaslcboid
save `seaslcboid'

*Prep Dallas Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/dallas air pollution/Dallas_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile dallaspm25
save `dallaspm25'


*Prep Dallas NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/dallas air pollution/Dallas_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile dallasno2
save `dallasno2'


*Merge Dallas PM25 and NO2
use `dallaspm25', clear
merge m:m date1 siteid using `dallasno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile dallasNO2PM25
save `dallasNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/dallas air pollution/Dallas_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile dallasozone
save `dallasozone'

*Merge dallasNO2PM25 & dallasozone
use `dallasozone', clear
merge m:m date1 siteid using `dallasNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totaldallas
save `totaldallas'

*Merge totaldallas and seaslcboid
use `totaldallas', clear
merge m:m date cbsa_code using `seaslcboid'
drop _m

tempfile fivecities
save `fivecities'

*Prep San Fran Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/sf air pollution/SF_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sfpm25
save `sfpm25'


*Prep San Fran NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/sf air pollution/SF_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sfno2
save `sfno2'


*Merge San Fran PM25 and NO2
use `sfpm25', clear
merge m:m date1 siteid using `sfno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile sfNO2PM25
save `sfNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/sf air pollution/SF_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sfozone
save `sfozone'

*Merge sfNO2PM25 & sfozone
use `sfozone', clear
merge m:m date1 siteid using `sfNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalsf
save `totalsf'


*Merge totalsf and fivecities
use `totalsf', clear
merge m:m date cbsa_code using `fivecities'
drop _m

tempfile sixcities
save `sixcities'

*Prep San Diego Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/san diego air pollution/SD_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sdpm25
save `sdpm25'


*Prep San Diego NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/san diego air pollution/SD_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sdno2
save `sdno2'


*Merge San Diego PM25 and NO2
use `sdpm25', clear
merge m:m date1 siteid using `sdno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile sdNO2PM25
save `sdNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/san diego air pollution/SD_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile sdozone
save `sdozone'

*Merge sdNO2PM25 & sdozone
use `sdozone', clear
merge m:m date1 siteid using `sdNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalsd
save `totalsd'


*Merge totalsd and sixcities
use `totalsd', clear
merge m:m date cbsa_code using `sixcities'
drop _m

tempfile sevencities
save `sevencities'


*Prep Las Vegas Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/las vegas air pollution/LV_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile lvpm25
save `lvpm25'


*Prep Las Vegas NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/las vegas air pollution/LV_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile lvno2
save `lvno2'


*Merge Las Vegas PM25 and NO2
use `lvpm25', clear
merge m:m date1 siteid using `lvno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile lvNO2PM25
save `lvNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/las vegas air pollution/LV_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile lvozone
save `lvozone'

*Merge lvNO2PM25 & lvozone
use `lvozone', clear
merge m:m date1 siteid using `lvNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totallv
save `totallv'

*Merge totallv and sevencities
use `totallv', clear
merge m:m date cbsa_code using `sevencities'
drop _m

tempfile eightcities
save `eightcities'

*Prep Portland Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/portland air pollution/Port_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile portpm25
save `portpm25'


*Prep Portland NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/portland air pollution/Port_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile portno2
save `portno2'


*Merge Portland PM25 and NO2
use `portpm25', clear
merge m:m date1 siteid using `portno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile portNO2PM25
save `portNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/portland air pollution/Port_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile portozone
save `portozone'

*Merge portNO2PM25 & portozone
use `portozone', clear
merge m:m date1 siteid using `portNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalport
save `totalport'

*Merge totallv and eightcities
use `totalport', clear
merge m:m date cbsa_code using `eightcities'
drop _m

tempfile ninecities
save `ninecities'


*Prep Alb Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/alb air pollution/ALB_PM25.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile albpm25
save `albpm25'


*Prep Alb NO2 Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/alb air pollution/ALB_NO2.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile albno2
save `albno2'


*Merge Alb PM25 and NO2
use `albpm25', clear
merge m:m date1 siteid using `albno2'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymeanpm25concentration

tempfile albNO2PM25
save `albNO2PM25'


*Prep Ozone Data
import delimited "/Users/scoobertdoobert/Desktop/school/ECONOMETRICS/RESEARCH PROJECT/AIR POLLUTION DATA/alb air pollution/ALB_Ozone.csv", clear
drop site_latitude site_longitude state_code daily_obs_count
drop source aqs_parameter_code aqs_parameter_desc sitename percent_complete
drop if cbsa_code == .
gen date1=date(date,"MDY")
format date1 %td
move date1 siteid

tempfile albozone
save `albozone'

*Merge albNO2PM25 & albozone
use `albozone', clear
merge m:m date1 siteid using `albNO2PM25'
drop if _merge!=3
drop _m
move dailymax1hourno2concentration dailymax8hourozoneconcentration
move dailymeanpm25concentration dailymax1hourno2concentration
rename dailymeanpm25concentration pm25
ren dailymax1hourno2concentration no2
ren dailymax8hourozoneconcentration ozone

tempfile totalalb
save `totalalb'

*Merge totalalb and ninecities
use `totalalb', clear
merge m:m date cbsa_code using `ninecities'
drop _m

*Summary stats
sum daily_aqi_value
sum pm25
sum no2
sum ozone

*Create a Date Variable that I Can Work With
drop units
gen date2=date(date, "MDY")
move date2 siteid
move cbsa_name siteid

*Post Variable
gen post = 0
replace post = 1 if date2 >= 21984
label define postLabel 0 "Pre" 1 "Post"
label values post postLabel
drop if date2 >= 22067


*Regression Time!
reg daily_aqi_value post, robust
outreg2 using AQIOutreg, excel replace ctitle(AQI)
reg pm25 post, robust
outreg2 using PM25Outreg, excel replace ctitle(PM25)
reg no2 post, robust
outreg2 using NO2Outreg, excel replace ctitle(NO2)
reg ozone post, robust
outreg2 using Ozone, excel replace ctitle(Ozone)

*Graph Time!
gen aqi_pre = daily_aqi_value
replace aqi_pre= . if date2 >= 21985
gen aqi_post = daily_aqi_value
replace aqi_post= . if date2 < 21985
graph bar (mean) aqi_pre (mean) aqi_post, bar(1, fcolor(olive)) bar(2, fcolor(red)) ytitle(Average AQI Value) title(Average Air Quality Index Value) subtitle(Pre and Post the COVID Pandemic)

gen pm25_pre = pm25
replace pm25_pre= . if date2 >=21985
gen pm25_post = pm25
replace pm25_post= . if date2 < 21985
graph bar (mean) pm25_pre (mean) pm25_post, bar(1, fcolor(olive)) bar(2, fcolor(red)) ytitle(Average PM25 Value) title(Average PM25 Value) subtitle(Pre and Post the COVID Pandemic)

gen no2_pre = no2
replace no2_pre= . if date2 >=21985
gen no2_post = no2
replace no2_post= . if date2 < 21985
graph bar (mean) no2_pre (mean) no2_post, bar(1, fcolor(olive)) bar(2, fcolor(red)) ytitle(Average Nitrogen Dioxide Value) title(Average Nitrogen Dioxide Value) subtitle(Pre and Post the COVID Pandemic)

gen ozone_pre = ozone
replace ozone_pre= . if date2 >=21985
gen ozone_post = ozone
replace ozone_post= . if date2 < 21985
graph bar (mean) ozone_pre (mean) ozone_post, bar(1, fcolor(olive)) bar(2, fcolor(red)) ytitle(Average Ozone Value) title(Average Ozone Value) subtitle(Pre and Post the COVID Pandemic)


