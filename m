Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59529 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750844AbXJQG0h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Oct 2007 02:26:37 -0400
Message-Id: <200710170625.l9H6Penp006295@imap1.linux-foundation.org>
Subject: [patch 003/327] powerpc: add Altivec/VMX state to coredumps
From: akpm@linux-foundation.org
Date: Tue, 16 Oct 2007 23:25:40 -0700
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, markn@au1.ibm.com, ak@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

From: Mark Nelson <markn@au1.ibm.com>

Update dump_task_altivec() (which has so far never been put to use) so that
it dumps the Altivec/VMX registers (VR[0] - VR[31], VSCR and VRSAVE) in the
same format as the ptrace get_vrregs(), and add the appropriate glue
typedef and #defines to make it work.

A new note type of NT_PPC_VMX was chosen to be 0x100 (arbitrarily) because
it allows the low range values to be used for more generic purposes and
0x100 seems an adequate starting point for PowerPC extensions.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/process.c |   28 +++++++++++++++++++++++++---
 include/asm-powerpc/elf.h     |    8 ++++++++
 include/linux/elf.h           |    1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

diff -puN arch/powerpc/kernel/process.c~powerpc-add-altivec-vmx-state-to-coredumps arch/powerpc/kernel/process.c
--- a/arch/powerpc/kernel/process.c~powerpc-add-altivec-vmx-state-to-coredumps
+++ a/arch/powerpc/kernel/process.c
@@ -149,10 +149,32 @@ void flush_altivec_to_thread(struct task
 	}
 }
 
-int dump_task_altivec(struct pt_regs *regs, elf_vrregset_t *vrregs)
+int dump_task_altivec(struct task_struct *tsk, elf_vrregset_t *vrregs)
 {
-	flush_altivec_to_thread(current);
-	memcpy(vrregs, &current->thread.vr[0], sizeof(*vrregs));
+	/* ELF_NVRREG includes the VSCR and VRSAVE which we need to save
+	 * separately, see below */
+	const int nregs = ELF_NVRREG - 2;
+	elf_vrreg_t *reg;
+	u32 *dest;
+
+	if (tsk == current)
+		flush_altivec_to_thread(tsk);
+
+	reg = (elf_vrreg_t *)vrregs;
+
+	/* copy the 32 vr registers */
+	memcpy(reg, &tsk->thread.vr[0], nregs * sizeof(*reg));
+	reg += nregs;
+
+	/* copy the vscr */
+	memcpy(reg, &tsk->thread.vscr, sizeof(*reg));
+	reg++;
+
+	/* vrsave is stored in the high 32bit slot of the final 128bits */
+	memset(reg, 0, sizeof(*reg));
+	dest = (u32 *)reg;
+	*dest = tsk->thread.vrsave;
+
 	return 1;
 }
 #endif /* CONFIG_ALTIVEC */
diff -puN include/asm-powerpc/elf.h~powerpc-add-altivec-vmx-state-to-coredumps include/asm-powerpc/elf.h
--- a/include/asm-powerpc/elf.h~powerpc-add-altivec-vmx-state-to-coredumps
+++ a/include/asm-powerpc/elf.h
@@ -212,6 +212,14 @@ static inline int dump_task_regs(struct 
 extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *); 
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 
+typedef elf_vrregset_t elf_fpxregset_t;
+
+#ifdef CONFIG_ALTIVEC
+extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
+#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
+#define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
+#endif
+
 #endif /* __KERNEL__ */
 
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
diff -puN include/linux/elf.h~powerpc-add-altivec-vmx-state-to-coredumps include/linux/elf.h
--- a/include/linux/elf.h~powerpc-add-altivec-vmx-state-to-coredumps
+++ a/include/linux/elf.h
@@ -355,6 +355,7 @@ typedef struct elf64_shdr {
 #define NT_TASKSTRUCT	4
 #define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
+#define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
 
 
 /* Note header in a PT_NOTE section */
_
