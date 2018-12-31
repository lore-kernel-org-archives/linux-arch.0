Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPdl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Dec 2018 10:33:41 -0500
From: guoren@kernel.org
Subject: [PATCH 01/14] csky: fixup abiv2 mmap(... O_SYNC) failed.
Date: Mon, 31 Dec 2018 23:32:53 +0800
Message-ID: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20181231153253.qqQhyeKnj1p4RK_FwOjr3p7ZC-QBW-BB9rjQA3-q4YA@z>

From: Guo Ren <ren_guo@c-sky.com>

Glibc function mmap(... O_SYNC) will make page to _PAGE_UNCACHE +
_PAGE_SO and strong-order page couldn't support unalignment access.
So remove _PAGE_SO from _PAGE_UNCACHE, also sync abiv1 with the macro
of _PAGE_SO.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Liu Renwei <Renwei.Liu@verisilicon.com>
Tested-by: Yuan Qiyun <qiyun_yuan@c-sky.com>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 1 +
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 2 +-
 arch/csky/mm/ioremap.c                 | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index 455075b..d605445 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -26,6 +26,7 @@
 
 #define _PAGE_CACHE		(3<<9)
 #define _PAGE_UNCACHE		(2<<9)
+#define _PAGE_SO		_PAGE_UNCACHE
 
 #define _CACHE_MASK		(7<<9)
 
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index b20ae19..137f793 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -32,6 +32,6 @@
 #define _CACHE_MASK		_PAGE_CACHE
 
 #define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE | _PAGE_BUF)
-#define _CACHE_UNCACHED		(_PAGE_VALID | _PAGE_SO)
+#define _CACHE_UNCACHED		(_PAGE_VALID)
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index 7ad3ff1..cb7c03e 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -30,7 +30,7 @@ void __iomem *ioremap(phys_addr_t addr, size_t size)
 	vaddr = (unsigned long)area->addr;
 
 	prot = __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE |
-			_PAGE_GLOBAL | _CACHE_UNCACHED);
+			_PAGE_GLOBAL | _CACHE_UNCACHED | _PAGE_SO);
 
 	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
 		free_vm_area(area);
-- 
2.7.4
