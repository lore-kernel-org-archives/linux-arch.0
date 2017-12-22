From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v4 01/36] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
Date: Fri, 22 Dec 2017 22:38:54 +0800
Message-ID: <CAEbi=3dvLKVOtU+oZN5rLhHcyZUy2V2-a=-u5PjgUmasF-Jpgw@mail.gmail.com>
References: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
 <201712201836.XDtv2JdK%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:41318 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbdLVOjh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Dec 2017 09:39:37 -0500
In-Reply-To: <201712201836.XDtv2JdK%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg

2017-12-20 18:09 GMT+08:00 kbuild test robot <lkp@intel.com>:
> Hi Greentime,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on v4.15-rc4 next-20171220]
> [cannot apply to linus/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(unsigned long offset, unsigned long size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
>     #define ioremap_nocache(X,Y) ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    include/asm-generic/io.h:865:0: note: this is the location of the previous definition
>     #define ioremap_nocache ioremap_nocache
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
>     #define ioremap_wc(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    include/asm-generic/io.h:881:0: note: this is the location of the previous definition
>     #define ioremap_wc ioremap_wc
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
>     #define ioremap_wt(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from arch/sparc/kernel/kernel.h:4,
>                     from arch/sparc/kernel/traps_32.c:30:
>    include/asm-generic/io.h:889:0: note: this is the location of the previous definition
>     #define ioremap_wt ioremap_wt
>
>    cc1: all warnings being treated as errors
> --
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(unsigned long offset, unsigned long size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
>     #define ioremap_nocache(X,Y) ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:865:0: note: this is the location of the previous definition
>     #define ioremap_nocache ioremap_nocache
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
>     #define ioremap_wc(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:881:0: note: this is the location of the previous definition
>     #define ioremap_wc ioremap_wc
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
>     #define ioremap_wt(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:889:0: note: this is the location of the previous definition
>     #define ioremap_wt ioremap_wt
>
>>> arch/sparc/kernel/ioport.c:124:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(unsigned long offset, unsigned long size)
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from include/linux/linkage.h:6:0,
>                     from include/linux/kernel.h:6,
>                     from include/linux/list.h:8,
>                     from include/linux/module.h:9,
>                     from arch/sparc/kernel/ioport.c:28:
>    arch/sparc/kernel/ioport.c:131:15: error: conflicting types for 'ioremap'
>     EXPORT_SYMBOL(ioremap);
>                   ^
>    include/linux/export.h:65:21: note: in definition of macro '___EXPORT_SYMBOL'
>      extern typeof(sym) sym;      \
>                         ^~~
>>> arch/sparc/kernel/ioport.c:131:1: note: in expansion of macro 'EXPORT_SYMBOL'
>     EXPORT_SYMBOL(ioremap);
>     ^~~~~~~~~~~~~
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc/kernel/ioport.c:36:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    cc1: all warnings being treated as errors
> --
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>>> arch/sparc/include/asm/io_32.h:129:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(unsigned long offset, unsigned long size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:130:0: error: "ioremap_nocache" redefined [-Werror]
>     #define ioremap_nocache(X,Y) ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    include/asm-generic/io.h:865:0: note: this is the location of the previous definition
>     #define ioremap_nocache ioremap_nocache
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:131:0: error: "ioremap_wc" redefined [-Werror]
>     #define ioremap_wc(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    include/asm-generic/io.h:881:0: note: this is the location of the previous definition
>     #define ioremap_wc ioremap_wc
>
>    In file included from arch/sparc/include/asm/io.h:6:0,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    arch/sparc/include/asm/io_32.h:132:0: error: "ioremap_wt" redefined [-Werror]
>     #define ioremap_wt(X,Y)  ioremap((X),(Y))
>
>    In file included from arch/sparc/include/asm/io_32.h:13:0,
>                     from arch/sparc/include/asm/io.h:6,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:24,
>                     from include/asm-generic/hardirq.h:12,
>                     from arch/sparc/include/asm/hardirq_32.h:10,
>                     from arch/sparc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:8,
>                     from include/linux/interrupt.h:12,
>                     from include/linux/pci.h:31,
>                     from arch/sparc//kernel/ioport.c:36:
>    include/asm-generic/io.h:889:0: note: this is the location of the previous definition
>     #define ioremap_wt ioremap_wt
>
>    arch/sparc//kernel/ioport.c:124:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(unsigned long offset, unsigned long size)
>                   ^~~~~~~
>

Hi, all:

I just tried to fix this build error.
Should I send this patch next time with nds32 patchset?

--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -126,12 +126,7 @@ static inline void sbus_memcpy_toio(volatile void
__iomem *dst,
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_nocache(X,Y)   ioremap((X),(Y))
-#define ioremap_wc(X,Y)                ioremap((X),(Y))
-#define ioremap_wt(X,Y)                ioremap((X),(Y))
 void iounmap(volatile void __iomem *addr);
-
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 12894f2..9cdeb54 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -121,12 +121,12 @@ static void xres_free(struct xresource *xrp) {
  *
  * Bus type is always zero on IIep.
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size)
+void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
        char name[14];

        sprintf(name, "phys_%08x", (u32)offset);
-       return _sparc_alloc_io(0, offset, size, name);
+       return _sparc_alloc_io(0, (unsigned long)offset, size, name);
 }
 EXPORT_SYMBOL(ioremap);
