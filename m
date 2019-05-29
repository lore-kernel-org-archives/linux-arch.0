Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43807 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2Pka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 11:40:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so2456119oth.10
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 08:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-4-elver@google.com>
 <20190529153258.GJ31777@lakrids.cambridge.arm.com>
In-Reply-To: <20190529153258.GJ31777@lakrids.cambridge.arm.com>
From: Marco Elver <elver@google.com>
Date: Wed, 29 May 2019 17:40:18 +0200
Message-ID: <CANpmjNPPKaURFT=HDSy9K3MBHoJgAz-+Z1zN38GMZdqNXDMsuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] asm-generic, x86: Add bitops instrumentation for KASAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: peterz@infradead.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529154018._ZLUNKuLlXQpV5OUdhek4wLydqMLByuxNhaEoQEc_Wk@z>

On Wed, 29 May 2019 at 17:33, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, May 29, 2019 at 04:15:01PM +0200, Marco Elver wrote:
> > This adds a new header to asm-generic to allow optionally instrumenting
> > architecture-specific asm implementations of bitops.
> >
> > This change includes the required change for x86 as reference and
> > changes the kernel API doc to point to bitops-instrumented.h instead.
> > Rationale: the functions in x86's bitops.h are no longer the kernel API
> > functions, but instead the arch_ prefixed functions, which are then
> > instrumented via bitops-instrumented.h.
> >
> > Other architectures can similarly add support for asm implementations of
> > bitops.
> >
> > The documentation text has been copied/moved, and *no* changes to it
> > have been made in this patch.
> >
> > Tested: using lib/test_kasan with bitops tests (pre-requisite patch).
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198439
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Changes in v2:
> > * Instrument word-sized accesses, as specified by the interface.
> > ---
> >  Documentation/core-api/kernel-api.rst     |   2 +-
> >  arch/x86/include/asm/bitops.h             | 210 ++++----------
> >  include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
> >  3 files changed, 370 insertions(+), 159 deletions(-)
> >  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> [...]
>
> > diff --git a/include/asm-generic/bitops-instrumented.h b/include/asm-generic/bitops-instrumented.h
> > new file mode 100644
> > index 000000000000..b01b0dd93964
> > --- /dev/null
> > +++ b/include/asm-generic/bitops-instrumented.h
> > @@ -0,0 +1,317 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This file provides wrappers with sanitizer instrumentation for bit
> > + * operations.
> > + *
> > + * To use this functionality, an arch's bitops.h file needs to define each of
> > + * the below bit operations with an arch_ prefix (e.g. arch_set_bit(),
> > + * arch___set_bit(), etc.), #define each provided arch_ function, and include
> > + * this file after their definitions. For undefined arch_ functions, it is
> > + * assumed that they are provided via asm-generic/bitops, which are implicitly
> > + * instrumented.
> > + */
>
> If using the asm-generic/bitops.h, all of the below will be defined
> unconditionally, so I don't believe we need the ifdeffery for each
> function.
>
> > +#ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> > +#define _ASM_GENERIC_BITOPS_INSTRUMENTED_H
> > +
> > +#include <linux/kasan-checks.h>
> > +
> > +#if defined(arch_set_bit)
> > +/**
> > + * set_bit - Atomically set a bit in memory
> > + * @nr: the bit to set
> > + * @addr: the address to start counting from
> > + *
> > + * This function is atomic and may not be reordered.  See __set_bit()
> > + * if you do not require the atomic guarantees.
> > + *
> > + * Note: there are no guarantees that this function will not be reordered
> > + * on non x86 architectures, so if you are writing portable code,
> > + * make sure not to rely on its reordering guarantees.
>
> These two paragraphs are contradictory.
>
> Since this is not under arch/x86, please fix this to describe the
> generic semantics; any x86-specific behaviour should be commented under
> arch/x86.
>
> AFAICT per include/asm-generic/bitops/atomic.h, generically this
> provides no ordering guarantees. So I think this can be:
>
> /**
>  * set_bit - Atomically set a bit in memory
>  * @nr: the bit to set
>  * @addr: the address to start counting from
>  *
>  * This function is atomic and may be reordered.
>  *
>  * Note that @nr may be almost arbitrarily large; this function is not
>  * restricted to acting on a single-word quantity.
>  */
>
> ... with the x86 ordering beahviour commented in x86's arch_set_bit.
>
> Peter, do you have a better wording for the above?
>
> [...]
>
> > +#if defined(arch___test_and_clear_bit)
> > +/**
> > + * __test_and_clear_bit - Clear a bit and return its old value
> > + * @nr: Bit to clear
> > + * @addr: Address to count from
> > + *
> > + * This operation is non-atomic and can be reordered.
> > + * If two examples of this operation race, one can appear to succeed
> > + * but actually fail.  You must protect multiple accesses with a lock.
> > + *
> > + * Note: the operation is performed atomically with respect to
> > + * the local CPU, but not other CPUs. Portable code should not
> > + * rely on this behaviour.
> > + * KVM relies on this behaviour on x86 for modifying memory that is also
> > + * accessed from a hypervisor on the same CPU if running in a VM: don't change
> > + * this without also updating arch/x86/kernel/kvm.c
> > + */
>
> Likewise, please only specify the generic semantics in this header, and
> leave the x86-specific behaviour commented under arch/x86.

The current official API documentation refers to x86 bitops.h (also
see the Documentation/core-api/kernel-api.rst change):
https://www.kernel.org/doc/htmldocs/kernel-api/API-set-bit.html

I'm happy to change in this patch, but note that this would change the
official API documentation.  Alternatively it could be done in a
separate patch.

Let me know what you prefer.

Thanks,
-- Marco
