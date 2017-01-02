Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35504 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755476AbdABJtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2017 04:49:10 -0500
Received: by mail-wj0-f196.google.com with SMTP id hb5so34728460wjc.2
        for <linux-arch@vger.kernel.org>; Mon, 02 Jan 2017 01:49:10 -0800 (PST)
Date: Mon, 2 Jan 2017 12:49:07 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: How should we handle variable address space sizes (Re: [RFC 3/4]
 x86/mm: define TASK_SIZE as current->mm->task_size)
Message-ID: <20170102094907.GC30735@node.shutemov.name>
References: <CALCETrXMCVOmVcQYxF_ghPdEjLuNNqbcnoRKRVpJegsQ=SPEFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXMCVOmVcQYxF_ghPdEjLuNNqbcnoRKRVpJegsQ=SPEFQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Carlos O'Donell <carlos@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>
Message-ID: <20170102094907.YrnN8mHlJT-d-xzq3djH5fFmkCn3borlFFnlhUmTpAY@z>

On Fri, Dec 30, 2016 at 06:11:05PM -0800, Andy Lutomirski wrote:
> On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> > Keep task's virtual address space size as mm_struct field which
> > exists for a long time - it's initialized in setup_new_exec()
> > depending on the new task's personality.
> > This way TASK_SIZE will always be the same as current->mm->task_size.
> > Previously, there could be an issue about different values of
> > TASK_SIZE and current->mm->task_size: e.g, a 32-bit process can unset
> > ADDR_LIMIT_3GB personality (with personality syscall) and
> > so TASK_SIZE will be 4Gb, which is larger than mm->task_size = 3Gb.
> > As TASK_SIZE *and* current->mm->task_size are used both in code
> > frequently, this difference creates a subtle situations, for example:
> > one can mmap addresses > 3Gb, but they will be hidden in
> > /proc/pid/pagemap as it checks mm->task_size.
> > I've moved initialization of mm->task_size earlier in setup_new_exec()
> > as arch_pick_mmap_layout() initializes mmap_legacy_base with
> > TASK_UNMAPPED_BASE, which depends on TASK_SIZE.
> 
> I don't like this patch so much because I think that we should figure
> out how this will all work in the long run first.  I've added some
> more people to the thread because other arches have similar issues and
> because x86 is about to get considerably more complicated (choices
> include 3GB, 4GB, 47-bit, and 56-bit (the latter IIRC)).
> 
> Here are a few of my thoughts on the matter.  This isn't all that well
> thought out:
> 
> The address space limit, especially if CRIU is in play, isn't really a
> hard limit.  For example, you could allocate high memory then lower
> the limit.  Similarly, I see no reason that an x32 program should be
> forbidden from mapping some high addresses or, similarly, that an i386
> program can't (if it really wanted to) do a 64-bit mmap() and get a
> high address.
> 
> On that note, can we just *delete* the task_size check from pagemap?
> It's been there since the very beginning:
> 
> commit 85863e475e59afb027b0113290e3796ee6020b7d
> Author: Matt Mackall <mpm@selenic.com>
> Date:   Mon Feb 4 22:29:04 2008 -0800
> 
>     maps4: add /proc/pid/pagemap interface
> 
> and there's no explanation for why it's needed.
> 
> So maybe we should have a *number* (not a bit) that indicates the
> maximum address that mmap() will return unless an override is in use.
> Since common practice seems to be to stick this in the personality
> field, we may need some fancy encoding.  Executing a setuid binary
> needs to reset to the default, and personality handles that.

If we want to be able to specify arbitrary address as maximum, a fancy
encoding would need to claim 51 bits (63 VA - 12 in-page address) on x86
from the persona flag.
To me, it's stretching personality interface too far.

Maybe it's easier to reset the rlimit for suid binaries?

-- 
 Kirill A. Shutemov
