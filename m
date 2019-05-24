Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:38205 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfEXPzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 May 2019 11:55:50 -0400
Received: by mail-io1-f67.google.com with SMTP id x24so8140640ion.5
        for <linux-arch@vger.kernel.org>; Fri, 24 May 2019 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com> <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com> <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
 <20190524152045.w3syntzp4bb5jb7u@treble>
In-Reply-To: <20190524152045.w3syntzp4bb5jb7u@treble>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 24 May 2019 17:55:37 +0200
Message-ID: <CAKv+Gu9DLf9y2uqTo407gLK3AX3pq+HGFxytsoR9C2zfGdUc-A@mail.gmail.com>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, guillaume.gardet@arm.com, Marc Zyngier <marc.zyngier@arm.com>, the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Jessica Yu <jeyu@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190524155537.qm8uroLcKddX-Etn8FqVBALDN4JR64MEYHUgijRFcAA@z>

On Fri, 24 May 2019 at 17:21, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 10:29:39AM +0100, Ard Biesheuvel wrote:
> >
> >
> > On 5/23/19 10:18 AM, Will Deacon wrote:
> > > On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
> > > >
> > > >
> > > > On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> > > > >
> > > > >
> > > > > On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
> > > > > > The following commit
> > > > > >
> > > > > >     7290d5809571 ("module: use relative references for __ksymtab entries")
> > > > > >
> > > > > > updated the ksymtab handling of some KASLR capable architectures
> > > > > > so that ksymtab entries are emitted as pairs of 32-bit relative
> > > > > > references. This reduces the size of the entries, but more
> > > > > > importantly, it gets rid of statically assigned absolute
> > > > > > addresses, which require fixing up at boot time if the kernel
> > > > > > is self relocating (which takes a 24 byte RELA entry for each
> > > > > > member of the ksymtab struct).
> > > > > >
> > > > > > Since ksymtab entries are always part of the same module as the
> > > > > > symbol they export (or of the core kernel), it was assumed at the
> > > > > > time that a 32-bit relative reference is always sufficient to
> > > > > > capture the offset between a ksymtab entry and its target symbol.
> > > > > >
> > > > > > Unfortunately, this is not always true: in the case of per-CPU
> > > > > > variables, a per-CPU variable's base address (which usually differs
> > > > > > from the actual address of any of its per-CPU copies) could be at
> > > > > > an arbitrary offset from the ksymtab entry, and so it may be out
> > > > > > of range for a 32-bit relative reference.
> > > > > >
> > > >
> > > > (Apologies for the 3-act monologue)
> > >
> > > Exposition, development and recapitulation ;)
> > >
> > > > This turns out to be incorrect. The symbol address of per-CPU variables
> > > > exported by modules is always in the vicinity of __per_cpu_start, and so it
> > > > is simply a matter of making sure that the core kernel is in range for
> > > > module ksymtab entries containing 32-bit relative references.
> > > >
> > > > When running the arm64 with kaslr enabled, we currently randomize the module
> > > > space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
> > > > GB range rather than the -/+ 2 GB range of 32-bit place relative data
> > > > relocations. So we can fix this by simply reducing the randomization window
> > > > to 2 GB.
> > >
> > > Makes sense. Do you see the need for an option to disable PREL relocs
> > > altogether in case somebody wants the additional randomization range?
> > >
> >
> > No, not really. To be honest, I don't think
> > CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and the
> > only reason we enabled it by default at the time was to ensure that the PLT
> > code got some coverage after we introduced it.
>
> In code, percpu variables are accessed with absolute relocations, right?

No, they are accessed just like ordinary symbols, so PC32 references
on x86 or ADRP/ADD references on arm64 are both quite common.

> Before I read your 3rd act, I was wondering if it would make sense to do
> the same with the ksymtab relocations.
>
> Like if we somehow [ insert much hand waving ] ensured that everybody
> uses EXPORT_PER_CPU_SYMBOL() for percpu symbols instead of just
> EXPORT_SYMBOL() then we could use a different macro to create the
> ksymtab relocations for percpu variables, such that they use absolute
> relocations.
>
> Just an idea.  Maybe the point is moot now.
>

The problem is that we already have four different ksymtab sections:
normal, GPL, future GPL and unused, and adding the orthogonal per-CPU
property to that would double it to 8.

Since the purpose of the place relative ksymtabs applies to the core
kernel only, another thing I contemplated is using a different ksymtab
format between modules and the core kernel, but that is another can of
worms that I'd rather not open.

But it is indeed moot now ...
