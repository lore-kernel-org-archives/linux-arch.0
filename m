From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mmotm] mm: unify some pmd_*() functions fix for m68k sun3
Date: Thu, 29 Jan 2009 22:58:17 +0100
Message-ID: <1233266297-12995-1-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:45680 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbZA2V6Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jan 2009 16:58:24 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Andrea Righi <righi.andrea@gmail.com>

sun3_defconfig fails with:

    CC      mm/memory.o
  mm/memory.c: In function 'free_pmd_range':
  mm/memory.c:176: error: implicit declaration of function '__pmd_free_tlb'
  mm/memory.c: In function '__pmd_alloc':
  mm/memory.c:2903: error: implicit declaration of function 'pmd_alloc_one_bug'
  mm/memory.c:2903: warning: initialization makes pointer from integer without a cast
  mm/memory.c:2917: error: implicit declaration of function 'pmd_free'
  make[3]: *** [mm/memory.o] Error 1

Add the missing include.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 include/asm-m68k/sun3_pgalloc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-m68k/sun3_pgalloc.h b/include/asm-m68k/sun3_pgalloc.h
index 0fe28fc..399d280 100644
--- a/include/asm-m68k/sun3_pgalloc.h
+++ b/include/asm-m68k/sun3_pgalloc.h
@@ -11,6 +11,7 @@
 #define _SUN3_PGALLOC_H
 
 #include <asm/tlb.h>
+#include <asm-generic/pgtable-nopmd.h>
 
 /* FIXME - when we get this compiling */
 /* erm, now that it's compiling, what do we do with it? */
-- 
1.5.6.3
