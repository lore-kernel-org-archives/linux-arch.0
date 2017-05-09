From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] asm-generic/io.h: remove unnecessary #include of <linux/vmalloc.h>
Date: Tue,  9 May 2017 10:50:45 +0200
Message-ID: <20170509085045.7342-1-tklauser@distanz.ch>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:36432 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdEIIux (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 May 2017 04:50:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Ley Foon Tan <lftan@altera.com>

After commit 1f5307b1e094 ("mm, vmalloc: properly track vmalloc users")
the build for ARCH=nios2 fails with:

In file included from ./include/asm-generic/io.h:767:0,
  		 from ./arch/nios2/include/asm/io.h:61,
		 from ./include/linux/io.h:25,
		 from ./arch/nios2/include/asm/pgtable.h:18,
		 from ./include/linux/mm.h:70,
		 from ./include/linux/pid_namespace.h:6,
		 from ./include/linux/ptrace.h:9,
		 from ./arch/nios2/include/uapi/asm/elf.h:23,
		 from ./arch/nios2/include/asm/elf.h:22,
		 from ./include/linux/elf.h:4,
		 from ./include/linux/module.h:15,
		 from init/main.c:16:
./include/linux/vmalloc.h: In function '__vmalloc_node_flags':
./include/linux/vmalloc.h:99:40: error: 'PAGE_KERNEL' undeclared (first use in this function); did you mean 'GFP_KERNEL'?

which is due to the newly added #include <asm/pgtable.h>, which on nios2
includes <linux/io.h> and thus <asm/io.h> and <asm-generic/io.h> which
again includes <linux/vmalloc.h>.

It turns out the #include <linux/vmalloc.h> in <asm-generic/io.h> isn't
necessary at all since none of it definitions are used there, so remove
it alltogether.

Build tested on
 - nios2: 10m50_defconfig
 - x86: allyesconfig, various randconfigs
 - arm: tegra_defconfig, various randconfigs

Cc: Michal Hocko <mhocko@suse.com>
Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/asm-generic/io.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015eb3403..fe5e01fbed54 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
 
 #ifdef __KERNEL__
 
-#include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
 #ifndef CONFIG_GENERIC_IOMAP
-- 
2.12.2
