import re, matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib import font_manager as fm
from matplotlib.patches import Polygon
fp='/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc'
fm.fontManager.addfont(fp); plt.rcParams['font.family']=fm.FontProperties(fname=fp).get_name()
plt.rcParams.update({'font.size':6.5,'axes.unicode_minus':False})
INK='#1f2933'; BLUE='#1f5f99'; GREY='#8b95a1'; LIGHT='#e8edf2'
W=8.4/2.54
R='repo/fpga'

def vcd(path):
    ids={}; sig={}; t=0; scope=[]
    for line in open(path):
        s=line.strip()
        if s.startswith('$scope'): scope.append(s.split()[2]); continue
        if s.startswith('$upscope'): scope.pop(); continue
        m=re.match(r'\$var \w+ (\d+) (\S+) (\S+)',s)
        if m:
            name='.'.join(scope+[m.group(3)]); ids.setdefault(m.group(2),[]).append(name); sig[name]=[]; continue
        if s.startswith('#'): t=int(s[1:])//1000; continue   # ps -> ns
        m=re.match(r'b([01xz]+) (\S+)$',s)
        if m and m.group(2) in ids:
            v=m.group(1); v=int(v,2) if set(v)<=set('01') else None
            for n in ids[m.group(2)]: sig[n].append((t,v)); continue
        m=re.match(r'([01xz])(\S+)$',s)
        if m and m.group(2) in ids:
            v=int(m.group(1)) if m.group(1) in '01' else None
            for n in ids[m.group(2)]: sig[n].append((t,v))
    return sig
def at(ev,t):
    v=None
    for tt,x in ev:
        if tt<=t: v=x
        else: break
    return v
def runs(ev,t0,t1):
    out=[]; v=at(ev,t0); a=t0
    for tt,x in ev:
        if t0<tt<t1 and x!=v: out.append((a,tt,v)); a=tt; v=x
    out.append((a,t1,v)); return out

def wave(sig,rows,t0,t1,fname,fmt=None,marks=()):
    fmt=fmt or {}
    fig,ax=plt.subplots(figsize=(W,0.36*len(rows)+0.5),dpi=300)
    n=len(rows)
    for i,(label,key,kind) in enumerate(rows):
        y=n-1-i; ev=sig[key]
        if kind=='bit':
            xs=[];ys=[]
            for a,b,v in runs(ev,t0,t1):
                v=v or 0; xs+= [a,b]; ys+=[y-0.22+0.44*v]*2
            ax.plot(xs,ys,color=BLUE,lw=0.9)
        else:
            span=t1-t0; d=span*0.006
            for a,b,v in runs(ev,t0,t1):
                h=0.26
                ax.add_patch(Polygon([(a,y),(a+d,y+h),(b-d,y+h),(b,y),(b-d,y-h),(a+d,y-h)],closed=True,fc=LIGHT,ec=BLUE,lw=0.6))
                txt='?' if v is None else (fmt.get(key,'{}').format(v))
                if (b-a)>span*0.045: ax.text((a+b)/2,y,txt,ha='center',va='center',color=INK,fontsize=5.6)
        ax.text(t0-(t1-t0)*0.015,y,label,ha='right',va='center',color=INK,fontsize=6.3)
    for x,txt in marks:
        ax.axvline(x,color=GREY,lw=0.5,ls=(0,(2,2)))
        if txt: ax.text(x,n-0.45,txt,ha='center',va='bottom',fontsize=5.6,color=GREY)
    ax.set_xlim(t0,t1); ax.set_ylim(-0.6,n-0.2+ (0.35 if marks else 0)); ax.set_yticks([])
    for s in ('top','right','left'): ax.spines[s].set_visible(False)
    ax.spines['bottom'].set_color('#8a96a3'); ax.tick_params(axis='x',length=2,colors='#5f6b7a',labelsize=5.8)
    ax.set_xlabel('시뮬레이션 시간 (ns)',fontsize=6,color='#5f6b7a')
    fig.tight_layout(pad=0.3); fig.savefig('fig/'+fname); plt.close(fig)

def bits(s,key,v):
    return [t for t,x in s[key] if x==v]
# uart_cmd: 7바이트 전체
s=vcd(f'{R}/uart_cmd/evidence/pre/wave.vcd')
vt=[t for t,x in s['tb.dut.rx_valid'] if x==1]
lab=['1','1','2','2','x','0','0x01']
wave(s,[('uart_rxd','tb.uart_rxd','bit'),('uart_txd','tb.uart_txd','bit'),('rx_data','tb.dut.rx_data','bus'),('cmd_led','tb.cmd_led','bit')],
     0,max(t for t,_ in s['tb.uart_txd'])+300,'uart_cmd_wave.png',fmt={'tb.dut.rx_data':'{:02X}'},marks=[(t,l) for t,l in zip(vt,lab)])
print('uart',vt)
# servo: 리셋 후 1.5 ms 프레임부터 2 ms 프레임까지 전체
s=vcd(f'{R}/servo/evidence/pre/wave.vcd')
t0=bits(s,'tb.rst',0)[0]
wave(s,[('pulse_us','tb.us','bus'),('servo','tb.servo','bit')],t0-500,max(t for t,_ in s['tb.servo'])+21000,'servo_wave.png',fmt={'tb.us':'{}'})
print('servo',t0)
# sram: 마지막 쓰기 두 번(주소 E, F)과 첫 읽기 두 번(주소 0, 1)
s=vcd(f'{R}/sram/evidence/pre/wave.vcd')
wave(s,[('wr','tb.wr','bit'),('rd','tb.rd','bit'),('address','tb.address','bus'),('bus','tb.bus','bus'),('we_n','tb.we_n','bit'),('oe_n','tb.oe_n','bit'),('led','tb.led','bus')],
     84,116,'sram_wave.png',fmt={'tb.bus':'{:X}','tb.led':'{:X}','tb.address':'{:X}'})
# dac: 255 -> 0 전환 부근
s=vcd(f'{R}/dac/evidence/pre/wave.vcd')
ff=[t for t,x in s['tb.data'] if x==255][0]
wave(s,[('we_n','tb.we_n','bit'),('data','tb.data','bus'),('a_b','tb.a_b','bit'),('led','tb.led','bus')],ff-90,ff+130,'dac_wave.png',fmt={'tb.data':'{}','tb.led':'{}'})
print('dac',ff)
