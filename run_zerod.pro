
zerod = primus_read_zerod(field='deep2_02hr', rerun=2165, $
                          /uniform_kcorr, kcorr=kcorr, $
                          photo=photo)

filename = '/d2/hecto_primus/deep2_02hr.fits'
mwrfits, zerod, filename, /create
mwrfits, kcorr, filename
mwrfits, photo, filename

zerod = primus_read_zerod(field='deep2_23hr', rerun=2165, $
                          /uniform_kcorr, kcorr=kcorr, $
                          photo=photo)
filename = '/d2/hecto_primus/deep2_23hr.fits'
mwrfits, zerod, filename, /create
mwrfits, kcorr, filename
mwrfits, photo, filename

END
