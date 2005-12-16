Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 16 Dec 2005 14:23:49 -0800 (PST)
Message-Id: <20051216.142349.89717140.davem@davemloft.net>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org>
References: <15412.1134561432@warthog.cambridge.redhat.com>
	<12186.1134732601@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0512160829180.3060@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 16 Dec 2005 08:33:10 -0800 (PST)

> From a bus standpoint you _have_ to do the initial read with intent to 
> write, nothing else makes any sense. You'll just waste bus cycles 
> otherwise. Sure, the write may never come, but it just isn't sensible to 
> optimize for the case where the compare will fail. If that's the common 
> case, then software is doing something wrong (it should do just a much 
> cheaper "load + compare" first if it knows it's probably going to fail).

Actually, this points out a problem with "compare and swap".  The
typical loop is of the form:

	LOAD [MEM], REG1
	OP   REG1, X, REG2
	CAS  [MEM], REG1, REG2

That first LOAD instruction, if it misses in the L2, causes the cache
line to be requested for sharing.  Then the CAS instruction will need
to issue another cache coherency transaction to get the cache line
into owned state.

Basically, this guarentees that you'll have 2 cache coherency
transactions, a huge waste, every time an atomic update sequence
executes for a data item not in cache already.

(Are there any CPUs that peek forward and look for the CAS
 instruction to decide to issue the more appropriate request
 for the cache line in Owned state?  That would be cool...)

At least with "load locked / store conditional" the cpu is being told
that we intend to write to that cache line, so it can request sole
ownership on the bus when the load misses.

The only workaround I can come up with is the do a prefetch for write
right before the LOAD.  I've been tempted to add this on sparc64 for a
long time.
