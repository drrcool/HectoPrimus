function read_usno, file

  readcol, file, rh, rm, rs, decd, decm, decs, bmag, rmag, format='A,A,A,A,A,A,F,F'
  
  
  ra = hms2dec(rh+':'+rm+':'+rs)
  dec = hms2dec(decd + ':' + decm + ':' + decs)

  output = {ra : 0.0d, dec:0.0d, mag:0}
  output = replicate(output, n_elements(ra))
  output.ra = ra
  output.dec = dec
  output.mag = rmag

  return, output
END


