From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 10:45:08 -0800
Message-ID: <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck> <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWSpU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 13:45:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so1930618pfo.10
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:45:19 -0800 (PST)
In-Reply-To: <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>, Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "kernel-team@android.com" <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>

On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Will Deacon
> > Sent: 23 January 2020 17:17
> >
> > I think it depends how much we care about those older compilers. My series
> > first moves it to "Good luck mate, you're on your own" and then follows up

I wish the actual warning was worded that way. :P

> > with a "Let me take that off you it's sharp".

> Oh - and I need to find a newer compiler :-(

What distro are you using? Does it have a package for a newer
compiler?  I'm honestly curious about what policies if any the kernel
has for supporting developer's toolchains from their distributions.
(ie. Arnd usually has pretty good stats what distro's use which
version of GCC and are still supported; Do we strive to not break
them? Is asking kernel devs to compile their own toolchain too much to
ask?  Is it still if they're using really old distro's/toolchains that
we don't want to support?  Do we survey kernel devs about what they're
using?).  Apologies if this is already documented somewhere, but if
not I'd eventually like to brainstorm and write it down somewhere in
the tree.  Documentation/process/changes.rst doesn't really answer the
above questions, I think.

-- 
Thanks,
~Nick Desaulniers
