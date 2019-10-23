Return-Path: <tglx@linutronix.de>
Message-ID: <20191023123117.779277679@linutronix.de>
Date: Wed, 23 Oct 2019 14:27:07 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 02/17] x86/entry/64: Remove pointless jump in paranoid_exit
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023122707.5axZKyS1fPOQmS8utKkequ8L-JFlzHqeKGK-SnBdOlI@z>

Jump directly to restore_regs_and_return_to_kernel instead of making
a pointless extra jump through .Lparanoid_exit_restore

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1272,12 +1272,11 @@ ENTRY(paranoid_exit)
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 	SWAPGS_UNSAFE_STACK
-	jmp	.Lparanoid_exit_restore
+	jmp	restore_regs_and_return_to_kernel
 .Lparanoid_exit_no_swapgs:
 	TRACE_IRQS_IRETQ_DEBUG
 	/* Always restore stashed CR3 value (see paranoid_entry) */
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
-.Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
 END(paranoid_exit)
 
