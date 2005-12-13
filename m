Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 09:06:42 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213090642.GD27857@infradead.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <439E38A4.30204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439E38A4.30204@rtr.ca>
To: Mark Lord <lkml@rtr.ca>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Dec 12, 2005 at 09:57:40PM -0500, Mark Lord wrote:
> This will BREAK a lot of out-of-tree stuff if merged.

Well, bad luck for them.

> The simplest way would be to NOT re-use the up()/down() symbols,
> but rather to either keep them as-is (counting semaphores),
> or delete them entirely (so that external code *knows* of the change).

That I agree with actually.  Keeping the semaphore interface as-is
would simplify in-kernel transition a lot aswell and make it easier for
people to get the API read.  And the mutex symbols could get far more sensible
names like mutex_lock, mutex_unlock and mutex_trylock..
