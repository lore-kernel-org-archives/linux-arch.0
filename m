Return-Path: <tglx@linutronix.de>
Message-ID: <20191023123118.296135499@linutronix.de>
Date: Wed, 23 Oct 2019 14:27:12 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023122712.Zmh19CSj6wBeIJn7MPgpP8lZESUqGFhp7gdFATymKC0@z>

Now that the trap handlers return with interrupts disabled, the
unconditional disabling of interrupts in the low level entry code can be
removed along with the trace calls.

Add debug checks where appropriate.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -595,8 +595,7 @@ END(common_spurious)
 	call	do_IRQ	/* rdi points to pt_regs */
 	/* 0(%rsp): old RSP */
 ret_from_intr:
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
 
 	LEAVE_IRQ_STACK
 
@@ -1252,8 +1251,7 @@ END(paranoid_entry)
  */
 ENTRY(paranoid_exit)
 	UNWIND_HINT_REGS
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF_DEBUG
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	.Lparanoid_exit_no_swapgs
 	TRACE_IRQS_IRETQ
@@ -1356,8 +1354,7 @@ END(error_entry)
 
 ENTRY(error_exit)
 	UNWIND_HINT_REGS
-	DISABLE_INTERRUPTS(CLBR_ANY)
-	TRACE_IRQS_OFF
+	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
 	jz	retint_kernel
 	jmp	retint_user
