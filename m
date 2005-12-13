Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 11:37:55 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213103755.GA7425@elte.hu>
References: <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <20051213101300.GA2178@elte.hu> <20051213103420.GA6681@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213103420.GA6681@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > 
> > > > We have atomic_cmpxchg. Can you use that for a sufficient generic
> > > > implementation?
> > > 
> > > No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.
> > 
> > take a look at the PREEMPT_RT implementation of mutexes: it uses 
> > cmpxchg(), and thus both the down() and the up() fastpath is lockless!  
> > (And that is a mutex type that does alot more things, as it supports 
> > priority inheritance.)
> > 
> > architectures which dont have cmpxchg can use a spinlock just fine.
> 
> the cost of a spinlock-based generic_cmpxchg could be significantly 
> reduced by adding a generic_cmpxchg() variant that also includes a 
> 'spinlock pointer' parameter.
> 
> Architectures that do not have the instruction, can use the specified 
> spinlock to do the cmpxchg. This means that there wont be one single 
> global spinlock to emulate cmpxchg, but the mutex's own spinlock can 
> be used for it.
> 
> Architectures that have the cmpxchg instruction would simply ignore 
> the parameter, and would incur no overhead.

an additional twist: we could add generic_cmpxchg_lock(), which would 
return the spinlock locked if the cmpxchg fails. (this is what we want 
to do anyway) This way architectures that dont have CMPXCHG would take 
the spinlock unconditionally and do the cmp-xchg emulation, while the 
other architectures would take it only if the cmpxchg fails.

	Ingo
