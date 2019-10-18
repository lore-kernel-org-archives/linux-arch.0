Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-05.nifty.com ([202.248.20.70]:41036 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391456AbfJRFDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 01:03:12 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] asm-generic/export.h: make __ksymtab_* local symbols
Date: Fri, 18 Oct 2019 13:31:47 +0900
Message-ID: <20191018043148.6285-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20191018043147.PS3gV5eyhy9BHGtOlfA70skRmTbaLRGIlnjh_WcZ2D0@z>

For EXPORT_SYMBOL from C files, <linux/export.h> defines __ksymtab_*
as local symbols.

For EXPORT_SYMBOL from assembly, in contrast, <asm-generic/export.h>
produces globally-visible __ksymtab_* symbols due to this .globl
directive.

I do not understand why this must be global.  It still works without
this .globl directive.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index fa577978fbbd..80ef2dc0c8be 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -31,7 +31,6 @@
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl __ksymtab_\name
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
 __ksymtab_\name:
-- 
2.17.1
