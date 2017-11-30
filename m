From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 14/27] x86: purgatory, start using annotations
Date: Thu, 30 Nov 2017 15:46:40 +0100
Message-ID: <20171130144653.23688-15-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

purgatory used no annotations. So include linux/linkage.h and annotate
everything:
* code by SYM_CODE_*
* data by SYM_DATA_*

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/purgatory/entry64.S      | 21 ++++++++++++---------
 arch/x86/purgatory/setup-x86_64.S | 14 ++++++++------
 arch/x86/purgatory/stack.S        |  7 ++++---
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index d1a4291d3568..c51e3c999e38 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -10,13 +10,13 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/linkage.h>
+
 	.text
 	.balign 16
 	.code64
-	.globl entry64, entry64_regs
-
 
-entry64:
+SYM_CODE_START(entry64)
 	/* Setup a gdt that should be preserved */
 	lgdt gdt(%rip)
 
@@ -56,10 +56,11 @@ new_cs_exit:
 
 	/* Jump to the new code... */
 	jmpq	*rip(%rip)
+SYM_CODE_END(entry64)
 
 	.section ".rodata"
 	.balign 4
-entry64_regs:
+SYM_DATA_START(entry64_regs)
 rax:	.quad 0x0
 rcx:	.quad 0x0
 rdx:	.quad 0x0
@@ -77,12 +78,12 @@ r13:	.quad 0x0
 r14:	.quad 0x0
 r15:	.quad 0x0
 rip:	.quad 0x0
-	.size entry64_regs, . - entry64_regs
+SYM_DATA_END(entry64_regs)
 
 	/* GDT */
 	.section ".rodata"
 	.balign 16
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as gdt ptr
@@ -96,6 +97,8 @@ gdt:
 
 	/* 0x18 4GB flat data segment */
 	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
-stack:	.quad   0, 0
-stack_init:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
+
+SYM_DATA_START_LOCAL(stack)
+	.quad   0, 0
+SYM_DATA_END_LABEL(stack, SYM_L_LOCAL, stack_init)
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index dfae9b9e60b5..f0de104d3f3a 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -9,14 +9,14 @@
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
+#include <linux/linkage.h>
 #include <asm/purgatory.h>
 
 	.text
-	.globl purgatory_start
 	.balign 16
-purgatory_start:
 	.code64
 
+SYM_CODE_START(purgatory_start)
 	/* Load a gdt so I know what the segment registers are */
 	lgdt	gdt(%rip)
 
@@ -34,10 +34,12 @@ purgatory_start:
 	/* Call the C code */
 	call purgatory
 	jmp	entry64
+SYM_CODE_END(purgatory_start)
 
 	.section ".rodata"
 	.balign 16
-gdt:	/* 0x00 unusable segment
+SYM_DATA_START_LOCAL(gdt)
+	/* 0x00 unusable segment
 	 * 0x08 unused
 	 * so use them as the gdt ptr
 	 */
@@ -50,10 +52,10 @@ gdt:	/* 0x00 unusable segment
 
 	/* 0x18 4GB flat data segment */
 	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 	.bss
 	.balign 4096
-lstack:
+SYM_DATA_START_LOCAL(lstack)
 	.skip 4096
-lstack_end:
+SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
index 50a4147f91fb..987e6510a960 100644
--- a/arch/x86/purgatory/stack.S
+++ b/arch/x86/purgatory/stack.S
@@ -7,13 +7,14 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <linux/linkage.h>
+
 	/* A stack for the loaded kernel.
 	 * Separate and in the data section so it can be prepopulated.
 	 */
 	.data
 	.balign 4096
-	.globl stack, stack_end
 
-stack:
+SYM_DATA_START(stack)
 	.skip 4096
-stack_end:
+SYM_DATA_END_LABEL(stack, SYM_L_GLOBAL, stack_end)
-- 
2.15.0
