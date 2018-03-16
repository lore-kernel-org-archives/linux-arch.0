From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH] cris: add ioremap_nocache declaration before include asm-generic/io.h.
Date: Fri, 16 Mar 2018 15:44:35 +0800
Message-ID: <CAEbi=3dTwumbFkvQQekqpqh8v5j1=hJp3iK+-TN5iZwj9y=Ctg@mail.gmail.com>
References: <20180301163838.10818-1-greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301163838.10818-1-greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-cris-kernel@axis.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Greentime <greentime@andestech.com>, Green Hu <green.hu@gmail.com>, jesper.nilsson@axis.com, starvik@axis.com
List-Id: linux-arch.vger.kernel.org

2018-03-02 0:38 GMT+08:00 Greentime Hu <green.hu@gmail.com>:
> A future commit for the nds32 architecture bootstrap("asm-generic/io.h:
> move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
> CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
> This means that in order to suppress re-definition errors we need to
> setup #define's before importing asm-generic/io.h.
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  arch/cris/include/asm/io.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/cris/include/asm/io.h b/arch/cris/include/asm/io.h
> index c92712d30f54..3867db75c314 100644
> --- a/arch/cris/include/asm/io.h
> +++ b/arch/cris/include/asm/io.h
> @@ -20,6 +20,7 @@ static inline void __iomem * ioremap (unsigned long offset, unsigned long size)
>  extern void iounmap(volatile void * __iomem addr);
>
>  extern void __iomem * ioremap_nocache(unsigned long offset, unsigned long size);
> +#define ioremap_nocache ioremap_nocache
>
>  #include <asm-generic/io.h>
>
> --
> I am picking up the patch in the nds32 tree that caused the regression.
> Subject: [linux-next:master 3188/3885] include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   eced78aae9cba83072d5335fbc9b2282a9270469
> commit: b3ada9d0ce8d286c8bbbb02fdbddec5036242b42 [3188/3885] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
> config: cris-etrax-100lx_v2_defconfig (attached as .config)
> compiler: cris-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b3ada9d0ce8d286c8bbbb02fdbddec5036242b42
>         # save the attached .config to linux build tree
>         make.cross ARCH=cris
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/cris/include/asm/io.h:24:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:25,
>                     from include/asm-generic/hardirq.h:13,
>                     from ./arch/cris/include/generated/asm/hardirq.h:1,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/trace_events.h:9,
>                     from include/trace/syscall.h:7,
>                     from include/linux/syscalls.h:82,
>                     from init/main.c:20:
>>> include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>

Drop this patch due to not supporting cris port.
https://lkml.org/lkml/2018/3/13/200
