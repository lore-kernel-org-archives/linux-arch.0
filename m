From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Fri, 4 Mar 2016 16:22:03 -0800
Message-ID: <20160305002203.GF55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
 <5158260.vK2YuWzYIn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5158260.vK2YuWzYIn@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Sat, Mar 05, 2016 at 01:19:21AM +0100, Arnd Bergmann wrote:
> On Friday 04 March 2016 16:02:25 Brian Norris wrote:
> > On Mon, Jan 25, 2016 at 04:41:50PM +0100, Arnd Bergmann wrote:
> > > When XIP_KERNEL is enabled, some functions are defined in the .data
> > > ELF section because we require them to be in RAM whenever we communicate
> > > with the flash chip. However this causes problems when FTRACE is
> > > enabled and gcc emits calls to __gnu_mcount_nc in the function
> > > prolog:
> > > 
> > > drivers/built-in.o: In function `cfi_chip_setup':
> > > :(.data+0x272fc): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > > drivers/built-in.o: In function `cfi_probe_chip':
> > > :(.data+0x27de8): relocation truncated to fit: R_ARM_CALL against symbol `__gnu_mcount_nc' defined in .text section in arch/arm/kernel/built-in.o
> > > /tmp/ccY172rP.s: Assembler messages:
> > > /tmp/ccY172rP.s:70: Warning: ignoring changed section attributes for .data
> > > /tmp/ccY172rP.s: Error: 1 warning, treating warnings as errors
> > > make[5]: *** [drivers/mtd/chips/cfi_probe.o] Error 1
> > > /tmp/ccK4rjeO.s: Assembler messages:
> > > /tmp/ccK4rjeO.s:421: Warning: ignoring changed section attributes for .data
> > > /tmp/ccK4rjeO.s: Error: 1 warning, treating warnings as errors
> > > make[5]: *** [drivers/mtd/chips/cfi_util.o] Error 1
> > > /tmp/ccUvhCYR.s: Assembler messages:
> > > /tmp/ccUvhCYR.s:1895: Warning: ignoring changed section attributes for .data
> > > /tmp/ccUvhCYR.s: Error: 1 warning, treating warnings as errors
> > 
> > Can you provide a sample .config that DOES build correctly with
> > XIP_KERNEL enabled + this patch? My first attempt yields some other
> > failures I don't care to fixup right now...
> > 
> > Anyway, I don't doubt you have a good fix here, so I can probably take
> > it. Any review from others would be welcome though.
> 
> I found the config in the attachment in my logs.

Thanks...

> To get this config working, I also needed this hunk from my set of
> old unsubmitted patches:

...but, does anyone care about XIP / MTD_XIP then, if the first two
examples we have both have long-standing build issues?

Regards,
Brian

> diff --git a/arch/arm/mach-sa1100/include/mach/mtd-xip.h b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
> index b3d684098fbf..cb76096a2e36 100644
> --- a/arch/arm/mach-sa1100/include/mach/mtd-xip.h
> +++ b/arch/arm/mach-sa1100/include/mach/mtd-xip.h
> @@ -20,7 +20,7 @@
>  #define xip_irqpending()	(ICIP & ICMR)
>  
>  /* we sample OSCR and convert desired delta to usec (1/4 ~= 1000000/3686400) */
> -#define xip_currtime()		(OSCR)
> -#define xip_elapsed_since(x)	(signed)((OSCR - (x)) / 4)
> +#define xip_currtime()		readl_relaxed(OSCR)
> +#define xip_elapsed_since(x)	(signed)((readl_relaxed(OSCR) - (x)) / 4)
>  
>  #endif /* __ARCH_SA1100_MTD_XIP_H__ */
> 
> 	Arnd
