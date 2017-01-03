Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:61258 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934605AbdACNUv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2017 08:20:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCHv2 29/29] mm, x86: introduce RLIMIT_VADDR
Date: Tue, 03 Jan 2017 14:18:01 +0100
Message-ID: <3492795.xaneWtGxgW@wuerfel>
In-Reply-To: <CALCETrV_qejd-Ozqo4vTqz=LuukMUPeQ7EVUQbfTxs_xNbO3oQ@mail.gmail.com>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com> <2736959.3MfCab47fD@wuerfel> <CALCETrV_qejd-Ozqo4vTqz=LuukMUPeQ7EVUQbfTxs_xNbO3oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, linux-arch <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20170103131801.c6MRhAUoVWgZXwn2_BZQRqs21eSgwEsBDewsd8inItw@z>

On Monday, January 2, 2017 10:08:28 PM CET Andy Lutomirski wrote:
> 
> > This seems to nicely address the same problem on arm64, which has
> > run into the same issue due to the various page table formats
> > that can currently be chosen at compile time.
> 
> On further reflection, I think this has very little to do with paging
> formats except insofar as paging formats make us notice the problem.
> The issue is that user code wants to be able to assume an upper limit
> on an address, and it gets an upper limit right now that depends on
> architecture due to paging formats.  But someone really might want to
> write a *portable* 64-bit program that allocates memory with the high
> 16 bits clear.  So let's add such a mechanism directly.
> 
> As a thought experiment, what if x86_64 simply never allocated "high"
> (above 2^47-1) addresses unless a new mmap-with-explicit-limit syscall
> were used?  Old glibc would continue working.  Old VMs would work.
> New programs that want to use ginormous mappings would have to use the
> new syscall.  This would be totally stateless and would have no issues
> with CRIU.

I can see this working well for the 47-bit addressing default, but
what about applications that actually rely on 39-bit addressing
(I'd have to double-check, but I think this was the limit that
people were most interested in for arm64)?

39 bits seems a little small to make that the default for everyone
who doesn't pass the extra flag. Having to pass another flag to
limit the addresses introduces other problems (e.g. mmap from
library call that doesn't pass that flag).

> If necessary, we could also have a prctl that changes a
> "personality-like" limit that is in effect when the old mmap was used.
> I say "personality-like" because it would reset under exactly the same
> conditions that personality resets itself.

For "personality-like", it would still have to interact
with the existing PER_LINUX32 and PER_LINUX32_3GB flags that
do the exact same thing, so actually using personality might
be better.

We still have a few bits in the personality arguments, and
we could combine them with the existing ADDR_LIMIT_3GB
and ADDR_LIMIT_32BIT flags that are mutually exclusive by
definition, such as

        ADDR_LIMIT_32BIT =      0x0800000, /* existing */
        ADDR_LIMIT_3GB   =      0x8000000, /* existing */
        ADDR_LIMIT_39BIT =      0x0010000, /* next free bit */
        ADDR_LIMIT_42BIT =      0x8010000,
        ADDR_LIMIT_47BIT =      0x0810000,
        ADDR_LIMIT_48BIT =      0x8810000,

This would probably take only one or two personality bits for the
limits that are interesting in practice.

	Arnd
