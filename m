Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 09:13:31 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Message-Id: <20050322091331.7b2967a1.davem@davemloft.net>
In-Reply-To: <11333.1111510094@redhat.com>
References: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk>
	<20050321150619.2ea75257.davem@davemloft.net>
	<20050321225904.GF23908@krispykreme>
	<20072.1111488229@redhat.com>
	<20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk>
	<20050322160324.GA4980@krispykreme>
	<11333.1111510094@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: matthew@wil.cx, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 22 Mar 2005 16:48:14 +0000
David Howells <dhowells@redhat.com> wrote:

> Matthew Wilcox <matthew@wil.cx> wrote:
> 
> >  - io_*mb() are equivalent, for io memory.
> 
> I don't think these actually exist at the moment. My suggestion was that we
> rename {r,w,}mb() to io_{r,w,}mb().

This is the first time I've seen that ?mb() should order I/O
accesses.  My sparc64 versions certainly don't handle that
correctly.  :-)  That being said, I think we're all being
educated to so me extent in this thread.

On sparc64, we have a "membar" instruction.  It takes a bitmask,
and each bit says what ordering constraint is desired.  So, for
example, there is a bit that says "complete all previous loads
before executing any future stores", it looks like:

	membar	#LoadStore

if you wanted to order previous stores with future stores as well,
you'd do something like:

	membar	#LoadStore | #StoreStore

Anyways, there is a special bit called "#Sync" which usually sits
by itself and it causes all previous memory operations (even deferred
ones) to complete before that membar finishes execution.  This is
the only way to get deferred errors and traps (f.e. deferred store
causes memory bus error) to get signalled synchronously.

Finally, there is the #Lookaside bit which is the only way to order
cacheable vs. non-cacheable accesses.  I would need to add this bit
to the ?mb() macros if I/O ordering is really required.
