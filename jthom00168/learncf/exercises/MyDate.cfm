<cfoutput>
    #now()# mask: none<br>
    #DateFormat(now(),"m/dd/yyyy")# mask: m/dd/yyyy<br>
    #DateFormat(now(),"mm/dd/yyyy")# mask: mm/dd/yyyy<br>
    #DateFormat(now(),"m-d-yy")# mask: m-d-yy<br>
    #DateFormat(now(),"mmm-ddd-y")# mask: mmm-ddd-y<br>
    #DateFormat(now(),"short")# mask: short<br>
    #DateFormat(now(),"full")# mask: full<br>
    #DateFormat(now(),"ddddd, mmmm d, yyyy")# mask: ddddd, mmmm d, yyyy<br>
    #DateFormat(now(),"d,D,dd")# mask: d,D,dd<br>
    #DateFormat(now(),"ddd,dddd")# mask: ddd,dddd<br>
    #DateFormat(now(),"m,M,mm,mmm,mmmm")# mask: m,M,mm,mmm,mmmm<br>
    #DateFormat(now(),"Y,YY,yy,gg")# mask: Y,YY,yy,gg<br>
    -------------------------<br>
    #LSDateTimeFormat(now(),"short","Dutch (Standard)")# mask: short, locale: Dutch Standard<br>
    #LSDateTimeFormat(now(),"short","Chinese (Taiwan)")# mask: short, locale: Chinese Taiwan<br>
    #LSDateTimeFormat(now(),"short","German (Swiss)")# mask: short, locale: German Swiss<br>
    #LSDateTimeFormat(now(),"short","th")# mask: short, locale: Thailand, standard? dating<br>
    #LSDateTimeFormat(now(),"short","th_TH")# mask: short, locale: Thailand, local year<br>
    #LSDateTimeFormat(now(),"short","th_TH_TH_##u-nu-thai")# mask: short, locale: Thailand, local script<br>
    of course on this last one I picked a special case.  The upside is that I learned how to escape a "##" just double it!


</cfoutput>
