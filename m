From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] initrd: Fix virtual/physical mix-up in overwrite test
Date: Sun, 15 Jun 2008 16:07:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806151606320.5736@anakin>
References: <Pine.LNX.4.64.0712161148340.5869@anakin>
 <20071218030131.8b272833.akpm@linux-foundation.org> <Pine.LNX.4.64.0712182051050.24841@anakin>
 <20071218123119.54262974.akpm@linux-foundation.org> <Pine.LNX.4.64.0712231142190.24252@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759376AbYFOOH7@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0712231142190.24252@anakin>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, 23 Dec 2007, Geert Uytterhoeven wrote:
> New version below. Tested on Amiga. Compile-tested on ia32 (i386_defconfig) and
> pp64 (ps3_defconfig).

Ping?

> Subject: initrd: Fix virtual/physical mix-up in overwrite test
> 
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> On recent kernels, I get the following error when using an initrd:
> 
> | initrd overwritten (0x00b78000 < 0x07668000) - disabling it.
> 
> My Amiga 4000 has 12 MiB of RAM at physical address 0x07400000 (virtual
> 0x00000000).
> The initrd is located at the end of RAM: 0x00b78000 - 0x00c00000 (virtual).
> The overwrite test compares the (virtual) initrd location to the (physical)
> first available memory location, which fails.
> 
> This patch converts initrd_start to a page frame number, so it can be safely
> compared with min_low_pfn.
> 
> Before the introduction of discontiguous memory support on m68k
> (12d810c1b8c2b913d48e629e2b5c01d105029839), min_low_pfn was just left
> untouched by the m68k-specific code (zero, I guess), and everything worked
> fine.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> On several platforms, initrd_below_start_ok is set to 1:
> 
> | arch/mips/kernel/setup.c:       initrd_below_start_ok = 1;
> | arch/parisc/mm/init.c:                  initrd_below_start_ok = 1;
> | arch/powerpc/kernel/prom.c:                     initrd_below_start_ok = 1;
> | arch/ppc/platforms/hdpu.c:                      initrd_below_start_ok = 1;
> | arch/xtensa/kernel/setup.c:             initrd_below_start_ok = 1;
> 
> Some of these may be workarounds for this bug. Please check.
> 
>  init/main.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/init/main.c
> +++ b/init/main.c
> @@ -598,9 +598,10 @@ asmlinkage void __init start_kernel(void
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start && !initrd_below_start_ok &&
> -			initrd_start < min_low_pfn << PAGE_SHIFT) {
> +	    page_to_pfn(virt_to_page(initrd_start)) < min_low_pfn) {
>  		printk(KERN_CRIT "initrd overwritten (0x%08lx < 0x%08lx) - "
> -		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
> +		    "disabling it.\n",
> +		    page_to_pfn(virt_to_page(initrd_start)), min_low_pfn);
>  		initrd_start = 0;
>  	}
>  #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
