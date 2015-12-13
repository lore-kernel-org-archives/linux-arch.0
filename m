From: Chen Gang <chengang@emindsoft.com.cn>
Subject: [PATCH trivial] include/asm-generic/page.h: Notice about 80 columns
Date: Sun, 13 Dec 2015 17:04:36 +0800
Message-ID: <566D34A4.1040103@emindsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-251.mail.alibaba.com ([205.204.113.251]:54742 "EHLO
	us-alimail-mta1.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751210AbbLMJCo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Dec 2015 04:02:44 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen Gang <gang.chen.5i5j@gmail.com>, chenwei@emindsoft.com.cn


It is a trivial patch.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 include/asm-generic/page.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index 67cfb7d..e04cef4 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -87,7 +87,8 @@ extern unsigned long memory_end;
 #define page_to_phys(page)      ((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
 #endif
 
-#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
+#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && \
+				((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
 				((void *)(kaddr) < (void *)memory_end))
-- 
1.9.3
