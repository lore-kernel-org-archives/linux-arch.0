Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:52396 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885AbXJPB5W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2007 21:57:22 -0400
Message-ID: <47141A5E.3010000@au1.ibm.com>
Date: Tue, 16 Oct 2007 11:56:46 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
Subject: Add missing ELF_CORE_XFPREG_TYPE #define to x86
References: <200710152019.l9FKJj1M023188@imap1.linux-foundation.org>
In-Reply-To: <200710152019.l9FKJj1M023188@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, ak@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

Add two missing #define ELF_CORE_XFPREG_TYPE NT_PRXFPREG to x86

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
Andrew: These two hunks were lost from
replace-nt_prxfpreg-with-elf_core_xfpreg_type-define.patch because
of the merger of i386 and x86_64 (and my incredibly bad timing for
sending this patch). Apologies and thanks.

 arch/x86/ia32/ia32_binfmt.c |    1 +
 include/asm-x86/elf_32.h    |    1 +
 2 files changed, 2 insertions(+)

Index: linus/arch/x86/ia32/ia32_binfmt.c
===================================================================
--- linus.orig/arch/x86/ia32/ia32_binfmt.c
+++ linus/arch/x86/ia32/ia32_binfmt.c
@@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
 }
 
 #define ELF_CORE_COPY_XFPREGS 1
+#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
 static inline int 
 elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
 {
Index: linus/include/asm-x86/elf_32.h
===================================================================
--- linus.orig/include/asm-x86/elf_32.h
+++ linus/include/asm-x86/elf_32.h
@@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
 #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
 #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
 #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
+#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
 
 #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
 #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
