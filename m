Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43009 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933203AbXJRBGG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Oct 2007 21:06:06 -0400
Date: Wed, 17 Oct 2007 18:05:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Add missing ELF_CORE_XFPREG_TYPE #define to x86
Message-Id: <20071017180517.0322270d.akpm@linux-foundation.org>
In-Reply-To: <47141A5E.3010000@au1.ibm.com>
References: <200710152019.l9FKJj1M023188@imap1.linux-foundation.org>
	<47141A5E.3010000@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Mark Nelson <markn@au1.ibm.com>
Cc: ak@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

On Tue, 16 Oct 2007 11:56:46 +1000
Mark Nelson <markn@au1.ibm.com> wrote:

> Add two missing #define ELF_CORE_XFPREG_TYPE NT_PRXFPREG to x86
> 
> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
> ---
> Andrew: These two hunks were lost from
> replace-nt_prxfpreg-with-elf_core_xfpreg_type-define.patch because
> of the merger of i386 and x86_64 (and my incredibly bad timing for
> sending this patch). Apologies and thanks.
> 
>  arch/x86/ia32/ia32_binfmt.c |    1 +
>  include/asm-x86/elf_32.h    |    1 +
>  2 files changed, 2 insertions(+)
> 
> Index: linus/arch/x86/ia32/ia32_binfmt.c
> ===================================================================
> --- linus.orig/arch/x86/ia32/ia32_binfmt.c
> +++ linus/arch/x86/ia32/ia32_binfmt.c
> @@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
>  }
>  
>  #define ELF_CORE_COPY_XFPREGS 1
> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>  static inline int 
>  elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
>  {
> Index: linus/include/asm-x86/elf_32.h
> ===================================================================
> --- linus.orig/include/asm-x86/elf_32.h
> +++ linus/include/asm-x86/elf_32.h
> @@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
>  #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
>  #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
>  #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>  
>  #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
>  #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)

I'm not sure what happened here.  My current copy of
replace-nt_prxfpreg-with-elf_core_xfpreg_type-define.patch has the above
changes in it, and the commit which went into mainline this morning looks
to be OK.

