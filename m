Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 17 Jun 2005 10:54:26 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617085426.GK31127@wotan.suse.de>
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B28B44.9090606@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jun 17, 2005 at 06:35:16PM +1000, Nick Piggin wrote:
> William Lee Irwin III wrote:
> 
> >
> >I'd feel far more comfortable with this if the lockbit resided in the
> >page. Also, compare it to akpm's solution.
> >
> 
> akpm's solution is alright. They perform similarly on the workload in
> question. Of course, the bitlock will scale quite a lot better if you
> pushed it and will automatically be localised per device and have NUMA
> locality, etc.

The buffer head is not necessarily NUMA local though - there is
some chance that a BH from a different node is reused. struct page
is guaranteed to be node local of the memory.

> 
> As far as page flags go - I agree but I didn't want to use one up.
> This is very localised and I don't think it is particularly worse
> than what was there before, so I think we can get away with it for
> the moment.

I'm starting to think that we need different strategies on 32bit
and 64bit here. 64bit has plenty of bits left; it is just 32bit
that is a problem here.

-Andi
