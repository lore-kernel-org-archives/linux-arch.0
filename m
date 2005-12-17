Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 17 Dec 2005 15:05:35 -0800 (PST)
Message-Id: <20051217.150535.122244453.davem@davemloft.net>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051217223824.GA16736@twiddle.net>
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
	<20051216.145306.132052494.davem@davemloft.net>
	<20051217223824.GA16736@twiddle.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: rth@twiddle.net
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Richard Henderson <rth@twiddle.net>
Date: Sat, 17 Dec 2005 14:38:24 -0800

> You might consider just beginning your loops like
> 
> 	mov	zero, old
> 	cas	[mem], zero, old
> 
> to do the initial read, since old will now contain the 
> contents of the memory, and we havn't changed the memory.

CAS is 32 cycles minimum on sparc64 even on a cache hit, so I think
the prefetch+load will be faster :-)  But it deserves checking out,
that's for sure.

Either way, that is a clever use of CAS :)
