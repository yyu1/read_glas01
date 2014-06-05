;Calculate extend, lead10, and trail10 as defined by Lefsky

PRO calc_glas, i_rng_wf, i_bgmean, i_bgsdev, extend, leadbin, trailbin, lead10bin, trail10bin

	thresh = (i_bgmean + 4*i_bgsdev) / 100.

	past_thresh = 0

	index = where(i_rng_wf ge thresh, count)

	extend = 0.
	lead10bin = -1
	trail10bin = -1
	leadbin = -1
	trailbin = -1

	if (count gt 0) then begin

		leadbin = index[0]
		trailbin = index[count-1]

		valid_energy_wf = i_rng_wf[index]
		
		extend = float(count) * 0.15 ; 15 cm per vertical bin

		pct10 = cgPercentiles(valid_energy_wf, Percentiles=0.10)

		print, '10 percentile', pct10


		;find lead10
		for tmp_index = 0, count-1 do begin
			if valid_energy_wf[tmp_index] gt pct10 then begin
				lead10bin = index[tmp_index]
				break
			endif
		endfor

		;find trail10
		for tmp_index = count-1, 0, -1 do begin
			if valid_energy_wf[tmp_index] gt pct10 then begin
				trail10bin = index[tmp_index]
				break
			endif
		endfor

	endif

END
