Return-Path: <SRS0=fNgb=3C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAMPB5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jan 2020 10:01:57 -0500
Date: Mon, 13 Jan 2020 15:01:52 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH 7/8] locking/barriers: Use '__unqual_scalar_typeof'
 for load-acquire macros
Message-ID: <20200113150151.GC4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-8-will@kernel.org>
 <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20200113150152.cPwXb3rvYk8b24O0ilnZL2Yi-07PFiPP8gyWXWSuqhM@z>

On Fri, Jan 10, 2020 at 08:42:37PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:57 PM Will Deacon <will@kernel.org> wrote:
> 
> > @@ -128,10 +128,10 @@ do {                                                                      \
> >  #ifndef __smp_load_acquire
> >  #define __smp_load_acquire(p)                                          \
> >  ({                                                                     \
> > -       typeof(*p) ___p1 = READ_ONCE(*p);                               \
> > +       __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> >         compiletime_assert_atomic_type(*p);                             \
> >         __smp_mb();                                                     \
> > -       ___p1;                                                          \
> > +       (typeof(*p))___p1;                                              \
> >  })
> 
> Doesn't that last  (typeof(*p))___p1 mean you put the potential
> 'volatile' back on the assignment after you went through the
> effort of taking it out?

Yes, but that's ok wrt codegen since the local variable isn't volatile,
and I definitely ran into issues with 'const' if I returned the unqualified
type here.

Will
