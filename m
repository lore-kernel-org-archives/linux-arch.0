From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Sat, 05 Mar 2016 01:33:27 +0100
Message-ID: <3185882.WT2d08mtAT@wuerfel>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <5158260.vK2YuWzYIn@wuerfel> <20160305002203.GF55664@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160305002203.GF55664@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-arch@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Friday 04 March 2016 16:22:03 Brian Norris wrote:
> Hi Arnd,
> 
> On Sat, Mar 05, 2016 at 01:19:21AM +0100, Arnd Bergmann wrote:
> > On Friday 04 March 2016 16:02:25 Brian Norris wrote:
> > > On Mon, Jan 25, 2016 at 04:41:50PM +0100, Arnd Bergmann wrote:
> > > > When XIP_KERNEL is enabled, some functions are defined in the .data
> > > > ELF section because we require them to be in RAM whenever we communicate
> > > > with the flash chip. However this causes problems when FTRACE is
> > > > enabled and gcc emits calls to __gnu_mcount_nc in the function
> > > > prolog:
> > > > 
> > > > drivers/built-in.o: In function `cfi_chip_setup':
> > > > :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > > > drivers/built-in.o: In function `cfi_probe_chip':
> > > > :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > > > /tmp/ccY172rP.s: Assembler messages:
> > > > /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
> > > > /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> > > > make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> > > > /tmp/ccK4rjeO.s: Assembler messages:
> > > > /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
> > > > /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> > > > make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> > > > /tmp/ccUvhCYR.s: Assembler messages:
> > > > /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
> > > > /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
> > > 
> > > Can you provide a sample .config that DOES build correctly with
> > > XIP_KERNEL enabled + this patch? My first attempt yields some other
> > > failures I don't care to fixup right now...
> > > 
> > > Anyway, I don't doubt you have a good fix here, so I can probably take
> > > it. Any review from others would be welcome though.
> > 
> > I found the config in the attachment in my logs.
> 
> Thanks...
> 
> > To get this config working, I also needed this hunk from my set of
> > old unsubmitted patches:
> 
> ...but, does anyone care about XIP / MTD_XIP then, if the first two
> examples we have both have long-standing build issues?
> 

Probably not. I just checked the third user (omap1), and it seems that one
has been broken since 2009 with 941132606c76 ("OMAP: Remove OMAP_IO_ADDRESS,
use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead"), when Tony replaced
the inline omap_readl() with an extern function, thus breaking the
implementation of xip_irqpending() that must be inlined.

The other two have apparently been broken since 2011, by other patches
that also broke compilation.

	Arnd
