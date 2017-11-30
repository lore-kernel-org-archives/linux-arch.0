From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 07/27] x86: boot, annotate local functions
Date: Thu, 30 Nov 2017 15:46:33 +0100
Message-ID: <20171130144653.23688-8-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

relocated and no_longmode are self-standing local functions, annotate
them as such.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 37380c0d5999..7e8ab0bb6968 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -209,7 +209,7 @@ ENDPROC(efi32_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -260,6 +260,7 @@ relocated:
  */
 	xorl	%ebx, %ebx
 	jmp	*%eax
+SYM_FUNC_END(relocated)
 
 #ifdef CONFIG_EFI_STUB
 	.data
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 20919b4f3133..7dcbe1ccc0b2 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -438,7 +438,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -480,6 +480,7 @@ relocated:
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(relocated)
 
 	.code32
 #ifdef CONFIG_X86_5LEVEL
@@ -520,11 +521,12 @@ compatible_mode:
 	lret
 #endif
 
-no_longmode:
+SYM_FUNC_START_LOCAL(no_longmode)
 	/* This isn't an x86-64 CPU so hang */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(no_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
-- 
2.15.0
