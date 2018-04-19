From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 6/6] sparc: Use update_thread_flag()
Date: Thu, 19 Apr 2018 11:58:48 +0100
Message-ID: <1524135528-28561-7-git-send-email-Dave.Martin@arm.com>
References: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524135528-28561-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This patch uses the new update_thread_flag() helper to simplify an
if () set; else clear; construct.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/elf_64.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 7e078bc..f1ef89c 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -202,10 +202,7 @@ extern unsigned long sparc64_elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #define SET_PERSONALITY(ex)				\
-do {	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
-		set_thread_flag(TIF_32BIT);		\
-	else						\
-		clear_thread_flag(TIF_32BIT);		\
+do {	update_thread_flag(TIF_32BIT, (ex).e_ident[EI_CLASS] == ELFCLASS32); \
 	/* flush_thread will update pgd cache */	\
 	if (personality(current->personality) != PER_LINUX32)	\
 		set_personality(PER_LINUX |		\
-- 
2.1.4
