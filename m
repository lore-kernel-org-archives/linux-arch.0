From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 1/2] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date: Thu, 26 Mar 2020 12:30:20 -0700
Message-ID: <20200326193021.255002-1-hjl.tools@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19991 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgCZTaX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 15:30:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Sami Tolvanen <samitolvanen@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>

In x86 kernel, .exit.text and .exit.data sections are discarded at
runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
and define it in x86 kernel linker script to keep them.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa028fe..7206e1ac23dd 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..6b943fb8c5fd 100644
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
2.25.1
