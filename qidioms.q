// https://code.kx.com/q/ref/joins/#aj-aj0-asof-join
// as of join:
k) aj:{.Q.ft[{d:x_z;$[&/j:-1<i:(x#z)bin x#y;y,'d i;+.[+.Q.ff[y]d;(!+d;j);:;.+d i j:&j]]}[x,();;0!z]]y};
aj[`sym`time;trade;quote]
// attribution can be use to increase the efficiency of as of join
aj[`hard`soft     ;trade;prevailling quote]
aj[`hard`soft     ;trade;update `g#sym from quote]
aj[`hard`soft     ;trade;update `p#sym from quote]
aj[`hard`soft     ;trade;update `s#sym from quote]
aj[`hard`hard`soft;trade;update `g#sym from quote](attr on quote doesn't help)
aj   trade time
aj0  quote time
group `g#quote quote`sym
\ examples
qty :([]time:til[3]+0. ;sym:`a`b`c  ;current_qty    :1 2 3);
px0 :([]time:til[4]+0. ;sym:`a`b`c`d;most_recent_px :10*til 4);
px1 :([]time:til[4]+0.1;sym:`a`b`c`d;most_recent_px :10*til 4);
px2 :([]time:til[4]-0.1;sym:`a`b`c`d;most_recent_px :10*til 4);
// so basically I guess, aj first fits syms then fits timestamps
// since attribution only works in the first match, so only the attr on `sym helps
aj[`sym`time;qty;px0]
aj[`sym`time;qty;px1]
aj[`sym`time;qty;px2]
aj0[`sym`time;qty;px0]
aj0[`sym`time;qty;px1]
aj0[`sym`time;qty;px2]
// aj	boundary time from t1
// aj0	actual time from t2
type@'raze(+/\)(.z.d;.z.t); /date+time=>time stamp, to aj later
// https://code.kx.com/q/ref/joins/#wj-wj1-window-join
// window join, wj is some thing similar to aj
wj[trade[`time]+/:-000005 000005;`sym`time;trade;(update `g#sym, mid :0.5*bid+ask from quote;(avg;`mid);...;)]
wj[trade[`time]+/:-000005 000005;`sym`time;trade;(update `g#sym, mid :0.5*bid+ask from quote;(wavg;`otherparm; mid))] //wrong, monodyc only
wj[trade[`time]+/:-000005 000005;`sym`time;trade;(update `g#sym, vwab:bid*bsize   from quote;(sum;`vwab);(sum;`bsize))]
wj  : [start;end[
wj1 : [start;end]
wj[start end; ; ;]
// examples
t:([]sym:3#`a;time:2*til 3;price:til 3)
q:([]sym:9#`a;time:til 9;ask:10*til 9;bid:-10*til 9)
f:`sym`time
w:-2 2+\:t.time
wj[w;f;t;(q;(max;`ask);(max;`bid))]
// above are aj,wj examples
