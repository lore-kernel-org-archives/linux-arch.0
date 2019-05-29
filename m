Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33956 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2Kad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 06:30:33 -0400
Date: Wed, 29 May 2019 12:30:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529103010.GP2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Mark Rutland <mark.rutland@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529103010.FWLCIh5v4erAH6MtRLMn8gItXXf-SGNAcBvflYQgYnE@z>

On Wed, May 29, 2019 at 12:16:31PM +0200, Marco Elver wrote:
> On Wed, 29 May 2019 at 12:01, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> > > For the default, we decided to err on the conservative side for now,
> > > since it seems that e.g. x86 operates only on the byte the bit is on.
> >
> > This is not correct, see for instance set_bit():
> >
> > static __always_inline void
> > set_bit(long nr, volatile unsigned long *addr)
> > {
> >         if (IS_IMMEDIATE(nr)) {
> >                 asm volatile(LOCK_PREFIX "orb %1,%0"
> >                         : CONST_MASK_ADDR(nr, addr)
> >                         : "iq" ((u8)CONST_MASK(nr))
> >                         : "memory");
> >         } else {
> >                 asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> >                         : : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> >         }
> > }
> >
> > That results in:
> >
> >         LOCK BTSQ nr, (addr)
> >
> > when @nr is not an immediate.
> 
> Thanks for the clarification. Given that arm64 already instruments
> bitops access to whole words, and x86 may also do so for some bitops,
> it seems fine to instrument word-sized accesses by default. Is that
> reasonable?

Eminently -- the API is defined such; for bonus points KASAN should also
do alignment checks on atomic ops. Future hardware will #AC on unaligned
[*] LOCK prefix instructions.

(*) not entirely accurate, it will only trap when crossing a line.
    https://lkml.kernel.org/r/1556134382-58814-1-git-send-email-fenghua.yu@intel.com
