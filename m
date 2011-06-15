From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Wed, 15 Jun 2011 16:21:44 +0100
Message-ID: <20110615152144.GE28989@n2100.arm.linux.org.uk>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
	<4DF83577.6040903@zytor.com>
	<20110615074749.GB28989@n2100.arm.linux.org.uk>
	<4DF8CAD5.1090902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4DF8CAD5.1090902@zytor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 15, 2011 at 08:08:05AM -0700, H. Peter Anvin wrote:
> On 06/15/2011 12:47 AM, Russell King - ARM Linux wrote:
> >>
> >> OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
> >> are ubiquitous across just about every platform.
> >>
> >> Floppy is special (in the short bus sense), since it is closely tied to
> >> ISA DMA.  Conditionalizing this on ISA DMA makes total sense.
> > 
> > No it doesn't.  It depends on the ISA DMA API, not that the machine has
> > ISA DMA.
> > 
> > I have a platform which has no ISA DMA but uses the floppy driver.  Please
> > don't break it.
> 
> OK, even more case in point, then.

It's already been solved - ARCH_MAY_HAVE_PC_FDC is supposed to be
defined to y in the cases where architectures have support for it.

What we do on ARM for example is:

config ARCH_MAY_HAVE_PC_FDC
        bool

and then select that symbol for our platforms which can have the
floppy driver.

And in any case we already have definitions for the presence of the
ISA DMA API vs the common ISA DMA helpers in kernel/.  The presence
of the ISA DMA API is given by CONFIG_ISA_DMA_API, while the
ISA DMA helper CONFIG_GENERIC_ISA_DMA.
