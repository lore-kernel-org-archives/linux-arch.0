Return-Path: <tglx@linutronix.de>
Message-ID: <20191023123117.686514045@linutronix.de>
Date: Wed, 23 Oct 2019 14:27:06 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 01/17] x86/entry/32: Remove unused resume_userspace label
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023122706.9oUF4yVABYh83ysDVKjGe_K--2pC0wwsREOw_r0JocQ@z>

The C reimplementation of SYSENTER left that unused ENTRY() label
around. Remove it.

Fixes: 5f310f739b4c ("x86/entry/32: Re-implement SYSENTER using the new C path")
Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -825,7 +825,6 @@ END(ret_from_fork)
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
