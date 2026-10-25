# 과제6·7 연결 그림 (PC -> MCU -> FPGA -> PC)
import matplotlib; matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib import font_manager as fm
from matplotlib.patches import FancyBboxPatch
fp='/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc'; fm.fontManager.addfont(fp)
plt.rcParams.update({'font.family':fm.FontProperties(fname=fp).get_name(),'font.size':6.3})
INK='#1f2933'; BLUE='#1f5f99'; GREY='#5f6b7a'; LIGHT='#e8edf2'
fig,ax=plt.subplots(figsize=(8.4/2.54,2.15),dpi=300); ax.set_xlim(0,100); ax.set_ylim(0,58); ax.axis('off')
def box(x,y,w,h,t,sub=''):
    ax.add_patch(FancyBboxPatch((x,y),w,h,boxstyle='round,pad=0.4,rounding_size=1.5',fc=LIGHT,ec=BLUE,lw=0.8))
    ax.text(x+w/2,y+h/2+(2.2 if sub else 0),t,ha='center',va='center',color=INK,fontsize=7,weight='bold')
    if sub: ax.text(x+w/2,y+h/2-3.4,sub,ha='center',va='center',color=GREY,fontsize=5.6)
def arrow(x0,y0,x1,y1,t,dy=2.2,ha='center'):
    ax.annotate('',(x1,y1),(x0,y0),arrowprops=dict(arrowstyle='-|>',color=BLUE,lw=0.8,shrinkA=0,shrinkB=0))
    ax.text((x0+x1)/2,(y0+y1)/2+dy,t,ha=ha,va='bottom',color=INK,fontsize=5.6)
box(1,36,20,14,'PC','COM A (MCU)')
box(40,36,20,14,'STM32','NUCLEO-G474RE')
box(79,36,20,14,'FPGA','uart_cmd')
box(79,4,20,14,'PC','COM B (FPGA)')
box(40,4,20,14,'LED_D1','L4')
arrow(21.8,43,39.2,43,'USB · UART2\n9600 8N1',dy=1.5)
arrow(60.8,43,78.2,43,'PC10 TX →\nEX2-5 (G10)',dy=1.5)
arrow(89,35.2,89,18.8,' F6 TX\n → USB',dy=-3,ha='left')
ax.text(88.5,28,'',color=INK)
arrow(80,35.2,60.8,18.8,'cmd_led\n0 끄기 1 켜기 2 반전',dy=-1,ha='right')
ax.text(11,27,'과제5: PC ↔ STM32\n과제6·7: 전체 경로\nGND 공통 연결',ha='center',va='top',color=GREY,fontsize=5.6)
fig.tight_layout(pad=0.2); fig.savefig('fig/link.png')
