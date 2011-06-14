From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 13:25:46 -0700
Message-ID: <4DF7C3CA.9050902@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Lennox Wu <lennox.wu@gmail.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>Pa
List-Id: linux-arch.vger.kernel.org

On 06/14/2011 12:08 PM, Ralf Baechle wrote:
> The PC parallel port Kconfig as acquired one of those messy terms to
> describe it's architecture dependencies:
> 
>        depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
>                (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> 
> This isn't just ugly - it also almost certainly describes the dependencies
> too coarse grainedly.  This is an attempt at cleaing the mess up.
> 
> I tried to faithfully aproximate the old behaviour but the existing
> behaviour seems inacurate if not wrong for some architectures or platforms.
> To improve on this I rely on comments from other arch and platforms
> maintainers.  Any system that can take PCI multi-IO card or has a PC-style
> parallel port on the mainboard should probably should now do a
> select HAVE_PC_PARPORT.  And some arch Kconfig files should further
> restrict the use of HAVE_PC_PARPORT to only those platforms that actually
> need it.
> 

Why on earth restrict it like that?  It's just a device driver, like
more or less any other device driver...

	-hpa
