fields = ['deep2_02hr', 'deep2_23hr']


for ifield = 0, 1 do begin
   
field = fields[ifield]

targets = field + '.fits'
all = field + '_all.fits'

delvarx, zerod
zerod = mrdfits(targets, 1)


output = 'ra dec rank type'
output = [output, '-- --- ---- ----']


   rank1 = where(zerod.targ_mag lt 20.5)
   rank2 = where(zerod.targ_mag gt 20.5 and zerod.targ_mag lt 21.5)


   usno = read_usno('deep2_usno')
   star = where(usno.mag lt 15 and usno.mag gt 13)
   
   
   for ii = 0, n_elements(star) -1 do begin

      if (ifield eq 0 and usno[star[ii]].ra lt 10) OR $
        (ifield eq 1 and usno[star[ii]].ra gt 10) then begin      

      ra_split = strsplit(dec2hms(usno[star[ii]].ra), /extract)
      dec_split = strsplit(dec2hms(usno[star[ii]].dec), /extract)
      
      output1 = ra_split[0] + ':' + ra_split[1] + ':' + ra_split[2] + ' ' + $
                dec_split[0] + ':' + dec_split[1] + ':' + dec_split[2] + ' ' + $
                ' ' + 'guide'
      
      output = [output, output1]
      
      endif
      
   endfor
   
   
 
for ii = 0, n_elements(rank1) -1 do begin

   ra_split = strsplit(dec2hms(zerod[rank1[ii]].ra/15.), /extract)
   dec_split = strsplit(dec2hms(zerod[rank1[ii]].dec), /extract)
   
   output1 = ra_split[0] + ':' + ra_split[1] + ':' + ra_split[2] + ' ' + $
            dec_split[0] + ':' + dec_split[1] + ':' + dec_split[2] + ' ' + $
            '1' + ' TARGET'
   
   output = [output, output1]

endfor


for ii = 0, n_elements(rank2) -1 do begin

   ra_split = strsplit(dec2hms(zerod[rank2[ii]].ra/15.), /extract)
   dec_split = strsplit(dec2hms(zerod[rank2[ii]].dec), /extract)
   
   output1 = ra_split[0] + ':' + ra_split[1] + ':' + ra_split[2] + ' ' + $
            dec_split[0] + ':' + dec_split[1] + ':' + dec_split[2] + ' ' + $
            '2' + ' TARGET'
   
   output = [output, output1]

endfor

if ifield eq 0 then begin
   ffile = 'DEEP2_02hr_cat.fits.gz'
endif else begin
   ffile = 'DEEP2_23hr_cat.fits.gz'
endelse

fill = mrdfits(ffile, 1)
rank3 = where(fill.magr lt 21.5)
for ii = 0, n_elements(rank3) -1 do begin
   
   ra_split = strsplit(dec2hms(fill[rank3[ii]].ra/15.), /extract)
   dec_split = strsplit(dec2hms(fill[rank3[ii]].dec), /extract)
   
   output1 = ra_split[0] + ':' + ra_split[1] + ':' + ra_split[2] + ' ' + $
            dec_split[0] + ':' + dec_split[1] + ':' + dec_split[2] + ' ' + $
            '3' + ' TARGET'
   
   output = [output, output1]

endfor



openw, 1 , field+'cool.cat'
for ii = 0, n_elements(output) -1 do begin
   printf, 1, output[ii]
endfor
close, 1



endfor






END

