openr, 1, '/Users/yifan/work/projects/global_carbon/russia/guoqing/SB_g01.txt'

openw, 2, '~/work/projects/global_carbon/russia/guoqing/sb_g01_stats.csv'

printf, 2, 'i_rec_ndx,i_shot,extend,lead10,trail10'

height = intarr(544)
thresh = intarr(544)
for i=0, 543 do height[i] = 543-i


for i=1, 202 do begin

	read_record, 1, i_rec_ndx, i_shot, i_bgmean, i_bgsdev, i_rng_wf
	thresh[*] = (i_bgmean + 4*i_bgsdev)/ 100.


	rec_string = strtrim(string(i_rec_ndx),2) + '_' + strtrim(string(i_shot),2)
	cgPS_Open, rec_string + '.ps'

	calc_glas, i_rng_wf, i_bgmean, i_bgsdev, extend, leadbin, trailbin, lead10bin, trail10bin

	lead10 = float(lead10bin-leadbin)*0.15
	trail10 = float(trailbin-trail10bin)*0.15

	outstring = strtrim(string(i_rec_ndx),2) + ',' + $
		strtrim(string(fix(i_shot)),2) + ',' + $
		strtrim(string(extend),2) + ',' + $
		strtrim(string(lead10),2) + ',' + $
		strtrim(string(trail10),2)

	printf, 2, outstring

  ;cgPlot, i_rng_wf, height, $
  ;  Color='red', $
  ;  Title=rec_string, $
  ;  XTitle='Return Power', $
  ;  YTitle='Height Bin', $
  ;  Position=[0.125, 0.125, 0.9, 0.925]

	;cgPlot, thresh, height, $
	;	Color = 'blue', $
  ;  Position=[0.125, 0.125, 0.9, 0.925], $
	;	/Overplot

	;cgPS_Close, /png, /delete_ps, width=1000
endfor	

end
