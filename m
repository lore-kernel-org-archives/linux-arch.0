Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33020 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756491AbdABQxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jan 2017 11:53:03 -0500
Received: by mail-vk0-f41.google.com with SMTP id 137so265864070vkl.0
        for <linux-arch@vger.kernel.org>; Mon, 02 Jan 2017 08:53:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102094907.GC30735@node.shutemov.name>
References: <CALCETrXMCVOmVcQYxF_ghPdEjLuNNqbcnoRKRVpJegsQ=SPEFQ@mail.gmail.com>
 <20170102094907.GC30735@node.shutemov.name>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 2 Jan 2017 08:52:41 -0800
Message-ID: <CALCETrU+BJ2JDRocBy-6SD_G6FbD+Ez_yb1QJ6Z1KXBjVzKOHg@mail.gmail.com>
Subject: Re: How should we handle variable address space sizes (Re: [RFC 3/4]
 x86/mm: define TASK_SIZE as current->mm->task_size)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Carlos O'Donell <carlos@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>
Message-ID: <20170102165241.WfWgUYQ5S20K-LTctXrMr_JEDc5cRx8ZIQWRiT4_vEM@z>

On Mon, Jan 2, 2017 at 1:49 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Fri, Dec 30, 2016 at 06:11:05PM -0800, Andy Lutomirski wrote:
>> On Fri, Dec 30, 2016 at 7:56 AM, Dmitry Safonov <dsafonov@virtuozzo.com> wrote:
>> > Keep task's virtual address space size as mm_struct field which
>> > exists for a long time - it's initialized in setup_new_exec()
>> > depending on the new task's personality.
>> > This way TASK_SIZE will always be the same as current->mm->task_size.
>> > Previously, there could be an issue about different values of
>> > TASK_SIZE and current->mm->task_size: e.g, a 32-bit process can unset
>> > ADDR_LIMIT_3GB personality (with personality syscall) and
>> > so TASK_SIZE will be 4Gb, which is larger than mm->task_size = 3Gb.
>> > As TASK_SIZE *and* current->mm->task_size are used both in code
>> > frequently, this difference creates a subtle situations, for example:
>> > one can mmap addresses > 3Gb, but they will be hidden in
>> > /proc/pid/pagemap as it checks mm->task_size.
>> > I've moved initialization of mm->task_size earlier in setup_new_exec()
>> > as arch_pick_mmap_layout() initializes mmap_legacy_base with
>> > TASK_UNMAPPED_BASE, which depends on TASK_SIZE.
>>
>> I don't like this patch so much because I think that we should figure
>> out how this will all work in the long run first.  I've added some
>> more people to the thread because other arches have similar issues and
>> because x86 is about to get considerably more complicated (choices
>> include 3GB, 4GB, 47-bit, and 56-bit (the latter IIRC)).
>>
>> Here are a few of my thoughts on the matter.  This isn't all that well
>> thought out:
>>
>> The address space limit, especially if CRIU is in play, isn't really a
>> hard limit.  For example, you could allocate high memory then lower
>> the limit.  Similarly, I see no reason that an x32 program should be
>> forbidden from mapping some high addresses or, similarly, that an i386
>> program can't (if it really wanted to) do a 64-bit mmap() and get a
>> high address.
>>
>> On that note, can we just *delete* the task_size check from pagemap?
>> It's been there since the very beginning:
>>
>> commit 85863e475e59afb027b0113290e3796ee6020b7d
>> Author: Matt Mackall <mpm@selenic.com>
>> Date:   Mon Feb 4 22:29:04 2008 -0800
>>
>>     maps4: add /proc/pid/pagemap interface
>>
>> and there's no explanation for why it's needed.
>>
>> So maybe we should have a *number* (not a bit) that indicates the
>> maximum address that mmap() will return unless an override is in use.
>> Since common practice seems to be to stick this in the personality
>> field, we may need some fancy encoding.  Executing a setuid binary
>> needs to reset to the default, and personality handles that.
>
> If we want to be able to specify arbitrary address as maximum, a fancy
> encoding would need to claim 51 bits (63 VA - 12 in-page address) on x86
> from the persona flag.
> To me, it's stretching personality interface too far.
>
> Maybe it's easier to reset the rlimit for suid binaries?

I guess I don't see why rlimit makes any sense, though.  It's not a
resource utilization control, hard vs soft limits make very little
sense, requiring capabilities to exceed the hard limit doesn't help
anything, and it's only useful to preserve it across execve() to work
around bugs.

So if it's going to be a number, let's just make it be a new number
with a new API to control it.

--Andy
