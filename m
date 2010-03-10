From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: DMA_ERROR_CODE (was: Re: linux-next: build failure after merge of the
	final tree)
Date: Wed, 10 Mar 2010 12:03:37 +0100
Message-ID: <10f740e81003100303m5a4ffb45t26c380b4ef3dec37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 1, 2010 at 10:40, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
>
> drivers/mtd/nand/r852.c:22: error: 'enable_dma' redeclared as different kind of symbol
> arch/powerpc/include/asm/dma.h:189: note: previous definition of 'enable_dma' was here
> drivers/mtd/nand/r852.c: In function 'r852_engine_enable':
> drivers/mtd/nand/r852.c:545: error: implicit declaration of function 'msleep'
>
> Caused by commit 67e054e919248fa1db93de727fb9ad49eb700642 ("mtd: nand:
> Add driver for Ricoh xD/SmartMedia reader") from the mtd.
>
> I applied the following patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 1 Mar 2010 20:21:06 +1100
> Subject: [PATCH] mtd: nand: fix name space clash
>
> and include delay.h for msleep().

Another issue is that this driver uses DMA_ERROR_CODE, which is currently
defined on powerpc/sparc/x86 only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
