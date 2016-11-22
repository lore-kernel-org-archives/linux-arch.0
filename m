Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:65346 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932771AbcKVLHM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2016 06:07:12 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ARM: move mmiocpy/mmioset exports to io.c
Date: Tue, 22 Nov 2016 12:05:41 +0100
Message-ID: <20161122110557.1533467-2-arnd@arndb.de>
In-Reply-To: <20161122110557.1533467-1-arnd@arndb.de>
References: <20161122110557.1533467-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@armlinux.org.uk>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Nicolas Pitre <nico@linaro.org>, linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Message-ID: <20161122110541.zGJVKSHyDh2CGB79xt7m7z8BrRVdmWqGMehJqJB9SbM@z>

The prototypes for mmioset/mmiocpy are intentionally hidden
inside of inline functions, which breaks the EXPORT_SYMBOL
statements when symbol versioning is enabled.

This moves the two exports from the files that implement the
code into the kernel/io.c file, adding another local declaration
there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/io.c  | 7 +++++++
 arch/arm/lib/memcpy.S | 1 -
 arch/arm/lib/memset.S | 1 -
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index eedefe050022..c74746997626 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -82,3 +82,10 @@ void _memset_io(volatile void __iomem *dst, int c, size_t count)
 	}
 }
 EXPORT_SYMBOL(_memset_io);
+
+/* can't export them from memcpy.S/memset.S because of hidden declaration */
+void mmioset(void __iomem *addr, unsigned int c, size_t n);
+EXPORT_SYMBOL(mmioset);
+
+void mmiocpy(void *dest, const void __iomem *src, size_t n);
+EXPORT_SYMBOL(mmiocpy);
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index 1be5b6ddf37c..1f822fc52400 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -70,4 +70,3 @@ ENTRY(memcpy)
 ENDPROC(memcpy)
 ENDPROC(mmiocpy)
 EXPORT_SYMBOL(memcpy)
-EXPORT_SYMBOL(mmiocpy)
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 7b72044cba62..6f075ca09abc 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -137,4 +137,3 @@ UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
 EXPORT_SYMBOL(memset)
-EXPORT_SYMBOL(mmioset)
-- 
2.9.0

