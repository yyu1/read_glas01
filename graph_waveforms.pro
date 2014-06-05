openr, 1, '/Users/yifan/work/projects/global_carbon/russia/guoqing/SB_g01.txt'

height = intarr(544)
thresh = intarr(544)
lead10plot = intarr(2)
trail10plot = intarr(2)
leadplot = intarr(2)
trailplot = intarr(2)
for i=0, 543 do height[i] = float(543-i) * 0.15


for i=1, 202 do begin

	read_record, 1, i_rec_ndx, i_shot, i_bgmean, i_bgsdev, i_rng_wf
	thresh[*] = (i_bgmean + 4.5*i_bgsdev)/ 100.


	rec_string = strtrim(string(i_rec_ndx),2) + '_' + strtrim(string(fix(i_shot), format='(i02)'),2)
	cgPS_Open, './figures/' + rec_string + '.ps'

	calc_glas, i_rng_wf, i_bgmean, i_bgsdev, extend, leadbin, trailbin, lead10bin, trail10bin

	lead10plot[*] = float(543-lead10bin) * 0.15
	trail10plot[*] = float(543-trail10bin) * 0.15
	leadplot[*] = float(543-leadbin) * 0.15
	trailplot[*] = float(543-trailbin) * 0.15

  cgPlot, i_rng_wf, height, $
    Color='red', $
    Title=rec_string, $
    XTitle='Return Power Count', $
    YTitle='Height (m)', $
    Position=[0.125, 0.125, 0.9, 0.925]

	cgPlot, thresh, height, $
		Color = 'blue', $
    Position=[0.125, 0.125, 0.9, 0.925], $
		/Overplot

	cgPlot, [0,max(i_rng_wf)], lead10plot, $
		Color = 'yellow', $
    Position=[0.125, 0.125, 0.9, 0.925], $
		/Overplot
		
	cgPlot, [0,max(i_rng_wf)], trail10plot, $
		Color = 'yellow', $
    Position=[0.125, 0.125, 0.9, 0.925], $
		/Overplot

	cgPlot, [0,max(i_rng_wf)], leadplot, $
		Color = 'blue', $
    Position=[0.125, 0.125, 0.9, 0.925], $
		/Overplot

	cgPlot, [0,max(i_rng_wf)], trailplot, $
		Color = 'blue', $
    Position=[0.125, 0.125, 0.9, 0.925], $
		/Overplot

	cgPS_Close, /png, /delete_ps, width=1000
endfor	

end
