From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [patch 1/2]: x86: implement pte_special
Date: Thu, 27 Mar 2008 20:44:31 -0700 (PDT)
Message-ID: <20080327.204431.201380891.davem@davemloft.net>
References: <20080328025541.GB8083@wotan.suse.de>
	<20080327.202334.250213398.davem@davemloft.net>
	<20080328033149.GD8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328033149.GD8083-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 28 Mar 2008 04:31:50 +0100

> Basically, the pfn-based mapping insertion (vm_insert_pfn, remap_pfn_range)
> calls pte_mkspecial. And that tells fast_gup "hands off".

I don't think it's wise to allocate a "soft PTE bit" for this on every
platform, especially for such a limited use case.

Is it feasible to test the page instead?  Or are we talking about
cases where there may not be a backing page?

If the issue is to discern things like I/O mappings and such vs. real
pages, there are ways a platform can handle that without a special
bit.

That would leave us with real memory that does not have backing
page structs, and we have a way to test that too.

The special PTE bit seems superfluous to me.
