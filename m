Return-Path: <SRS0=2OaM=4Q=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46002 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgB1AW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so713893pfg.12
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:55 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 5/9] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date: Thu, 27 Feb 2020 16:22:40 -0800
Message-ID: <20200228002244.15240-6-keescook@chromium.org>
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <20200228002240.zTanaxAhzPQqznuo9iAbeoHK_qtYNOT_nKIvgz5W8Aw@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

In x86 kernel, .exit.text and .exit.data sections are discarded at
runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
and define it in x86 kernel linker script to keep them.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Link: https://lore.kernel.org/r/20200130224337.4150-1-hjl.tools@gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1e345f302a46..1e12c097d09b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 303597e51396..1797f2c9bb41 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,10 +894,16 @@
  * section definitions so that such archs put those in earlier section
  * definitions.
  */
+#ifdef RUNTIME_DISCARD_EXIT
+#define EXIT_DISCARDS
+#else
+#define EXIT_DISCARDS							\
+	EXIT_TEXT							\
+	EXIT_DATA
+#endif
 #define DISCARDS							\
 	/DISCARD/ : {							\
-	EXIT_TEXT							\
-	EXIT_DATA							\
+	EXIT_DISCARDS							\
 	EXIT_CALL							\
 	*(.discard)							\
 	*(.discard.*)							\
-- 
2.20.1
