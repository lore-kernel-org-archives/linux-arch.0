From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 01/41] cpu_alloc: Increase percpu area size to 128k
Date: Thu, 29 May 2008 20:56:21 -0700
Message-ID: <20080530040010.806208523@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45432 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750761AbYE3EAO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:14 -0400
Content-Disposition: inline; filename=ia64_increase_percpu_size
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

The per cpu allocator requires more per cpu space and we are already near
the limit on IA64. Increase the maximum size of the IA64 per cpu area from
64K to 128K.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 include/asm-ia64/page.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/asm-ia64/page.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/page.h	2008-05-29 12:10:42.216486476 -0700
+++ linux-2.6/include/asm-ia64/page.h	2008-05-29 12:11:06.218953049 -0700
@@ -42,7 +42,7 @@
 #define PAGE_MASK		(~(PAGE_SIZE - 1))
 #define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
 
-#define PERCPU_PAGE_SHIFT	16	/* log2() of max. size of per-CPU area */
+#define PERCPU_PAGE_SHIFT	17	/* log2() of max. size of per-CPU area */
 #define PERCPU_PAGE_SIZE	(__IA64_UL_CONST(1) << PERCPU_PAGE_SHIFT)
 
 

-- 
