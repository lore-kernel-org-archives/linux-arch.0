Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42529 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfAaT32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Jan 2019 14:29:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so1917240plp.9
        for <linux-arch@vger.kernel.org>; Thu, 31 Jan 2019 11:29:28 -0800 (PST)
From: Thomas Garnier <thgarnie@chromium.org>
Subject: [PATCH v6 24/27] x86/mm: Make the x86 GOT read-only
Date: Thu, 31 Jan 2019 11:24:31 -0800
Message-ID: <20190131192533.34130-25-thgarnie@chromium.org>
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190131192431.exGZL9F4UX_S98UVA-2fWw2VYveSkF1eBuzvWhTuzs4@z>

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3d7a6a9c2370..0a038594c878 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -323,6 +323,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		__start_got = .;					\
+		*(.got);						\
+		__end_got = .;						\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * Read only Data
  */
@@ -379,6 +390,7 @@
 		__end_builtin_fw = .;					\
 	}								\
 									\
+	RO_GOT_X86							\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.20.1.495.gaa96b0ce6b-goog
