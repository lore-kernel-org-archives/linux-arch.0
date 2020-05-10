From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/31] powerpc: unexport flush_icache_user_range
Date: Sun, 10 May 2020 09:54:44 +0200
Message-ID: <20200510075510.987823-6-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJHzt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 May 2020 03:55:49 -0400
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

flush_icache_user_range is only used by copy_to_user_page, which is
only used by core VM code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/mm/mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 041ed7cfd341a..f0d1bf0a8e14f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -587,7 +587,6 @@ void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	flush_icache_range(maddr, maddr + len);
 	kunmap(page);
 }
-EXPORT_SYMBOL(flush_icache_user_range);
 
 /*
  * System memory should not be in /proc/iomem but various tools expect it
-- 
2.26.2
