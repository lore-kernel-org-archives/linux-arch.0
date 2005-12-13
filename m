Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 13:05:18 +0000
Message-Id: <1134479118.11732.14.camel@localhost.localdomain>
Mime-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Llu, 2005-12-12 at 23:45 +0000, David Howells wrote:
>  (5) Redirects the following to apply to the new mutexes rather than the
>      traditional semaphores:
> 
> 	down()
> 	down_trylock()
> 	down_interruptible()
> 	up()
> 	init_MUTEX()
>      	init_MUTEX_LOCKED()
> 	DECLARE_MUTEX()
> 	DECLARE_MUTEX_LOCKED()

And you've audited every occurence ?

>      On the basis that most usages of semaphores are as mutexes, this makes
>      sense for in most cases it's just then a matter of changing the type from
>      struct semaphore to struct mutex. 

You propose to rename the existing up and down, which are counting
semaphores, documented and used that way everywhere with mutexes which
are not. Worse still up/down are, second to P/V, the usual forms of
referring to _counting_ semaphores.

It seems to me it would be far far saner to define something like

	sleep_lock(&foo)
	sleep_unlock(&foo)
	sleep_trylock(&foo)

given the new mutex interface is actually a sleeping interface with the
semantics of the spin_lock interface. Its then obvious what it does, you
don't randomly break other drivers you've not reviewed and the interface
is intuitive rather than obfuscated.

It won't take long for people to then change the name of the performance
critical cases and the others will catch up in time.

It also saves breaking every piece of out of tree kernel code for now
good reason.

Alan
