From: Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH v4 01/36] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
Date: Fri, 22 Dec 2017 22:40:27 +0800
Message-ID: <CAEbi=3fR=vHhEPME4ZFM3kcvVCeDQLJHOyhOC-EBdTQyhvXkiQ@mail.gmail.com>
References: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
 <201712201748.C4nCizdE%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <201712201748.C4nCizdE%fengguang.wu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg
List-Id: linux-arch.vger.kernel.org

2017-12-20 18:10 GMT+08:00 kbuild test robot <lkp@intel.com>:
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
> config: openrisc-or1ksim_defconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/io.h:25:0,
>                     from arch/openrisc/kernel/asm-offsets.c:35:
>>> arch/openrisc/include/asm/io.h:38:29: error: conflicting types for 'ioremap'
>     static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from arch/openrisc/include/asm/io.h:32:0,
>                     from include/linux/io.h:25,
>                     from arch/openrisc/kernel/asm-offsets.c:35:
>    include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> arch/openrisc/include/asm/io.h:44:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset,
>                                 ^~~~~~~~~~~~~~~
>    include/asm-generic/io.h:865:25: note: previous definition of 'ioremap_nocache' was here
>     #define ioremap_nocache ioremap_nocache
>                             ^
>    include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    make[2]: *** [arch/openrisc/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2
>
> vim +/ioremap +38 arch/openrisc/include/asm/io.h
>
> 58e0166a Jonas Bonn  2011-06-04  31
> 58e0166a Jonas Bonn  2011-06-04 @32  #include <asm-generic/io.h>
> 9b04ebd1 James Hogan 2012-10-23  33  #include <asm/pgtable.h>
> 58e0166a Jonas Bonn  2011-06-04  34
> 58e0166a Jonas Bonn  2011-06-04  35  extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
> 58e0166a Jonas Bonn  2011-06-04  36                             pgprot_t prot);
> 58e0166a Jonas Bonn  2011-06-04  37
> 58e0166a Jonas Bonn  2011-06-04 @38  static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
> 58e0166a Jonas Bonn  2011-06-04  39  {
> 58e0166a Jonas Bonn  2011-06-04  40     return __ioremap(offset, size, PAGE_KERNEL);
> 58e0166a Jonas Bonn  2011-06-04  41  }
> 58e0166a Jonas Bonn  2011-06-04  42
> 58e0166a Jonas Bonn  2011-06-04  43  /* #define _PAGE_CI       0x002 */
> 58e0166a Jonas Bonn  2011-06-04 @44  static inline void __iomem *ioremap_nocache(phys_addr_t offset,
> 58e0166a Jonas Bonn  2011-06-04  45                                          unsigned long size)
> 58e0166a Jonas Bonn  2011-06-04  46  {
> 58e0166a Jonas Bonn  2011-06-04  47     return __ioremap(offset, size,
> 58e0166a Jonas Bonn  2011-06-04  48                      __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI));
> 58e0166a Jonas Bonn  2011-06-04  49  }
> 58e0166a Jonas Bonn  2011-06-04  50
>
> :::::: The code at line 38 was first introduced by commit
> :::::: 58e0166a4772aaeb10c9b0f6d59f19099d2047df OpenRISC: Headers
>
> :::::: TO: Jonas Bonn <jonas@southpole.se>
> :::::: CC: Jonas Bonn <jonas@southpole.se>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Hi, all:

I just tried to fix this build error.
Should I send this patch next time with nds32 patchset?

--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -29,13 +29,14 @@
 #define PIO_OFFSET             0
 #define PIO_MASK               0

+#define ioremap_nocache ioremap_nocache
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>

 extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
                                pgprot_t prot);

-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
        return __ioremap(offset, size, PAGE_KERNEL);
 }
