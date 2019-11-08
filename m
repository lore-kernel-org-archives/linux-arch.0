Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:25269 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKHMl7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 07:41:59 -0500
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline function
Date: Fri,  8 Nov 2019 21:41:33 +0900
Message-ID: <20191108124133.31751-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20191108124133.eZfFvnziZIg4fttQeyEanmP-nrpFkMbxG-zLQlWwJD0@z>

I just stopped by the ugly variable name, ________addr.
(8 underscores!)

If this is just a matter of casting to (unsigned long), this variable
is unneeded since you can do like this:

({                                                                      \
        __set_fixmap(idx, phys, flags);                                 \
        (unsigned long)(fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1))); \
})

However, I'd rather like to change it to an inline function since it
is more readable, and the parameter types are clearer.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/fixmap.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 8cc7b09c1bc7..de4c36912529 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -70,14 +70,14 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 	__set_fixmap(idx, 0, FIXMAP_PAGE_CLEAR)
 #endif
 
-/* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)				\
-({									\
-	unsigned long ________addr;					\
-	__set_fixmap(idx, phys, flags);					\
-	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
-	________addr;							\
-})
+/* Return a virtual address with offset calculated */
+static inline unsigned long __set_fixmap_offset(enum fixed_addresses idx,
+						phys_addr_t phys,
+						pgprot_t flags)
+{
+	__set_fixmap(idx, phys, flags);
+	return fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));
+}
 
 #define set_fixmap_offset(idx, phys) \
 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
-- 
2.17.1
