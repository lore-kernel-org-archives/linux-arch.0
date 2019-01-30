From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 08/28] x86/boot/compressed: annotate local functions
Date: Wed, 30 Jan 2019 13:46:51 +0100
Message-ID: <20190130124711.12463-9-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

relocated, paging_enabled, and no_longmode are self-standing local
functions, annotate them as such. paging_enabled is annotated as
NOALIGN, since the trampoline code has to be compact.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/head_32.S | 3 ++-
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

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
index 64037895b085..b840618edd58 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -508,7 +508,7 @@ ENDPROC(efi64_stub_entry)
 #endif
 
 	.text
-relocated:
+SYM_FUNC_START_LOCAL(relocated)
 
 /*
  * Clear BSS (stack is currently empty)
@@ -537,6 +537,7 @@ relocated:
  * Jump to the decompressed kernel.
  */
 	jmp	*%rax
+SYM_FUNC_END(relocated)
 
 /*
  * Adjust the global offset table
@@ -622,9 +623,10 @@ ENTRY(trampoline_32bit_src)
 	lret
 
 	.code64
-paging_enabled:
+SYM_FUNC_START_LOCAL_NOALIGN(paging_enabled)
 	/* Return from the trampoline */
 	jmp	*%rdi
+SYM_FUNC_END(paging_enabled)
 
 	/*
          * The trampoline code has a size limit.
@@ -634,11 +636,12 @@ paging_enabled:
 	.org	trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_SIZE
 
 	.code32
-no_longmode:
+SYM_FUNC_START_LOCAL(no_longmode)
 	/* This isn't an x86-64 CPU, so hang intentionally, we cannot continue */
 1:
 	hlt
 	jmp     1b
+SYM_FUNC_END(no_longmode)
 
 #include "../../kernel/verify_cpu.S"
 
-- 
2.20.1
