Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f202.google.com ([209.85.216.202]:53298 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbeFYWmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2018 18:42:44 -0400
Received: by mail-qt0-f202.google.com with SMTP id x16-v6so14506771qto.20
        for <linux-arch@vger.kernel.org>; Mon, 25 Jun 2018 15:42:44 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jun 2018 15:39:12 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-ID: <20180625224014.134829-25-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
Subject: [PATCH v5 24/27] x86/mm: Make the x86 GOT read-only
From: Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kernel-hardening@lists.openwall.com
Cc: Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180625223912.lPx-awB6Eirb_3zYEjO3s7sWj699DRBMwhM3FnB-KW0@z>

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e373e2e10f6a..e5b0710fe693 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -314,6 +314,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		VMLINUX_SYMBOL(__start_got) = .;			\
+		*(.got);						\
+		VMLINUX_SYMBOL(__end_got) = .;				\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * Read only Data
  */
@@ -370,6 +381,7 @@
 		__end_builtin_fw = .;					\
 	}								\
 									\
+	RO_GOT_X86							\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
-- 
2.18.0.rc2.346.g013aa6912e-goog
