From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 21:30:47 -0700
Message-ID: <4DF83577.6040903@zytor.com>
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106142333.16203.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas
List-Id: linux-arch.vger.kernel.org

On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
>>
>> Why on earth restrict it like that?  It's just a device driver, like
>> more or less any other device driver...
> 
> I'd say any other classic ISA/PC driver, including floppy, gameport or
> serial-8250. One problem with these is that we never fully worked out
> the dependencies for these, which we probably should. CONFIG_ISA
> generally means ISA add-on cards, but that might not be enabled for
> platforms that have a pc-parport but no ISA slots.
> 

OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
are ubiquitous across just about every platform.

Floppy is special (in the short bus sense), since it is closely tied to
ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

Parallel port is an intermediate case... Centronics parallel ports
predate the PC ecosystem by quite a bit, and the particular arrangement
of ports became popular with the PC and spread to other platforms, but
the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
specific.

> On the other hand, you have embedded platforms that currently build support
> for parport-pc but define the inb/outb macros to plain pointer dereferences
> (otherwise you can't build the 8250 driver). Loading parport-pc on those
> machines typically results in derefencing user memory in the best case.
>
> What I'd love to see is a configuration option for "arch has working
> PC-style inb/outb instructions", so we can build a kernel without them but
> still get MMIO based drivers for PCI-less platforms.

Now, isn't that was iowrite/ioread was designed for?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
