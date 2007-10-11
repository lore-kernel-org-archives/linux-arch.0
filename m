Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:45689 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbXJKJ5h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Oct 2007 05:57:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18189.62344.506571.3287@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 19:57:28 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: [patch 1/2] Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE #define
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, markn@au1.ibm.com
List-ID: <linux-arch.vger.kernel.org>

From: Mark Nelson <markn@au1.ibm.com>

Replace NT_PRXFPREG with ELF_CORE_XFPREG_TYPE in the coredump code which
allows for more flexibility in the note type for the state of 'extended
floating point' implementations in coredumps.  New note types can now be
added with an appropriate #define.

This does #define ELF_CORE_XFPREG_TYPE to be NT_PRXFPREG in all
current users so there's are no change in behaviour.

This will let us use different note types on powerpc for the
Altivec/VMX state that some PowerPC cpus have (G4, PPC970, POWER6) and
for the SPE (signal processing extension) state that some embedded
PowerPC cpus from Freescale have.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Andrew: if you ack this I can push it through my tree along with the
following patch that adds Altivec/VMX state to core dumps. -- Paul.

 arch/ia64/ia32/elfcore32.h     |    1 +
 arch/x86_64/ia32/ia32_binfmt.c |    1 +
 fs/binfmt_elf.c                |    4 ++--
 include/asm-i386/elf.h         |    1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

Index: linux/arch/ia64/ia32/elfcore32.h
===================================================================
--- linux.orig/arch/ia64/ia32/elfcore32.h
+++ linux/arch/ia64/ia32/elfcore32.h
@@ -117,6 +117,7 @@ elf_core_copy_task_fpregs(struct task_st
 }
 
 #define ELF_CORE_COPY_XFPREGS 1
+#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
 static inline int
 elf_core_copy_task_xfpregs(struct task_struct *tsk, elf_fpxregset_t *xfpu)
 {
Index: linux/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32_binfmt.c
+++ linux/arch/x86_64/ia32/ia32_binfmt.c
@@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
 }
 
 #define ELF_CORE_COPY_XFPREGS 1
+#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
 static inline int 
 elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
 {
Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c
+++ linux/fs/binfmt_elf.c
@@ -1446,8 +1446,8 @@ static int elf_dump_thread_status(long s
 
 #ifdef ELF_CORE_COPY_XFPREGS
 	if (elf_core_copy_task_xfpregs(p, &t->xfpu)) {
-		fill_note(&t->notes[2], "LINUX", NT_PRXFPREG, sizeof(t->xfpu),
-			  &t->xfpu);
+		fill_note(&t->notes[2], "LINUX", ELF_CORE_XFPREG_TYPE,
+			  sizeof(t->xfpu), &t->xfpu);
 		t->num_notes++;
 		sz += notesize(&t->notes[2]);
 	}
Index: linux/include/asm-i386/elf.h
===================================================================
--- linux.orig/include/asm-i386/elf.h
+++ linux/include/asm-i386/elf.h
@@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
 
 #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
 #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
