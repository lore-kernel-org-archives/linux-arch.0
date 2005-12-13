Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <974.1134472981@warthog.cambridge.redhat.com> 
References: <974.1134472981@warthog.cambridge.redhat.com>  <439E1381.2060201@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Tue, 13 Dec 2005 11:34:14 +0000
Message-ID: <1253.1134473654@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:

> > Any reason why you're setting up your own style of waitqueue in
> > mutex-simple.c instead of just using the kernel's style of waitqueue?
> 
> Because I can steal the code from FRV's semaphores or rw-semaphores, and this
> way I can be sure of what I'm doing.

And because:

	struct mutex {
		int			state;
		wait_queue_head_t	wait_queue;
	};

Wastes 8 more bytes of memory than:

	struct mutex {
		int			state;
		spinlock_t		wait_lock;
		struct list_head	wait_list;
	};

on a 64-bit machine if spinlock_t is 4 bytes. Both waste 4 bytes if spinlock_t
is 8 bytes.

David
