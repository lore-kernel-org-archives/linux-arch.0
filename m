Return-Path: <tglx@linutronix.de>
Message-ID: <20191023123117.871608831@linutronix.de>
Date: Wed, 23 Oct 2019 14:27:08 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 03/17] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
References: <20191023122705.198339581@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023122708.-_6Uh_2lR47oqwzeyvxKZ20yLL9Hum2dnYAHLWxw1SA@z>

That function returns immediately after conditionally reenabling interrupts which
is more than pointless and requires the ASM code to disable interrupts again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -871,7 +871,6 @@ do_simd_coprocessor_error(struct pt_regs
 dotraplinkage void
 do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
 {
-	cond_local_irq_enable(regs);
 }
 
 dotraplinkage void
