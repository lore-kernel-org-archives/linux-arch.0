From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 2/6] ARM: Use update_thread_flag()
Date: Thu, 19 Apr 2018 11:58:44 +0100
Message-ID: <1524135528-28561-3-git-send-email-Dave.Martin@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

This patch uses the new update_thread_flag() helper to simplify an
if () set; else clear; construct.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/elf.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 1824229..aade393 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -68,12 +68,9 @@ void elf_set_personality(const struct elf32_hdr *x)
 	 * binary is EABI or softfloat (and thus, guaranteed not to use
 	 * FPA instructions.)
 	 */
-	if (elf_hwcap & HWCAP_IWMMXT &&
-	    eflags & (EF_ARM_EABI_MASK | EF_ARM_SOFT_FLOAT)) {
-		set_thread_flag(TIF_USING_IWMMXT);
-	} else {
-		clear_thread_flag(TIF_USING_IWMMXT);
-	}
+	update_thread_flag(TIF_USING_IWMMXT,
+			   elf_hwcap & HWCAP_IWMMXT &&
+			   eflags & (EF_ARM_EABI_MASK | EF_ARM_SOFT_FLOAT));
 }
 EXPORT_SYMBOL(elf_set_personality);
 
-- 
2.1.4
