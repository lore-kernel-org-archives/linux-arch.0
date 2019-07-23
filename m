Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42136 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbfGWUuW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jul 2019 16:50:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so32120248qkm.9
        for <linux-arch@vger.kernel.org>; Tue, 23 Jul 2019 13:50:22 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date: Tue, 23 Jul 2019 16:49:46 -0400
Message-ID: <1563914986-26502-1-git-send-email-cai@lca.pw>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com, jakub@redhat.com, ndesaulniers@google.com, morbo@google.com, jyknight@google.com, natechancellor@gmail.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Message-ID: <20190723204946.AG33wxUxu-tMH5Ul8YNrWyS4P5w1HCQEUjdc9n1jmaI@z>

The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
compilation warning because "rx_frag_size" is an "ushort" while
PAGE_SHIFT here is 16. The commit changed the get_order() to be a
multi-line macro where compilers insist to check all statements in the
macro even when __builtin_constant_p(rx_frag_size) will return false as
"rx_frag_size" is a module parameter.

In file included from ./arch/powerpc/include/asm/page_64.h:107,
                 from ./arch/powerpc/include/asm/page.h:242,
                 from ./arch/powerpc/include/asm/mmu.h:132,
                 from ./arch/powerpc/include/asm/lppaca.h:47,
                 from ./arch/powerpc/include/asm/paca.h:17,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./arch/powerpc/include/asm/processor.h:39,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
drivers/net/ethernet/emulex/benet/be_main.c: In function
'be_rx_cqs_create':
./include/asm-generic/getorder.h:54:9: warning: comparison is always
true due to limited range of data type [-Wtype-limits]
   (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
         ^
drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
of macro 'get_order'
  adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
                                 ^~~~~~~~~

Fix it by moving almost all of this multi-line macro into a proper
function __get_order(), and leave get_order() as a single-line macro in
order to avoid compilation errors.

Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/getorder.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index c64bea7a52be..c6a6d3cd7007 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -15,6 +15,16 @@ int __get_order(unsigned long size)
 {
 	int order;
 
+	if (__builtin_constant_p(size)) {
+		if (!size)
+			return BITS_PER_LONG - PAGE_SHIFT;
+
+		if (size < (1UL << PAGE_SHIFT))
+			return 0;
+
+		return ilog2((size) - 1) - PAGE_SHIFT + 1;
+	}
+
 	size--;
 	size >>= PAGE_SHIFT;
 #if BITS_PER_LONG == 32
@@ -49,11 +59,6 @@ int __get_order(unsigned long size)
  */
 #define get_order(n)						\
 (								\
-	__builtin_constant_p(n) ? (				\
-		((n) == 0UL) ? BITS_PER_LONG - PAGE_SHIFT :	\
-		(((n) < (1UL << PAGE_SHIFT)) ? 0 :		\
-		 ilog2((n) - 1) - PAGE_SHIFT + 1)		\
-	) :							\
 	__get_order(n)						\
 )
 
-- 
1.8.3.1
