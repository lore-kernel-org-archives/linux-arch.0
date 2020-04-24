From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Fri, 24 Apr 2020 18:11:35 +0100
Message-ID: <20200424171135.GJ21141@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-8-will@kernel.org>
 <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXRLl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 13:11:41 -0400
Content-Disposition: inline
In-Reply-To: <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Fri, Apr 24, 2020 at 06:31:35PM +0200, Jann Horn wrote:
> On Tue, Apr 21, 2020 at 5:15 PM Will Deacon <will@kernel.org> wrote:
> > {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> > This can be surprising to callers that might incorrectly be expecting
> > atomicity for accesses to aggregate structures, although there are other
> > callers where tearing is actually permissable (e.g. if they are using
> > something akin to sequence locking to protect the access).
> [...]
> > The slight snag is that we also have to support 64-bit accesses on 32-bit
> > architectures, as these appear to be widespread and tend to work out ok
> > if either the architecture supports atomic 64-bit accesses (x86, armv7)
> > or if the variable being accesses represents a virtual address and
> > therefore only requires 32-bit atomicity in practice.
> >
> > Take a step in that direction by introducing a variant of
> > 'compiletime_assert_atomic_type()' and use it to check the pointer
> > argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE}_ONCE() variants
> > which are allowed to tear and convert the one broken caller over to the
> > new macros.
> [...]
> > +/*
> > + * Yes, this permits 64-bit accesses on 32-bit architectures. These will
> > + * actually be atomic in many cases (namely x86), but for others we rely on
> 
> I don't think that's correct?

[...]

> AFAIK 32-bit X86 code that wants to atomically load 8 bytes of memory
> has to use CMPXCHG8B; and gcc won't generate such code just based on a
> volatile load/store.

My apologies, you're completely right. I thought that PAE mandated 64-bit
atomicity, like it does on 32-bit ARM, but that's apparently not the case
and looking at the 32-bit x86 pgtable code they have to be really careful
there.

I'll update the comment.

Will
