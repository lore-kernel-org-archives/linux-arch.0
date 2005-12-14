Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1134560671.2894.30.camel@laptopd505.fenrus.org> 
References: <1134560671.2894.30.camel@laptopd505.fenrus.org>  <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Wed, 14 Dec 2005 11:57:12 +0000
Message-ID: <15412.1134561432@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arjan van de Ven <arjan@infradead.org> wrote:

> >  given that
> > mutex_down() is slightly more costly than current down(), and mutex_up() is
> > appreciably more costly than current up()?
> 
> that's an implementation flaw in the current implementation that is not
> needed by any means and that Ingo has fixed in his version of this

As do I. I wrote it yesterday with Ingo looking over my shoulder, as it were,
but I haven't released it yet.

What I provided was a base implementation that anything can use provided it
has an atomic op capable of exchanging between two states, and I suspect
everything that can do multiprocessing has - if you can do spinlocks, then you
can do this. I ALSO provided a mechanism by which it could be overridden if
there's something better available on that arch.

As I see it there are four classes of arch:

 (0) Those that have no atomic ops at all - in which case xchg is trivially
     implemented by disabling interrupts, and spinlocks must be null because
     they can't be implemented.

 (1) Those that only have a limited exchange functionality. Several archs do
     fall into this category: arm, frv, mn10300, 68000, i386.

 (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64, sparc.

 (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.

(This isn't an exhaustive list of archs)

Each higher class can emulate all the lower classes, but can probably do a
better implementation than the lower class because they have more flexibility.

For instance class (1) mutexes can only practically support two states, but
class (2) and (3) can support multiple states, and so can improve the up()
fastpath as well as the down() fastpaths.

With some archs, such as FRV, it might be possible to emulate a higher class,
but it's not necessarily practical in all circumstances.

David
