Return-Path: <SRS0=fIL7=27=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:32853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgAJR60 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jan 2020 12:58:26 -0500
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org>
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Jan 2020 18:58:06 +0100
Message-ID: <CAK8P3a3LAirovfV=RRqf9dT7K_WkiC8SJK9oa-amn_EkibqEsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] Rework READ_ONCE() to improve codegen
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20200110175806.rcjArfjx6E5wVuWbmYO5LpkZ1ZNMqeQkoLU07KKA9Mg@z>

On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
>
> Hi all,
>
> This is a follow-up RFC to the discussions we had on the mailing list at
> the end of last year:
>
> https://lore.kernel.org/lkml/875zimp0ay.fsf@mpe.ellerman.id.au
>
> Unfortunately, we didn't get a "silver bullet" solution out of that
> long thread, but I've tried to piece together some of the bits and
> pieces we discussed and I've ended up with this series, which does at
> least solve the pressing problem with the bitops for arm64.
>
> The rough summary of the series is:
>
>   * Drop the GCC 4.8 workarounds, so that READ_ONCE() is a
>     straightforward dereference of a cast-to-volatile pointer.
>
>   * Require that the access is either 1, 2, 4 or 8 bytes in size
>     (even 32-bit architectures tend to use 8-byte accesses here).
>
>   * Introduce __READ_ONCE() for tearing operations with no size
>     restriction.
>
>   * Drop pointer qualifiers from scalar types, so that volatile scalars
>     don't generate horrible stack-spilling mess. This is pretty ugly,
>     but it's also mechanical and wrapped up in a macro.
>
>   * Convert acquire/release accessors to perform the same qualifier
>     stripping.
>
> I gave up trying to prevent READ_ONCE() on aggregates because it is
> pervasive, particularly within the mm/ layer on things like pmd_t.
> Thankfully, these don't tend to be volatile.
>
> I have more patches in this area because I'm trying to move all the
> read_barrier_depends() magic into arch/alpha/, but I'm holding off until
> we agree on this part first.

Looks very nice overall, thanks for working on this.

I've added a the series into my randconfig build setup to see
if I run into build-time regressions. Unfortunately there are some
conflicts with the kcsan patches in linux-next that I have to work
around first.

       Arnd
