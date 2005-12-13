Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <439E1381.2060201@yahoo.com.au> 
References: <439E1381.2060201@yahoo.com.au>  <dhowells1134431145@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 11:23:01 +0000
Message-ID: <974.1134472981@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Any reason why you're setting up your own style of waitqueue in
> mutex-simple.c instead of just using the kernel's style of waitqueue?

Because I can steal the code from FRV's semaphores or rw-semaphores, and this
way I can be sure of what I'm doing.

Note that the sleeping processes are generally dequeued and dispatched by the
up() function, which means they don't have to take the spinlock themselves.
This may be possible to do magically with the waitqueue stuff, but I'm not sure
how to do it; it's horribly complicated to read through the sources and there
isn't much documentation.

> > +	mb();
> 
> This should be smp_mb(), I think.

Yes.

David
