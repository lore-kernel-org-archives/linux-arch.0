From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH] nios2: add ioremap_nocache declaration before include asm-generic/io.h.
Date: Fri,  2 Mar 2018 00:39:43 +0800
Message-ID: <20180301163943.10887-1-greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lftan@altera.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, greentime@andestech.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

A commit for the nds32 architecture bootstrap("asm-generic/io.h:
move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef
CONFIG_MMU") will move the ioremap_nocache out of the CONFIG_MMU ifdef.
This means that in order to suppress re-definition errors we need to
setup #define's before importing asm-generic/io.h.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nios2/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index ce072ba0f8dd..9010243077ab 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -45,6 +45,7 @@ static inline void iounmap(void __iomem *addr)
 	__iounmap(addr);
 }
 
+#define ioremap_nocache ioremap_nocache
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
 
-- 
I am picking up the patch in the nds32 tree that caused the regression.
Subject: [linux-next:master 2878/4431] include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   827ad482fda17d0de5df5116fda827cd3671e62e
commit: b3ada9d0ce8d286c8bbbb02fdbddec5036242b42 [2878/4431] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
config: nios2-10m50_defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b3ada9d0ce8d286c8bbbb02fdbddec5036242b42
        # save the attached .config to linux build tree
        make.cross ARCH=nios2

All errors (new ones prefixed by >>):

   In file included from arch/nios2/include/asm/io.h:61:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:25,
                    from include/asm-generic/hardirq.h:13,
                    from ./arch/nios2/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:13,
                    from include/linux/kernel_stat.h:9,
                    from arch/nios2/kernel/asm-offsets.c:21:
>> include/asm-generic/io.h:864:15: error: conflicting types for 'ioremap'
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
