Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 16 Dec 2005 23:10:56 -0800 (PST)
Message-Id: <20051216.231056.124758189.davem@davemloft.net>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512161641.49571.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
	<20051216.145306.132052494.davem@davemloft.net>
	<200512161641.49571.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: jbarnes@virtuousgeek.org
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Fri, 16 Dec 2005 16:41:49 -0800

> Note that under contention prefetching with a write bias can cause a lot 
> more cache line bouncing than a regular load into shared state (assuming 
> you do a load and test before you try the CAS).

If there is some test guarding the CAS, yes.

But if there isn't, for things like atomic increment and
decrement, where the CAS is unconditional, you'll always
eat the two bus transactions without the prefetch for write.
