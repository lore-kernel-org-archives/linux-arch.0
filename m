Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 11:13:00 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213101300.GA2178@elte.hu>
References: <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22479.1134467689@warthog.cambridge.redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* David Howells <dhowells@redhat.com> wrote:

> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > We have atomic_cmpxchg. Can you use that for a sufficient generic
> > implementation?
> 
> No. CMPXCHG/CAS is not as available as XCHG, and it's also unnecessary.

take a look at the PREEMPT_RT implementation of mutexes: it uses 
cmpxchg(), and thus both the down() and the up() fastpath is lockless!  
(And that is a mutex type that does alot more things, as it supports 
priority inheritance.)

architectures which dont have cmpxchg can use a spinlock just fine.

	Ingo
