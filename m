Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from E23SMTP04.au.ibm.com ([202.81.18.173]:56372 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXJRECY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Oct 2007 00:02:24 -0400
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9I42KWj021737
	for <linux-arch@vger.kernel.org>; Thu, 18 Oct 2007 14:02:20 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l9I45uWY167010
	for <linux-arch@vger.kernel.org>; Thu, 18 Oct 2007 14:05:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l9I3xTk2001109
	for <linux-arch@vger.kernel.org>; Thu, 18 Oct 2007 13:59:29 +1000
Message-ID: <4716DAB2.8090305@au1.ibm.com>
Date: Thu, 18 Oct 2007 14:01:54 +1000
From: Mark Nelson <markn@au1.ibm.com>
MIME-Version: 1.0
Subject: Re: Add missing ELF_CORE_XFPREG_TYPE #define to x86
References: <200710152019.l9FKJj1M023188@imap1.linux-foundation.org>	<47141A5E.3010000@au1.ibm.com> <20071017180517.0322270d.akpm@linux-foundation.org>
In-Reply-To: <20071017180517.0322270d.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ak@suse.de, linux-arch@vger.kernel.org, mingo@elte.hu, paulus@samba.org, tglx@linutronix.de
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:
> On Tue, 16 Oct 2007 11:56:46 +1000
> Mark Nelson <markn@au1.ibm.com> wrote:
> 
>> Add two missing #define ELF_CORE_XFPREG_TYPE NT_PRXFPREG to x86
>>
>> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
>> ---
>> Andrew: These two hunks were lost from
>> replace-nt_prxfpreg-with-elf_core_xfpreg_type-define.patch because
>> of the merger of i386 and x86_64 (and my incredibly bad timing for
>> sending this patch). Apologies and thanks.
>>
>>  arch/x86/ia32/ia32_binfmt.c |    1 +
>>  include/asm-x86/elf_32.h    |    1 +
>>  2 files changed, 2 insertions(+)
>>
>> Index: linus/arch/x86/ia32/ia32_binfmt.c
>> ===================================================================
>> --- linus.orig/arch/x86/ia32/ia32_binfmt.c
>> +++ linus/arch/x86/ia32/ia32_binfmt.c
>> @@ -188,6 +188,7 @@ elf_core_copy_task_fpregs(struct task_st
>>  }
>>  
>>  #define ELF_CORE_COPY_XFPREGS 1
>> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>>  static inline int 
>>  elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
>>  {
>> Index: linus/include/asm-x86/elf_32.h
>> ===================================================================
>> --- linus.orig/include/asm-x86/elf_32.h
>> +++ linus/include/asm-x86/elf_32.h
>> @@ -129,6 +129,7 @@ extern int dump_task_extended_fpu (struc
>>  #define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
>>  #define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
>>  #define ELF_CORE_COPY_XFPREGS(tsk, elf_xfpregs) dump_task_extended_fpu(tsk, elf_xfpregs)
>> +#define ELF_CORE_XFPREG_TYPE NT_PRXFPREG
>>  
>>  #define VDSO_HIGH_BASE		(__fix_to_virt(FIX_VDSO))
>>  #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
> 
> I'm not sure what happened here.  My current copy of
> replace-nt_prxfpreg-with-elf_core_xfpreg_type-define.patch has the above
> changes in it, and the commit which went into mainline this morning looks
> to be OK.
> 
Strange... Subtle bugs in mail scripts perhaps? Well anyway, as long as the
patch in mainline has everything (and it certainly looks like it does) I
guess it's all good :)

Many Thanks!

Mark.
