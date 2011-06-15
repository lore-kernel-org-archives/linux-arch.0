From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Wed, 15 Jun 2011 16:02:53 +0800
Message-ID: <BANLkTikpax09bQqwuP1dJYRtSO+c0DdUgg@mail.gmail.com>
References: <20110614190850.GA13526@linux-mips.org>
        <201106142222.43553.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0016364ecb745fc9a204a5bb94b9
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <201106142222.43553.arnd@arndb.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Mikael
List-Id: linux-arch.vger.kernel.org

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/plain; charset=ISO-8859-1

2011/6/15 Arnd Bergmann <arnd@arndb.de>
>
> >  config SCORE
> > -       def_bool y
> > -       select HAVE_GENERIC_HARDIRQS
> > -       select GENERIC_IRQ_SHOW
> > +     def_bool y
> > +     select HAVE_GENERIC_HARDIRQS
> > +     select HAVE_PC_PARPORT
> > +     select GENERIC_IRQ_SHOW
> >
> >  choice
> >       prompt "System type"
>
> Certainly not, no PIO support
>
>  Yes, there is no platform of the Score supports PIO.
Best,
Lennox

--0016364ecb745fc9a204a5bb94b9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/6/15 Arnd Bergmann <span dir=3D"ltr=
">&lt;<a href=3D"mailto:arnd@arndb.de">arnd@arndb.de</a>&gt;</span><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex;">
<div class=3D"im">
&gt; =A0config SCORE<br>
&gt; - =A0 =A0 =A0 def_bool y<br>
&gt; - =A0 =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; - =A0 =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt; + =A0 =A0 def_bool y<br>
&gt; + =A0 =A0 select HAVE_GENERIC_HARDIRQS<br>
&gt; + =A0 =A0 select HAVE_PC_PARPORT<br>
&gt; + =A0 =A0 select GENERIC_IRQ_SHOW<br>
&gt;<br>
&gt; =A0choice<br>
&gt; =A0 =A0 =A0 prompt &quot;System type&quot;<br>
<br>
</div>Certainly not, no PIO support<br>
<div class=3D"im"><br></div></blockquote><div>=A0Yes, there is no platform =
of the Score supports PIO.</div><div>Best,</div><div>Lennox</div></div>

--0016364ecb745fc9a204a5bb94b9--
