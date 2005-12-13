Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <439E38A4.30204@rtr.ca>
Date: Mon, 12 Dec 2005 21:57:40 -0500
From: Mark Lord <lkml@rtr.ca>
MIME-Version: 1.0
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

 > (5) Redirects the following to apply to the new mutexes rather than the
 >     traditional semaphores:
 >
 >	down()
 >	down_trylock()
 >	down_interruptible()
 >	up()

This will BREAK a lot of out-of-tree stuff if merged.

So please figure out some way to hang a HUGE banner out there
so that the external codebases know they need updating.

The simplest way would be to NOT re-use the up()/down() symbols,
but rather to either keep them as-is (counting semaphores),
or delete them entirely (so that external code *knows* of the change).

Cheers
