From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 18/27] x86: assembly, remove GLOBAL macro
Date: Thu, 30 Nov 2017 15:46:44 +0100
Message-ID: <20171130144653.23688-19-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48265 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbdK3OrE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 09:47:04 -0500
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Convert the remaining 32bit users and remove GLOBAL macro finally. In
particular, this means to use SYM_ENTRY for the singlestepping hack
region.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/entry_32.S      | 4 ++--
 arch/x86/include/asm/linkage.h | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b99e552f932a..4cef47b8027f 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -346,7 +346,7 @@ ENTRY(resume_kernel)
 END(resume_kernel)
 #endif
 
-GLOBAL(__begin_SYSENTER_singlestep_region)
+SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 /*
  * All code from here through __end_SYSENTER_singlestep_region is subject
  * to being single-stepped if a user program sets TF and executes SYSENTER.
@@ -485,7 +485,7 @@ ENTRY(entry_SYSENTER_32)
 	pushl	$X86_EFLAGS_FIXED
 	popfl
 	jmp	.Lsysenter_flags_fixed
-GLOBAL(__end_SYSENTER_singlestep_region)
+SYM_ENTRY(__end_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 ENDPROC(entry_SYSENTER_32)
 
 /*
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 3c22e5a41ba4..365111789cc6 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,14 +13,6 @@
 
 #ifdef __ASSEMBLY__
 
-/*
- * GLOBAL is DEPRECATED
- *
- * use SYM_DATA_START, SYM_FUNC_START, SYM_FUNC_INNER_LABEL, SYM_CODE_START, or
- * similar
- */
-#define GLOBAL(name)	SYM_ENTRY(name, SYM_L_GLOBAL, SYM_A_NONE)
-
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
 #define __ALIGN		.p2align 4, 0x90
 #define __ALIGN_STR	__stringify(__ALIGN)
-- 
2.15.0
