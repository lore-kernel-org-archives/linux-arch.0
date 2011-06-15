From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 21:40:16 -0700
Message-ID: <20110615044016.GC10553@ericsson.com>
References: <20110614190850.GA13526@linux-mips.org>
 <4DF7C3CA.9050902@zytor.com>
 <20110614223404.GA30057@linux-mips.org>
 <4DF8329C.7000904@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <4DF8329C.7000904@zytor.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>, "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Kyle McMartin <kyle@mcmartin.ca>, Lennox Wu <lennox.wu@gmail.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Mikael
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 15, 2011 at 12:18:36AM -0400, H. Peter Anvin wrote:
> On 06/14/2011 03:34 PM, Ralf Baechle wrote:
> > 
> > There is no point in offering to build something that couldn't possibly be
> > used.  It just makes the kernel harder to configure and inflates the test
> > matrix for no good reason.
> > 
> 
> I see... that's why a bunch of devices that only exist on ARM and MIPS
> SoCs are offered on x86 platforms?
> 
http://en.wikipedia.org/wiki/Two_wrongs_make_a_right

Guenter
