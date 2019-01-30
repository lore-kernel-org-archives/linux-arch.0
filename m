From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Date: Wed, 30 Jan 2019 13:46:48 +0100
Message-ID: <20190130124711.12463-6-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
marked as aligned, use NOALIGN.

The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
and SYM_CODE_END too.

The result:
 Value  Size Type    Bind   Vis      Ndx Name
  0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
  001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
  0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
  0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
  0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/entry/thunk_32.S | 4 ++--
 arch/x86/entry/thunk_64.S | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index fee6bc79b987..422354b204f4 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -10,8 +10,7 @@
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
-	.globl \name
-\name:
+SYM_CODE_START_NOALIGN(\name)
 	pushl %eax
 	pushl %ecx
 	pushl %edx
@@ -27,6 +26,7 @@
 	popl %eax
 	ret
 	_ASM_NOKPROBE(\name)
+SYM_CODE_END(\name)
 	.endm
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index be36bf4e0957..60e16aded4b9 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -12,9 +12,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
-	.globl \name
-	.type \name, @function
-\name:
+SYM_FUNC_START_NOALIGN(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -36,6 +34,7 @@
 	call \func
 	jmp  .L_restore
 	_ASM_NOKPROBE(\name)
+SYM_FUNC_END(\name)
 	.endm
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -57,7 +56,7 @@
 #if defined(CONFIG_TRACE_IRQFLAGS) \
  || defined(CONFIG_DEBUG_LOCK_ALLOC) \
  || defined(CONFIG_PREEMPT)
-.L_restore:
+SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -70,4 +69,5 @@
 	popq %rbp
 	ret
 	_ASM_NOKPROBE(.L_restore)
+SYM_CODE_END(.L_restore)
 #endif
-- 
2.20.1
