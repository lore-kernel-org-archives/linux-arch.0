From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/29] asm-generic: add a flush_icache_user_range stub
Date: Fri, 15 May 2020 16:36:37 +0200
Message-ID: <20200515143646.3857579-21-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
Sender: linux-mips-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Define flush_icache_user_range to flush_icache_range unless the
architecture provides its own implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/asm-generic/cacheflush.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 2c9686fefb715..907fa5d164944 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -66,6 +66,10 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 }
 #endif
 
+#ifndef flush_icache_user_range
+#define flush_icache_user_range flush_icache_range
+#endif
+
 #ifndef flush_icache_page
 static inline void flush_icache_page(struct vm_area_struct *vma,
 				     struct page *page)
-- 
2.26.2
