drop table if exists soil_temp, sun_test, soil_test, test_point, field, buyer, supplier, mgmt, employee, emp_title, landowner, contact, site, location, address;

CREATE TABLE address (
  add_ID INT(9) NOT NULL AUTO_INCREMENT,
  st_adr CHAR(50),
  city CHAR(50) NOT NULL,
  state CHAR(50),
  zip INT(5),
  country CHAR(50),
  PRIMARY KEY (add_ID)) ENGINE=INNODB;
  
CREATE TABLE location (
loc_ID INT(9) NOT NULL AUTO_INCREMENT,
gps_lat NUMERIC(9,6) NOT NULL,
gps_lon CHAR(10) NOT NULL,
PRIMARY KEY (loc_ID)) ENGINE=INNODB;

CREATE TABLE site (
sit_ID INT(9) NOT NULL AUTO_INCREMENT,
add_ID INT(9) NOT NULL,
PRIMARY KEY (sit_ID),
FOREIGN KEY (add_ID) REFERENCES address (add_ID)) ENGINE=INNODB;

CREATE TABLE contact (
con_ID INT(9) NOT NULL AUTO_INCREMENT,
f_name CHAR(30) NOT NULL,
l_name CHAR(30) NOT NULL,
phone CHAR(20),
add_ID INT(9),
email CHAR(60),
PRIMARY KEY (con_ID),
FOREIGN KEY (add_ID) REFERENCES address (add_ID)) ENGINE=INNODB;

CREATE TABLE landowner (
  lan_ID INT(9) NOT NULL AUTO_INCREMENT,
  lan_name CHAR(50) NOT NULL,
  con_ID INT(9) NOT NULL,
  PRIMARY KEY (lan_ID),
  FOREIGN KEY (con_ID) REFERENCES contact (con_ID)) ENGINE=INNODB;
  
CREATE TABLE emp_title (
tit_ID INT(9) NOT NULL AUTO_INCREMENT,
title CHAR(50) NOT NULL,
hr_rt NUMERIC(5,2) NOT NULL,
com_rt DECIMAL(4,3) NOT NULL,
PRIMARY KEY (tit_ID)) ENGINE=INNODB;

CREATE TABLE employee (
  emp_ID INT(9) NOT NULL AUTO_INCREMENT,
  con_ID INT(9) NOT NULL,
  tit_ID INT(9) NOT NULL,
  ss_num INT(9),
  PRIMARY KEY (emp_ID),
  FOREIGN KEY (con_ID) REFERENCES contact (con_ID),
  FOREIGN KEY (tit_ID) REFERENCES emp_title (tit_ID)) ENGINE=INNODB;
  
CREATE TABLE mgmt (
mgt_ID INT(9) NOT NULL AUTO_INCREMENT,
mng_ID INT(9) NOT NULL,
emp_ID INT(9) NOT NULL,
PRIMARY KEY (mgt_ID),
FOREIGN KEY (mng_ID) REFERENCES employee (emp_ID),
FOREIGN KEY (mng_ID) REFERENCES employee (emp_ID)) ENGINE=INNODB;
  
CREATE TABLE supplier (
sup_ID INT(9) NOT NULL AUTO_INCREMENT,
sup_name CHAR(30) NOT NULL,
con_ID INT(9),
web CHAR(50),
dsc_rt DECIMAL(4,3) NOT NULL,
PRIMARY KEY (sup_ID),
FOREIGN KEY (con_ID) REFERENCES contact (con_ID)) ENGINE=INNODB;

CREATE TABLE buyer (
buy_ID INT(9) NOT NULL AUTO_INCREMENT,
buy_name CHAR(30),
con_ID INT(9) NOT NULL,
dsc_rt DECIMAL(4,3) NOT NULL,
PRIMARY KEY (buy_ID)) ENGINE=INNODB;


CREATE TABLE field (
  fld_ID CHAR(11) NOT NULL,
  sit_ID INT(9) NOT NULL,
  fld_name CHAR(30) NOT NULL,
  fld_stat CHAR(30),
  lan_ID INT(9) NOT NULL,
  acreage NUMERIC(10,4) NOT NULL,
  PRIMARY KEY (fld_ID),
  FOREIGN KEY (sit_ID) REFERENCES site (sit_ID),
  FOREIGN KEY (lan_ID) REFERENCES landowner (lan_ID)) ENGINE=INNODB;

CREATE TABLE test_point (
  tp_ID CHAR(11) NOT NULL,
  fld_ID CHAR(11) NOT NULL,
  loc_ID INT(9) NOT NULL,
  plus_sea INT(6) NOT NULL,
  PRIMARY KEY (tp_ID),
  FOREIGN KEY (fld_ID) REFERENCES field (fld_ID),
  FOREIGN KEY (loc_ID) REFERENCES location (loc_ID),
  FOREIGN KEY (fld_ID) REFERENCES field (fld_ID)) ENGINE=INNODB;

CREATE TABLE soil_test (
  st_ID INT(15) NOT NULL AUTO_INCREMENT,
  tp_ID CHAR(11) NOT NULL,
  st_date DATE NOT NULL,
  HMper NUMERIC(3,2) NOT NULL,
  WV NUMERIC(4,2) NOT NULL,
  CEC NUMERIC(4,1) NOT NULL,
  BSper INT(3),
  Ac NUMERIC(3,1),
  pH NUMERIC(3,1) NOT NULL,
  PI INT(3) NOT NULL,
  KI INT(3) NOT NULL,
  Caper INT(3), 
  Mgper INT(3), 
  SI INT(3) NOT NULL,  
  MnI INT(3) NOT NULL,
  MnAl1 INT(3),
  MnAl2 INT(3), 
  ZnI INT(3) NOT NULL,
  ZnAl INT(3),
  CuI INT(3) NOT NULL,
  Na NUMERIC(3,1),
  ESP INT(2),
  SSI INT(3), 
  NO3N INT(3), 
  PRIMARY KEY (st_ID),
  FOREIGN KEY (tp_ID) REFERENCES test_point (tp_ID)) ENGINE=INNODB;
  
  
  
CREATE TABLE sun_test (
sun_ID int(15) NOT NULL AUTO_INCREMENT,
tp_ID CHAR(11) NOT NULL,
sun_date DATE NOT NULL,
sun_time TIME NOT NULL,
lux numeric(5,0) NOT NULL,
cond VARCHAR(20) NOT NULL,
PRIMARY KEY (sun_ID),
FOREIGN KEY (tp_ID) REFERENCES test_point(tp_ID)) ENGINE=INNODB;

CREATE TABLE soil_temp (
tm_ID INT(9) NOT NULL AUTO_INCREMENT,
tp_ID CHAR(11) NOT NULL,
tm_date DATE NOT NULL,
tm_time TIME NOT NULL,
temp INT(3) NOT NULL,
PRIMARY KEY (tm_ID),
FOREIGN KEY (tp_ID) REFERENCES test_point (tp_ID)) ENGINE=INNODB;


# finished to this line ########################################################################################################################################

CREATE TABLE moist_test (

CREATE TABLE plant (
plt_ID INT(15) NOT NULL AUTO_INCREMENT,
plant_name CHAR(50) NOT NULL,
variety CHAR(50),
PRIMARY KEY (plt_ID)) ENGINE=INNODB;


CREATE TABLE plant_batch (
bch_ID INT(15) NOT NULL AUTO_INCREMENT,
plt_ID INT(15) NOT NULL,
plant_state CHAR(30) NOT NULL,
sup_ID INT(9) NOT NULL,
purchase_date DATE NOT NULL,
item_no INT(15),
qty INT(6) NOT NULL,
unit CHAR(20) NOT NULL,
cost NUMERIC(10,2) NOT NULL,
emp_ID INT(9) NOT NULL,
PRIMARY KEY (bch_ID),
FOREIGN KEY (sup_ID) REFERENCES supplier(sup_ID),
FOREIGN KEY (plt_ID) REFERENCES plant(plt_ID),
FOREIGN KEY (emp_ID) REFERENCES employee(emp_ID)) ENGINE=INNODB;

CREATE TABLE planting (
ptg_ID INT(9) NOT NULL AUTO_INCREMENT,
bch_ID INT(15) NOT NULL,
emp_ID INT (9) NOT NULL,
plDate DATE NOT NULL,
hours TIME NOT NULL,
PRIMARY KEY (ptg_ID),
FOREIGN KEY (bch_ID) REFERENCES plant_batch(bch_ID),
FOREIGN KEY (emp_ID) REFERENCES employee (emp_ID)) ENGINE=INNODB;


CREATE TABLE planted_crop (
crp_ID INT(15) NOT NULL AUTO_INCREMENT,
plt_ID INT(15) NOT NULL,
crop_status CHAR(20) NOT NULL,
fld_ID INT(12) NOT NULL,
field_row CHAR(20) NOT NULL,
loc_in_row CHAR(20) NOT NULL,
PRIMARY KEY (crp_ID),
FOREIGN KEY (plt_ID) REFERENCES plant(plt_ID),
FOREIGN KEY (fld_ID) REFERENCES field(fld_ID)) ENGINE=INNODB;


 




