From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 15/27] x86: assembly, do not annotate functions by GLOBAL
Date: Thu, 10 May 2018 10:06:32 +0200
Message-ID: <20180510080644.19752-16-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

GLOBAL is meant for global symbols, but not functions. Use the new
macros SYM_FUNC_START* and SYM_CODE_START* (depending on the type of the
function) which are dedicated for global functions. And since they both
require a closing by SYM_*_END, we do this here too.

startup_64, which does not use GLOBAL, but uses .globl explicitly, is
converted too.

in_pm32 should not be global at all as it is used only locally, so
switch to SYM_FUNC_START_LOCAL_NOALIGN.

Besides all of that, x86's custom GLOBAL macro is going to die very
soon.

"No alignments" are preserved.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <x86@kernel.org>
---
 arch/x86/boot/copy.S      | 16 ++++++++--------
 arch/x86/boot/pmjump.S    |  8 ++++----
 arch/x86/kernel/head_64.S |  5 +++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
index 15d9f74b0008..73aa8307a10f 100644
--- a/arch/x86/boot/copy.S
+++ b/arch/x86/boot/copy.S
@@ -17,7 +17,7 @@
 	.code16
 	.text
 
-GLOBAL(memcpy)
+SYM_FUNC_START_NOALIGN(memcpy)
 	pushw	%si
 	pushw	%di
 	movw	%ax, %di
@@ -31,9 +31,9 @@ GLOBAL(memcpy)
 	popw	%di
 	popw	%si
 	retl
-ENDPROC(memcpy)
+SYM_FUNC_END(memcpy)
 
-GLOBAL(memset)
+SYM_FUNC_START_NOALIGN(memset)
 	pushw	%di
 	movw	%ax, %di
 	movzbl	%dl, %eax
@@ -46,22 +46,22 @@ GLOBAL(memset)
 	rep; stosb
 	popw	%di
 	retl
-ENDPROC(memset)
+SYM_FUNC_END(memset)
 
-GLOBAL(copy_from_fs)
+SYM_FUNC_START_NOALIGN(copy_from_fs)
 	pushw	%ds
 	pushw	%fs
 	popw	%ds
 	calll	memcpy
 	popw	%ds
 	retl
-ENDPROC(copy_from_fs)
+SYM_FUNC_END(copy_from_fs)
 
-GLOBAL(copy_to_fs)
+SYM_FUNC_START_NOALIGN(copy_to_fs)
 	pushw	%es
 	pushw	%fs
 	popw	%es
 	calll	memcpy
 	popw	%es
 	retl
-ENDPROC(copy_to_fs)
+SYM_FUNC_END(copy_to_fs)
diff --git a/arch/x86/boot/pmjump.S b/arch/x86/boot/pmjump.S
index 3e0edc6d2a20..b90e42eb1a62 100644
--- a/arch/x86/boot/pmjump.S
+++ b/arch/x86/boot/pmjump.S
@@ -23,7 +23,7 @@
 /*
  * void protected_mode_jump(u32 entrypoint, u32 bootparams);
  */
-GLOBAL(protected_mode_jump)
+SYM_FUNC_START_NOALIGN(protected_mode_jump)
 	movl	%edx, %esi		# Pointer to boot_params table
 
 	xorl	%ebx, %ebx
@@ -44,11 +44,11 @@ GLOBAL(protected_mode_jump)
 	.byte	0x66, 0xea		# ljmpl opcode
 2:	.long	in_pm32			# offset
 	.word	__BOOT_CS		# segment
-ENDPROC(protected_mode_jump)
+SYM_FUNC_END(protected_mode_jump)
 
 	.code32
 	.section ".text32","ax"
-GLOBAL(in_pm32)
+SYM_FUNC_START_LOCAL_NOALIGN(in_pm32)
 	# Set up data segments for flat 32-bit mode
 	movl	%ecx, %ds
 	movl	%ecx, %es
@@ -74,4 +74,4 @@ GLOBAL(in_pm32)
 	lldt	%cx
 
 	jmpl	*%eax			# Jump to the 32-bit entrypoint
-ENDPROC(in_pm32)
+SYM_FUNC_END(in_pm32)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 80b620c824eb..48e71043b99c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -50,8 +50,7 @@ L3_START_KERNEL = pud_index(__START_KERNEL_map)
 	.text
 	__HEAD
 	.code64
-	.globl startup_64
-startup_64:
+SYM_CODE_START_NOALIGN(startup_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
@@ -91,6 +90,8 @@ startup_64:
 	/* Form the CR3 value being sure to include the CR3 modifier */
 	addq	$(early_top_pgt - __START_KERNEL_map), %rax
 	jmp 1f
+SYM_CODE_END(startup_64)
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
-- 
2.16.3
