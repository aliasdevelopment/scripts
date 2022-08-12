clear all;

#https://lweb.cfa.harvard.edu/~dfabricant/huchra/hubble/

light_year_meter = 9460730472580800; % meter
light_year_kilometer = light_year_meter / 1000;

parsec = 3.26156; % light-year

mega_parsec_light_year = parsec * 1000000;
mega_parsec_kilometer = mega_parsec_light_year * light_year_kilometer;

hubble_constant_value = 72 % km/s *  1/Mpc

hubble_constant_per_kilometer = hubble_constant_value / mega_parsec_kilometer;
hubble_constant_per_millimeter = hubble_constant_per_kilometer * 1000 * 1000

hour = 3600
day = 24*hour
year = 365*day

hubble_constant_per_millimeter * year * 80