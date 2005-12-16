Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <43A21E55.3060907@yahoo.com.au>
Date: Fri, 16 Dec 2005 12:54:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <1134560671.2894.30.camel@laptopd505.fenrus.org>  <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com>
In-Reply-To: <15412.1134561432@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> 
>>> given that
>>>mutex_down() is slightly more costly than current down(), and mutex_up() is
>>>appreciably more costly than current up()?
>>
>>that's an implementation flaw in the current implementation that is not
>>needed by any means and that Ingo has fixed in his version of this
> 
> 
> As do I. I wrote it yesterday with Ingo looking over my shoulder, as it were,
> but I haven't released it yet.
> 
> What I provided was a base implementation that anything can use provided it
> has an atomic op capable of exchanging between two states, and I suspect
> everything that can do multiprocessing has - if you can do spinlocks, then you
> can do this. I ALSO provided a mechanism by which it could be overridden if
> there's something better available on that arch.
> 
> As I see it there are four classes of arch:
> 
>  (0) Those that have no atomic ops at all - in which case xchg is trivially
>      implemented by disabling interrupts, and spinlocks must be null because
>      they can't be implemented.
> 
>  (1) Those that only have a limited exchange functionality. Several archs do
>      fall into this category: arm, frv, mn10300, 68000, i386.
> 
>  (2) Those that have CMPXCHG or equivalent: 68020, i486+, x86_64, ia64, sparc.
> 
>  (3) Those that have LL/SC or equivalent: mips (some), alpha, powerpc, arm6.
> 

cmpxchg is basically exactly equivalent to a store-conditional, so 2 and 3
are the same level.

I don't know why you don't implement a "good" default implementation with
atomic_cmpxchg.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
