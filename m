Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33666 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754503AbcLaCL0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Dec 2016 21:11:26 -0500
Received: by mail-vk0-f42.google.com with SMTP id 137so247987582vkl.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Dec 2016 18:11:26 -0800 (PST)
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 30 Dec 2016 18:11:05 -0800
Message-ID: <CALCETrXMCVOmVcQYxF_ghPdEjLuNNqbcnoRKRVpJegsQ=SPEFQ@mail.gmail.com>
Subject: How should we handle variable address space sizes (Re: [RFC 3/4]
 x86/mm: define TASK_SIZE as current->mm->task_size)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Safonov <dsafonov@virtuozzo.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Carlos O'Donell <carlos@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>
Message-ID: <20161231021105.gXrPSz28g-d6sryl2KPHfNr3OeC61jQyhyua4eFaznE@z>

On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
> Keep task's virtual address space size as mm_struct field which
> exists for a long time - it's initialized in setup_new_exec()
> depending on the new task's personality.
> This way TASK_SIZE will always be the same as current->mm->task_size.
> Previously, there could be an issue about different values of
> TASK_SIZE and current->mm->task_size: e.g, a 32-bit process can unset
> ADDR_LIMIT_3GB personality (with personality syscall) and
> so TASK_SIZE will be 4Gb, which is larger than mm->task_size = 3Gb.
> As TASK_SIZE *and* current->mm->task_size are used both in code
> frequently, this difference creates a subtle situations, for example:
> one can mmap addresses > 3Gb, but they will be hidden in
> /proc/pid/pagemap as it checks mm->task_size.
> I've moved initialization of mm->task_size earlier in setup_new_exec()
> as arch_pick_mmap_layout() initializes mmap_legacy_base with
> TASK_UNMAPPED_BASE, which depends on TASK_SIZE.

I don't like this patch so much because I think that we should figure
out how this will all work in the long run first.  I've added some
more people to the thread because other arches have similar issues and
because x86 is about to get considerably more complicated (choices
include 3GB, 4GB, 47-bit, and 56-bit (the latter IIRC)).

Here are a few of my thoughts on the matter.  This isn't all that well
thought out:

The address space limit, especially if CRIU is in play, isn't really a
hard limit.  For example, you could allocate high memory then lower
the limit.  Similarly, I see no reason that an x32 program should be
forbidden from mapping some high addresses or, similarly, that an i386
program can't (if it really wanted to) do a 64-bit mmap() and get a
high address.

On that note, can we just *delete* the task_size check from pagemap?
It's been there since the very beginning:

commit 85863e475e59afb027b0113290e3796ee6020b7d
Author: Matt Mackall <mpm@selenic.com>
Date:   Mon Feb 4 22:29:04 2008 -0800

    maps4: add /proc/pid/pagemap interface

and there's no explanation for why it's needed.

So maybe we should have a *number* (not a bit) that indicates the
maximum address that mmap() will return unless an override is in use.
Since common practice seems to be to stick this in the personality
field, we may need some fancy encoding.  Executing a setuid binary
needs to reset to the default, and personality handles that.

We should also probably come up with a reasonable set of getters and
setters for CRIU and otherwise.  I can think of the following
questions that might be asked:

 - What is the highest currently mapped VA?  (/proc can already answer
this.  If needed, a prctl could be added, too.  Using /proc is a bit
tricky due to out-of-range "gate areas", e.g. the x86 vsyscall page.)

 - What is the highest address that mmap() will return without being
forced?  On x86 and sparc, this could plausbly be extra complicated
because there are multiple "mmap()" syscalls (32-bit vs 64-bit), so an
i386 process could theoretically have a limit of 2^47-1, for example.
I doubt this matters much.  I'm also not sure whether this should be
per-task or per-mm.  I can see legitimate use cases to set this to
unusual numbers.  For example, some x86 program could want 2^51-1
because it wants that many high bits free, even though this doesn't
correspond to any particular hardware paging mode.  This probably
wants a getter and a setter.

 - What is the highest address that the hardware is capable of?  (By
this, I mean with the kernel's adjustments applied.  x86_64 is
currently capable of 2^47-1, but we artificially cap it to 2^47-4097
due to Intel having screwed up SYSRET.)  This is just TASK_SIZE_MAX.
I'm not sure we need a getter or a setter, since it doesn't seem all
that useful to know.

We still need to see if there should be some way for an ELF binary to
be tagged with its maximum supported virtual address.  If we do this,
I would suggest an ELF note as a straw-man initial proposal.  ELF
notes are nice because I think they can be generated cleanly from C or
asm without modifying binutils.

I wouldn't mind seeing TASK_SIZE go away completely in the long run,
since it's not clearly defined what it does.  Also, it's worth noting
that, in the absence of userspace making assumptions, no limit is
needed at all.  A 32-bit or x32 program should *automatically* get a
limited address simply by virtue of making an mmap() syscall with the
32-bit or x32 ABI.

Thoughts?

P.S. If we add an ELF note saying "supports 57 bits", I think we
should also add an ELF note saying "doesn't use vsyscalls", but that's
a bit off topic.

P.P.S. We can efficiently turn vsyscalls off per process.  I even have
code for it.  It's a bit tricky and abuses some paging bits, but it
works.
