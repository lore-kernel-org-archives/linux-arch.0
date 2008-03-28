From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [patch 1/2]: x86: implement pte_special
Date: Thu, 27 Mar 2008 21:09:10 -0700 (PDT)
Message-ID: <20080327.210910.101408473.davem@davemloft.net>
References: <20080328033149.GD8083@wotan.suse.de>
	<20080327.204431.201380891.davem@davemloft.net>
	<20080328040442.GE8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328040442.GE8083-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 28 Mar 2008 05:04:42 +0100

> BTW. if you are still interested, then the powerpc64 patch might be a
> better starting point for you. I don't know how the sparc tlb flush
> design looks like, but if it doesn't do a synchronous IPI to invalidate
> other threads, then you can't use the x86 approach.

I have soft bits available on sparc64, that's not my issue.

My issue is that if you implemented this differently, every platform
would get the optimization, without having to do anything special
at all, and I think that's such a much nicer way.
