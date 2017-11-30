Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48181 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753096AbdK3OrF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 09:47:05 -0500
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 27/27] x86: assembly, replace WEAK uses
Date: Thu, 30 Nov 2017 15:46:53 +0100
Message-ID: <20171130144653.23688-28-jslaby@suse.cz>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20171130144653.QcM5yqAwZnJe9QMf2b9Eq5p1UfGU8VzB93EftDQ-5do@z>

Use the new SYM_CODE_INNER_LABEL for WEAK entries in the middle of x86
assembly functions.

And make sure WEAK is not defined for x86 anymore as these were the last
users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 2 +-
 arch/x86/kernel/ftrace_64.S | 2 +-
 arch/x86/kernel/head_32.S   | 2 +-
 include/linux/linkage.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index c8c9b0721709..c57a31d0ac2d 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -97,7 +97,7 @@ ftrace_graph_call:
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_CODE_INNER_LABEL(ftrace_stub, SYM_L_WEAK)
 	ret
 SYM_CODE_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 33e95d785295..64eeb6669054 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -182,7 +182,7 @@ SYM_CODE_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_CODE_INNER_LABEL(ftrace_stub, SYM_L_WEAK)
 	retq
 SYM_CODE_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 629fea9c7794..03718510b53a 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -156,7 +156,7 @@ SYM_CODE_START(startup_32)
 	jmp *%eax
 
 .Lbad_subarch:
-WEAK(xen_entry)
+SYM_CODE_INNER_LABEL(xen_entry, SYM_L_WEAK)
 	/* Unknown implementation; there's really
 	   nothing we can do at this point. */
 	ud2a
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index dc86fd8d4071..20087d252072 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -114,13 +114,13 @@
 #endif /* CONFIG_X86 */
 #endif /* LINKER_SCRIPT */
 
+#ifndef CONFIG_X86
 #ifndef WEAK
 /* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
 	SYM_FUNC_START_WEAK_NOALIGN(name)
 #endif
 
-#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
-- 
2.15.0
