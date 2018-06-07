Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933567AbeFGSY7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 14:24:59 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF90A208A6
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 18:24:58 +0000 (UTC)
Received: by mail-wm0-f46.google.com with SMTP id q4-v6so4205900wmq.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 11:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-7-yu-cheng.yu@intel.com>
 <CALCETrVa8MtxP9iqYkZLnetaQiN4UaWb=jGz1+rLsCuETHKydg@mail.gmail.com> <d9939c23-bb8b-1fbc-ac65-8bf1d7cbf650@linux.intel.com>
In-Reply-To: <d9939c23-bb8b-1fbc-ac65-8bf1d7cbf650@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:24:45 -0700
Message-ID: <CALCETrU=_zFvSqc4UWQ1ySgn1MAU=z9JFJbPpeK6gTQwbZGonQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] x86/mm: Introduce ptep_set_wrprotect_flush and
 related functions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607182445.P2QsPvIrv0xyY_UjbFlBBVzCPVCiDVp6Z8fXA_GpCws@z>

On Thu, Jun 7, 2018 at 11:23 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> On 06/07/2018 09:24 AM, Andy Lutomirski wrote:
> >> +static inline void ptep_set_wrprotect_flush(struct vm_area_struct *vma,
> >> +                                           unsigned long addr, pte_t *ptep)
> >> +{
> >> +       bool rw;
> >> +
> >> +       rw = test_and_clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> >> +       if (IS_ENABLED(CONFIG_X86_INTEL_SHADOW_STACK_USER)) {
> >> +               struct mm_struct *mm = vma->vm_mm;
> >> +               pte_t pte;
> >> +
> >> +               if (rw && (atomic_read(&mm->mm_users) > 1))
> >> +                       pte = ptep_clear_flush(vma, addr, ptep);
> > Why are you clearing the pte?
>
> I think I insisted on this being in there.
>
> First of all, we need to flush the TLB eventually because we need the
> shadowstack PTE permissions to be in effect.
>
> But, generally, we can't clear a dirty bit in a "live" PTE without
> flushing.  The processor can keep writing until we flush, and even keep
> setting it whenever _it_ allows a write, which it can do based on stale
> TLB contents.  Practically, I think a walk to set the dirty bit is
> mostly the same as a TLB miss, but that's certainly not guaranteed forever.
>
> That's even ignoring all the fun errata we have.

Maybe make it a separate patch, then?  It seems like this patch is
doing two almost entirely separate things: adding some flushes and
adding the magic hwdirty -> swdirty transition.  As it stands, it's
quite difficult to read the patch and figure out what it does.
