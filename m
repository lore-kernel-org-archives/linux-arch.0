Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 4 Aug 2005 15:10:37 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] make spin_lock_prefetch a noop for UP
Message-ID: <20050804131037.GC9112@wotan.suse.de>
References: <42F212F4.5020609@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F212F4.5020609@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 04, 2005 at 11:07:00PM +1000, Nick Piggin wrote:
> Is this any good?
> 
> The counter argument would be that one might prefetch a
> spinlock in the head of a data structure, and expect
> the rest of the cacheline to be in cache as well. Though
> in that case, maybe prefetch/prefetchw should be used
> instead.

Can you describe what the supposed improvement of the patch is? 

-Andi
