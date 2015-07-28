Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35326 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbbG1OdA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jul 2015 10:33:00 -0400
From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 1/2] mm: add utility for early copy from unmapped ram
Date: Tue, 28 Jul 2015 10:32:40 -0400
Message-ID: <1438093961-15536-2-git-send-email-msalter@redhat.com>
In-Reply-To: <1438093961-15536-1-git-send-email-msalter@redhat.com>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "Arnd Bergmann <arnd@arndb.de>--cc=Ard Biesheuvel" <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>
Message-ID: <20150728143240.hbEKAcnvlqf1TPhbNCS0cKoPAv1V7v4Q2S9ws2qX-tE@z>

In some early boot circumstances, it may be necessary to copy
from RAM outside the kernel linear mapping to mapped RAM. The
need to relocate an initrd is one example in the x86 code. This
patch creates a helper function based on current x86 code.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/early_ioremap.h |  6 ++++++
 mm/early_ioremap.c                  | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index a5de55c..e539f27 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -33,6 +33,12 @@ extern void early_ioremap_setup(void);
  */
 extern void early_ioremap_reset(void);
 
+/*
+ * Early copy from unmapped memory to kernel mapped memory.
+ */
+extern void copy_from_early_mem(void *dest, phys_addr_t src,
+				unsigned long size);
+
 #else
 static inline void early_ioremap_init(void) { }
 static inline void early_ioremap_setup(void) { }
diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index e10ccd2..acba804 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -217,6 +217,28 @@ early_memremap(resource_size_t phys_addr, unsigned long size)
 	return (__force void *)__early_ioremap(phys_addr, size,
 					       FIXMAP_PAGE_NORMAL);
 }
+
+#define MAX_MAP_CHUNK	(NR_FIX_BTMAPS << PAGE_SHIFT)
+
+void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
+{
+	unsigned long slop, clen;
+	char *p;
+
+	while (size) {
+		slop = src & ~PAGE_MASK;
+		clen = size;
+		if (clen > MAX_MAP_CHUNK - slop)
+			clen = MAX_MAP_CHUNK - slop;
+		p = early_memremap(src & PAGE_MASK, clen + slop);
+		memcpy(dest, p + slop, clen);
+		early_iounmap(p, clen + slop);
+		dest += clen;
+		src += clen;
+		size -= clen;
+	}
+}
+
 #else /* CONFIG_MMU */
 
 void __init __iomem *
-- 
2.4.3

