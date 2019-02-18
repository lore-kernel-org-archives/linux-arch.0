Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbfBRSK4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Feb 2019 13:10:56 -0500
Date: Tue, 19 Feb 2019 02:10:34 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [asm-generic:master 4/6] arch/powerpc/kernel/iomap.c:142:6: error:
 conflicting types for 'ioread8_rep'
Message-ID: <201902190221.hbMLi4kS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: kbuild-all@01.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   3c4fcc2648569c3fe573849f9254c8c3499ec648
commit: 6ce9e34a28174293927e0b51acc4d30a130a565a [4/6] iomap: add missing const to ioread*/iowrite addr arg
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6ce9e34a28174293927e0b51acc4d30a130a565a
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/iomap.c:18:14: error: conflicting types for 'ioread8'
    unsigned int ioread8(void __iomem *addr)
                 ^~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:29:21: note: previous declaration of 'ioread8' was here
    extern unsigned int ioread8(const void __iomem *addr);
                        ^~~~~~~
>> arch/powerpc/kernel/iomap.c:22:14: error: conflicting types for 'ioread16'
    unsigned int ioread16(void __iomem *addr)
                 ^~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:30:21: note: previous declaration of 'ioread16' was here
    extern unsigned int ioread16(const void __iomem *addr);
                        ^~~~~~~~
>> arch/powerpc/kernel/iomap.c:26:14: error: conflicting types for 'ioread16be'
    unsigned int ioread16be(void __iomem *addr)
                 ^~~~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:31:21: note: previous declaration of 'ioread16be' was here
    extern unsigned int ioread16be(const void __iomem *addr);
                        ^~~~~~~~~~
>> arch/powerpc/kernel/iomap.c:30:14: error: conflicting types for 'ioread32'
    unsigned int ioread32(void __iomem *addr)
                 ^~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:32:21: note: previous declaration of 'ioread32' was here
    extern unsigned int ioread32(const void __iomem *addr);
                        ^~~~~~~~
>> arch/powerpc/kernel/iomap.c:34:14: error: conflicting types for 'ioread32be'
    unsigned int ioread32be(void __iomem *addr)
                 ^~~~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:33:21: note: previous declaration of 'ioread32be' was here
    extern unsigned int ioread32be(const void __iomem *addr);
                        ^~~~~~~~~~
>> arch/powerpc/kernel/iomap.c:142:6: error: conflicting types for 'ioread8_rep'
    void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
         ^~~~~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:60:13: note: previous declaration of 'ioread8_rep' was here
    extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
                ^~~~~~~~~~~
>> arch/powerpc/kernel/iomap.c:146:6: error: conflicting types for 'ioread16_rep'
    void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
         ^~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:61:13: note: previous declaration of 'ioread16_rep' was here
    extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
                ^~~~~~~~~~~~
>> arch/powerpc/kernel/iomap.c:150:6: error: conflicting types for 'ioread32_rep'
    void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
         ^~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/io.h:653,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from arch/powerpc/kernel/iomap.c:7:
   include/asm-generic/iomap.h:62:13: note: previous declaration of 'ioread32_rep' was here
    extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
                ^~~~~~~~~~~~

vim +/ioread8_rep +142 arch/powerpc/kernel/iomap.c

^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   @7  #include <linux/pci.h>
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16    8  #include <linux/mm.h>
93087948 arch/powerpc/kernel/iomap.c Paul Gortmaker         2011-07-29    9  #include <linux/export.h>
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   10  #include <asm/io.h>
50747cb8 arch/powerpc/kernel/iomap.c Benjamin Herrenschmidt 2007-07-26   11  #include <asm/pci-bridge.h>
38e9d36b arch/powerpc/kernel/iomap.c Benjamin Herrenschmidt 2017-01-30   12  #include <asm/isa-bridge.h>
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   13  
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   14  /*
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   15   * Here comes the ppc64 implementation of the IOMAP 
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   16   * interfaces.
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   17   */
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26  @18  unsigned int ioread8(void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   19  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   20  	return readb(addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   21  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26  @22  unsigned int ioread16(void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   23  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   24  	return readw(addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   25  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26  @26  unsigned int ioread16be(void __iomem *addr)
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   27  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23   28  	return readw_be(addr);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   29  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26  @30  unsigned int ioread32(void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   31  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   32  	return readl(addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   33  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26  @34  unsigned int ioread32be(void __iomem *addr)
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   35  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23   36  	return readl_be(addr);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   37  }
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   38  EXPORT_SYMBOL(ioread8);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   39  EXPORT_SYMBOL(ioread16);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   40  EXPORT_SYMBOL(ioread16be);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   41  EXPORT_SYMBOL(ioread32);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   42  EXPORT_SYMBOL(ioread32be);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   43  #ifdef __powerpc64__
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   44  u64 ioread64(void __iomem *addr)
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   45  {
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   46  	return readq(addr);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   47  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   48  u64 ioread64_lo_hi(void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   49  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   50  	return readq(addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   51  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   52  u64 ioread64_hi_lo(void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   53  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   54  	return readq(addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   55  }
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   56  u64 ioread64be(void __iomem *addr)
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   57  {
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   58  	return readq_be(addr);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   59  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   60  u64 ioread64be_lo_hi(void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   61  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   62  	return readq_be(addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   63  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   64  u64 ioread64be_hi_lo(void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   65  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   66  	return readq_be(addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   67  }
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   68  EXPORT_SYMBOL(ioread64);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   69  EXPORT_SYMBOL(ioread64_lo_hi);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   70  EXPORT_SYMBOL(ioread64_hi_lo);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   71  EXPORT_SYMBOL(ioread64be);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   72  EXPORT_SYMBOL(ioread64be_lo_hi);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27   73  EXPORT_SYMBOL(ioread64be_hi_lo);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19   74  #endif /* __powerpc64__ */
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   75  
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26   76  void iowrite8(u8 val, void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   77  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   78  	writeb(val, addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   79  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26   80  void iowrite16(u16 val, void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   81  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   82  	writew(val, addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   83  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26   84  void iowrite16be(u16 val, void __iomem *addr)
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   85  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23   86  	writew_be(val, addr);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   87  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26   88  void iowrite32(u32 val, void __iomem *addr)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   89  {
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   90  	writel(val, addr);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   91  }
8943212c arch/powerpc/kernel/iomap.c Kumar Gala             2007-01-26   92  void iowrite32be(u32 val, void __iomem *addr)
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   93  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23   94  	writel_be(val, addr);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   95  }
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   96  EXPORT_SYMBOL(iowrite8);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   97  EXPORT_SYMBOL(iowrite16);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20   98  EXPORT_SYMBOL(iowrite16be);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16   99  EXPORT_SYMBOL(iowrite32);
76637536 arch/ppc64/kernel/iomap.c   Arthur Othieno         2005-08-20  100  EXPORT_SYMBOL(iowrite32be);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  101  #ifdef __powerpc64__
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  102  void iowrite64(u64 val, void __iomem *addr)
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  103  {
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  104  	writeq(val, addr);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  105  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  106  void iowrite64_lo_hi(u64 val, void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  107  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  108  	writeq(val, addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  109  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  110  void iowrite64_hi_lo(u64 val, void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  111  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  112  	writeq(val, addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  113  }
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  114  void iowrite64be(u64 val, void __iomem *addr)
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  115  {
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  116  	writeq_be(val, addr);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  117  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  118  void iowrite64be_lo_hi(u64 val, void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  119  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  120  	writeq_be(val, addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  121  }
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  122  void iowrite64be_hi_lo(u64 val, void __iomem *addr)
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  123  {
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  124  	writeq_be(val, addr);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  125  }
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  126  EXPORT_SYMBOL(iowrite64);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  127  EXPORT_SYMBOL(iowrite64_lo_hi);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  128  EXPORT_SYMBOL(iowrite64_hi_lo);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  129  EXPORT_SYMBOL(iowrite64be);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  130  EXPORT_SYMBOL(iowrite64be_lo_hi);
07c3d9ea arch/powerpc/kernel/iomap.c Logan Gunthorpe        2018-03-27  131  EXPORT_SYMBOL(iowrite64be_hi_lo);
d54fc90c arch/powerpc/kernel/iomap.c Horia Geantă           2016-05-19  132  #endif /* __powerpc64__ */
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  133  
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  134  /*
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  135   * These are the "repeat read/write" functions. Note the
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  136   * non-CPU byte order. We do things in "IO byteorder"
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  137   * here.
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  138   *
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  139   * FIXME! We could make these do EEH handling if we really
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  140   * wanted. Not clear if we do.
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  141   */
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16 @142  void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  143  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23  144  	readsb(addr, dst, count);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  145  }
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16 @146  void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  147  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23  148  	readsw(addr, dst, count);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  149  }
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16 @150  void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  151  {
0eb57368 arch/powerpc/kernel/iomap.c Gavin Shan             2014-06-23  152  	readsl(addr, dst, count);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  153  }
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  154  EXPORT_SYMBOL(ioread8_rep);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  155  EXPORT_SYMBOL(ioread16_rep);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  156  EXPORT_SYMBOL(ioread32_rep);
^1da177e arch/ppc64/kernel/iomap.c   Linus Torvalds         2005-04-16  157  

:::::: The code at line 142 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
N25wtUBKAAA=

--3V7upXqbjpZ4EhLz--
