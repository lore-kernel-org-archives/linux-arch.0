From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 05/10] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Wed, 29 Jan 2020 11:49:17 +0100
Message-ID: <20200129104917.GN14946@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-6-will@kernel.org>
 <20200125082746.GT11457@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgA2Kt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jan 2020 05:49:29 -0500
Content-Disposition: inline
In-Reply-To: <20200125082746.GT11457@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, ying.huang@intel.com, kirill.shutemov@linux.intel.com

On Sat, Jan 25, 2020 at 09:27:46AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 03:33:36PM +0000, Will Deacon wrote:
> > {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> > This can be surprising to callers that might incorrectly be expecting
> > atomicity for accesses to aggregate structures, although there are other
> > callers where tearing is actually permissable (e.g. if they are using
> > something akin to sequence locking to protect the access).
> > 
> > Linus sayeth:
> > 
> >   | We could also look at being stricter for the normal READ/WRITE_ONCE(),
> >   | and require that they are
> >   |
> >   | (a) regular integer types
> >   |
> >   | (b) fit in an atomic word
> >   |
> >   | We actually did (b) for a while, until we noticed that we do it on
> >   | loff_t's etc and relaxed the rules. But maybe we could have a
> >   | "non-atomic" version of READ/WRITE_ONCE() that is used for the
> >   | questionable cases?
> > 
> > The slight snag is that we also have to support 64-bit accesses on 32-bit
> > architectures, as these appear to be widespread and tend to work out ok
> > if either the architecture supports atomic 64-bit accesses (x86, armv7)
> > or if the variable being accesses represents a virtual address and
> > therefore only requires 32-bit atomicity in practice.
> > 
> > Take a step in that direction by introducing a variant of
> > 'compiletime_assert_atomic_type()' and use it to check the pointer
> > argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE_ONCE}() variants
> > which are allowed to tear and convert the two broken callers over to the
> > new macros.
> 
> The build robot is telling me we also need this for m68k; they have:
> 
>   arch/m68k/include/asm/page.h:typedef struct { unsigned long pmd[16]; } pmd_t;

Fixed that with these patches:

  https://lkml.kernel.org/r/20200129103941.304769381@infradead.org
