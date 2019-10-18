Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-04.nifty.com ([202.248.20.69]:50603 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389158AbfJRE4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 00:56:40 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] asm-generic/export.h: remove unneeded __kcrctab_* symbols
Date: Fri, 18 Oct 2019 13:31:48 +0900
Message-ID: <20191018043148.6285-2-yamada.masahiro@socionext.com>
In-Reply-To: <20191018043148.6285-1-yamada.masahiro@socionext.com>
References: <20191018043148.6285-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20191018043148.eKxFV6ZcfLkt9hGBHcJCiWYKllqJT1cS5wvfzWvolO8@z>

EXPORT_SYMBOL from assembly code produces an unused symbol __kcrctab_*.

kcrctab is used as a section name (prefixed with three underscores),
but never used as a symbol.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 80ef2dc0c8be..a3983e2ce0fd 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -43,7 +43,6 @@ __kstrtab_\name:
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-__kcrctab_\name:
 #if defined(CONFIG_MODULE_REL_CRCS)
 	.long __crc_\name - .
 #else
-- 
2.17.1
