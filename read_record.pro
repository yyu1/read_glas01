;reads one record from given LUN pointing to text file

PRO read_record, in_lun, i_rec_ndx, i_shot, i_bgmean, i_bgsdev, i_rng_wf

	string = ''
	i_rec_ndx = 0UL
	i_shot = 0.
	i_bgmean = 0
	i_bgsdev = 0
	i_rng_wf = uintarr(544)
	readf, in_lun, string, i_rec_ndx, i_shot, format='(A19,I,F)'

	;skip to bgmean and bgsdev lines
	for i=0, 37 do readf, in_lun, string

	readf, in_lun, string, i_bgmean, format='(A19,I)'
	readf, in_lun, string, i_bgsdev, format='(A19,I)'

	;skip to waveform
	for i=0, 1 do readf, in_lun, string
	readf, in_lun, i_rng_wf

	;finish the rest of the record
	for i=0, 1 do readf, in_lun, string

END
