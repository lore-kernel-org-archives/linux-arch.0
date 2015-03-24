Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shonan.sfc.wide.ad.jp ([203.178.142.130]:60035 "EHLO
	mail.sfc.wide.ad.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752590AbbCXNVH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Mar 2015 09:21:07 -0400
From: Hajime Tazaki <tazaki@sfc.wide.ad.jp>
Subject: [RFC PATCH 02/11] slab: add private memory allocator header for arch/lib
Date: Tue, 24 Mar 2015 22:10:33 +0900
Message-ID: <1427202642-1716-3-git-send-email-tazaki@sfc.wide.ad.jp>
In-Reply-To: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>
References: <1427202642-1716-1-git-send-email-tazaki@sfc.wide.ad.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Hajime Tazaki <tazaki@sfc.wide.ad.jp>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Jhristoph Lameter <cl@linux.com>, Jekka Enberg <penberg@kernel.org>, Javid Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Jndrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Rusty Russell <rusty@rustcorp.com.au>, Mathieu Lacage <mathieu.lacage@gmail.com>
Message-ID: <20150324131033.pgRtObiJ4y5RWyRaoMWixR7uT-LYd2dRVtXw6vdiULE@z>

add header includion for CONFIG_LIB to wrap kmalloc and co. This will
bring malloc(3) based allocator used by arch/lib.

Signed-off-by: Hajime Tazaki <tazaki@sfc.wide.ad.jp>
---
 include/linux/slab.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9a139b6..6914e1f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -205,6 +205,14 @@ size_t ksize(const void *);
 #endif
 #endif
 
+#ifdef CONFIG_LIB
+#define KMALLOC_SHIFT_MAX	30
+#define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
+#ifndef KMALLOC_SHIFT_LOW
+#define KMALLOC_SHIFT_LOW	3
+#endif
+#endif
+
 /* Maximum allocatable size */
 #define KMALLOC_MAX_SIZE	(1UL << KMALLOC_SHIFT_MAX)
 /* Maximum size for which we actually use a slab cache */
@@ -350,6 +358,9 @@ kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
 }
 #endif
 
+#ifdef CONFIG_LIB
+#include <asm/slab.h>
+#else
 static __always_inline void *kmalloc_large(size_t size, gfp_t flags)
 {
 	unsigned int order = get_order(size);
@@ -428,6 +439,7 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 	}
 	return __kmalloc(size, flags);
 }
+#endif
 
 /*
  * Determine size used for the nth kmalloc cache.
-- 
2.1.0

