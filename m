Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33548 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbeFGQYR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 12:24:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so10500385wro.0
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 09:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-7-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143705.3531-7-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 7 Jun 2018 09:24:03 -0700
Message-ID: <CALCETrVa8MtxP9iqYkZLnetaQiN4UaWb=jGz1+rLsCuETHKydg@mail.gmail.com>
Subject: Re: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and
 related functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607162403.y6qmiuCvRL2w_Pvd27K9vGRHsen3ZUgk5-aUNUyl458@z>

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The function ptep_set_wrprotect()/huge_ptep_set_wrprotect() is
> used by copy_page_range()/copy_hugetlb_page_range() to copy
> PTEs.
>
> On x86, when the shadow stack is enabled, only a shadow stack
> PTE has the read-only and _PAGE_DIRTY_HW combination.  Upon
> making a dirty PTE read-only, we move its _PAGE_DIRTY_HW to
> _PAGE_DIRTY_SW.
>
> When ptep_set_wrprotect() moves _PAGE_DIRTY_HW to _PAGE_DIRTY_SW,
> if the PTE is writable and the mm is shared, another task could
> race to set _PAGE_DIRTY_HW again.
>
> Introduce ptep_set_wrprotect_flush(), pmdp_set_wrprotect_flush(),
> and huge_ptep_set_wrprotect_flush() to make sure this does not
> happen.
>

This patch adds flushes where they didn't previously exist.

> +static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> +                                           unsigned long addr, pte_t *ptep)
> +{
> +       bool rw;
> +
> +       rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
> +               struct mm_struct *mm = vma->vm_mm;
> +               pte_t pte;
> +
> +               if (rw && (atomic_read(&mm->mm_users) > 1))
> +                       pte = ptep_clear_flush(vma, addr, ptep);

Why are you clearing the pte?

> -#define __HAVE_ARCH_PMDP_SET_WRPROTECT
> -static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> -                                     unsigned long addr, pmd_t *pmdp)
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT_FLUSH
> +static inline void huge_ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> +                                                unsigned long addr, pte_t *ptep)
>  {
> -       clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
> +       ptep_set_wrprotect_flush(vma, addr, ptep);

Maybe I'm just missing something, but you're changed the semantics of
this function significantly.
