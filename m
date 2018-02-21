Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39940 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbeBULWC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Feb 2018 06:22:02 -0500
MIME-Version: 1.0
In-Reply-To: <201802161853.FKQRlYLX%fengguang.wu@intel.com>
References: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
 <201802161853.FKQRlYLX%fengguang.wu@intel.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 21 Feb 2018 19:21:20 +0800
Message-ID: <CAEbi=3fMVLgqMxg5ru=Nd7YHTHs7YvirorT-zEtdBpMkuWHLyg@mail.gmail.com>
Subject: Re: [PATCH v7 02/37] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt
 out of ifndef CONFIG_MMU
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>

2018-02-16 18:47 GMT+08:00 kbuild test robot <lkp@intel.com>:
> Hi Greentime,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16-rc1 next-20180216]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel-Port/20180216-155013
> config: xtensa-allmodconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/drivers//staging/comedi/drivers/comedi_8254.c:118:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/drivers//staging/comedi/drivers/comedi_8254.c:118:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/drivers//staging/comedi/drivers/comedi_8254.c:118:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/drivers//staging/comedi/drivers/comedi_8254.c:118:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
> --
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:45,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:45,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:45,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:45,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:64:0,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>    /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_defs.h:109:0: warning: "WSR" redefined
>      #define   WSR     0x01  /* sta: wide scsi received       [W]*/
>
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/bitops.h:22:0,
>                     from /kbuild/src/consumer/include/linux/bitops.h:38,
>                     from /kbuild/src/consumer/include/linux/kernel.h:11,
>                     from /kbuild/src/consumer/include/linux/list.h:9,
>                     from /kbuild/src/consumer/include/linux/wait.h:7,
>                     from /kbuild/src/consumer/include/linux/completion.h:12,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_glue.h:43,
>                     from /kbuild/src/consumer/drivers//scsi/sym53c8xx_2/sym_fw.c:40:
>    /kbuild/src/consumer/arch/xtensa/include/asm/processor.h:220:0: note: this is the location of the previous definition
>     #define WSR(v,sr) __asm__ __volatile__ ("wsr %0,"__stringify(sr) :: "a"(v));
>
> --
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/include/linux/pci.h:32,
>                     from /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:31:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/include/linux/pci.h:32,
>                     from /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:31:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/include/linux/pci.h:32,
>                     from /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:31:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/include/linux/pci.h:32,
>                     from /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:31:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/atomic.h:21:0,
>                     from /kbuild/src/consumer/include/linux/atomic.h:5,
>                     from /kbuild/src/consumer/include/linux/debug_locks.h:6,
>                     from /kbuild/src/consumer/include/linux/lockdep.h:28,
>                     from /kbuild/src/consumer/include/linux/spinlock_types.h:18,
>                     from /kbuild/src/consumer/include/linux/spinlock.h:82,
>                     from /kbuild/src/consumer/include/linux/seqlock.h:36,
>                     from /kbuild/src/consumer/include/linux/time.h:6,
>                     from /kbuild/src/consumer/include/linux/stat.h:19,
>                     from /kbuild/src/consumer/include/linux/module.h:10,
>                     from /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:30:
>    /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_xdp_setup':
>    /kbuild/src/consumer/arch/xtensa/include/asm/cmpxchg.h:139:3: warning: value computed is not used [-Wunused-value]
>      ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
>      ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//net/ethernet/intel/ixgbe/ixgbe_main.c:9949:4: note: in expansion of macro 'xchg'
>        xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
>        ^~~~
> --
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/gameport.h:11,
>                     from /kbuild/src/consumer/drivers//input/joystick/analog.c:36:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/gameport.h:11:0,
>                     from /kbuild/src/consumer/drivers//input/joystick/analog.c:36:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/gameport.h:11,
>                     from /kbuild/src/consumer/drivers//input/joystick/analog.c:36:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/gameport.h:11:0,
>                     from /kbuild/src/consumer/drivers//input/joystick/analog.c:36:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//input/joystick/analog.c:176:2: warning: #warning Precise timer not defined for this architecture. [-Wcpp]
>     #warning Precise timer not defined for this architecture.
>      ^~~~~~~
> --
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:39:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:39:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:39:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:39:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/kernel.h:11:0,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:6,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:39:
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_query_device':
>    /kbuild/src/consumer/include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:149:25: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>      ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
>                             ^~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c: In function 'bnxt_re_reg_user_mr':
>    /kbuild/src/consumer/include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:3553:15: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>      if (length > BNXT_RE_MAX_MR_SIZE) {
>                   ^~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:61:34: note: in expansion of macro 'BIT'
>     #define BNXT_RE_MAX_MR_SIZE_HIGH BIT(39)
>                                      ^~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/bnxt_re.h:62:30: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE_HIGH'
>     #define BNXT_RE_MAX_MR_SIZE  BNXT_RE_MAX_MR_SIZE_HIGH
>                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/ib_verbs.c:3555:12: note: in expansion of macro 'BNXT_RE_MAX_MR_SIZE'
>        length, BNXT_RE_MAX_MR_SIZE);
>                ^~~~~~~~~~~~~~~~~~~
> --
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:39:
>>> /kbuild/src/consumer/include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
>     void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
>                   ^~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:39:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:59:29: note: previous definition of 'ioremap' was here
>     static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
>                                 ^~~~~~~
>    In file included from /kbuild/src/consumer/arch/xtensa/include/asm/io.h:82:0,
>                     from /kbuild/src/consumer/include/linux/io.h:25,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:39:
>>> /kbuild/src/consumer/include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
>     #define ioremap_nocache ioremap_nocache
>                             ^
>>> /kbuild/src/consumer/include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
>     static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
>                                 ^~~~~~~~~~~~~~~
>    In file included from /kbuild/src/consumer/include/linux/io.h:25:0,
>                     from /kbuild/src/consumer/include/linux/irq.h:25,
>                     from /kbuild/src/consumer/include/asm-generic/hardirq.h:13,
>                     from ./arch/xtensa/include/generated/asm/hardirq.h:1,
>                     from /kbuild/src/consumer/include/linux/hardirq.h:9,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:13,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:39:
>    /kbuild/src/consumer/arch/xtensa/include/asm/io.h:35:29: note: previous definition of 'ioremap_nocache' was here
>     static inline void __iomem *ioremap_nocache(unsigned long offset,
>                                 ^~~~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_service_nq':
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:333:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>        bnxt_qplib_arm_srq((struct bnxt_qplib_srq *)q_handle,
>                           ^
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:336:12: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>                (struct bnxt_qplib_srq *)q_handle,
>                ^
>    In file included from /kbuild/src/consumer/include/linux/swab.h:5:0,
>                     from /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:13,
>                     from /kbuild/src/consumer/include/linux/byteorder/big_endian.h:5,
>                     from /kbuild/src/consumer/arch/xtensa/include/uapi/asm/byteorder.h:8,
>                     from /kbuild/src/consumer/arch/xtensa/include/asm/bitops.h:23,
>                     from /kbuild/src/consumer/include/linux/bitops.h:38,
>                     from /kbuild/src/consumer/include/linux/kernel.h:11,
>                     from /kbuild/src/consumer/include/linux/interrupt.h:6,
>                     from /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:39:
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_create_srq':
>    /kbuild/src/consumer/include/uapi/linux/swab.h:130:24: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      (__builtin_constant_p((__u64)(x)) ? \
>                            ^
>    /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:31:43: note: in expansion of macro '__swab64'
>     #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
>                                               ^~~~~~~~
>    /kbuild/src/consumer/include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>     #define cpu_to_le64 __cpu_to_le64
>                         ^~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:567:19: note: in expansion of macro 'cpu_to_le64'
>      req.srq_handle = cpu_to_le64(srq);
>                       ^~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/swab.h:24:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      (((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) | \
>        ^
>    /kbuild/src/consumer/include/uapi/linux/swab.h:131:2: note: in expansion of macro '___constant_swab64'
>      ___constant_swab64(x) :   \
>      ^~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:31:43: note: in expansion of macro '__swab64'
>     #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
>                                               ^~~~~~~~
>    /kbuild/src/consumer/include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>     #define cpu_to_le64 __cpu_to_le64
>                         ^~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:567:19: note: in expansion of macro 'cpu_to_le64'
>      req.srq_handle = cpu_to_le64(srq);
>                       ^~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/swab.h:25:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      (((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) | \
>        ^
>    /kbuild/src/consumer/include/uapi/linux/swab.h:131:2: note: in expansion of macro '___constant_swab64'
>      ___constant_swab64(x) :   \
>      ^~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:31:43: note: in expansion of macro '__swab64'
>     #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
>                                               ^~~~~~~~
>    /kbuild/src/consumer/include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>     #define cpu_to_le64 __cpu_to_le64
>                         ^~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:567:19: note: in expansion of macro 'cpu_to_le64'
>      req.srq_handle = cpu_to_le64(srq);
>                       ^~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/swab.h:26:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      (((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) | \
>        ^
>    /kbuild/src/consumer/include/uapi/linux/swab.h:131:2: note: in expansion of macro '___constant_swab64'
>      ___constant_swab64(x) :   \
>      ^~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:31:43: note: in expansion of macro '__swab64'
>     #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
>                                               ^~~~~~~~
>    /kbuild/src/consumer/include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>     #define cpu_to_le64 __cpu_to_le64
>                         ^~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:567:19: note: in expansion of macro 'cpu_to_le64'
>      req.srq_handle = cpu_to_le64(srq);
>                       ^~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/swab.h:27:4: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>      (((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) | \
>        ^
>    /kbuild/src/consumer/include/uapi/linux/swab.h:131:2: note: in expansion of macro '___constant_swab64'
>      ___constant_swab64(x) :   \
>      ^~~~~~~~~~~~~~~~~~
>    /kbuild/src/consumer/include/uapi/linux/byteorder/big_endian.h:31:43: note: in expansion of macro '__swab64'
>     #define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
>                                               ^~~~~~~~
>    /kbuild/src/consumer/include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
>     #define cpu_to_le64 __cpu_to_le64
>                         ^~~~~~~~~~~~~
>    /kbuild/src/consumer/drivers//infiniband/hw/bnxt_re/qplib_fp.c:567:19: note: in expansion of macro 'cpu_to_le64'
>      req.srq_handle = cpu_to_le64(srq);
> ..


I will add this patch to the nds32 port series.

From: Greentime Hu <greentime@andestech.com>
Date: Wed, 21 Feb 2018 14:21:23 +0800
Subject: [PATCH] xtensa: add ioremap_nocache declaration before include
 asm-generic/io.h.

A future commit for the nds32 architecture bootstrap("asm-generic/io.h:
move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
This means that in order to suppress re-definition errors we need to
setup #define's before importing asm-generic/io.h.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/xtensa/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index c38e5a732d86..acc5bb2cf1c7 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -52,6 +52,7 @@ static inline void __iomem *ioremap_cache(unsigned
long offset,
                return xtensa_ioremap_cache(offset, size);
 }
 #define ioremap_cache ioremap_cache
+#define ioremap_nocache ioremap_nocache

 #define ioremap_wc ioremap_nocache
