Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 17 Jun 2005 01:45:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617084521.GG3913@holomorphy.com>
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B28B44.9090606@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III wrote:
>> I'd feel far more comfortable with this if the lockbit resided in the
>> page. Also, compare it to akpm's solution.

On Fri, Jun 17, 2005 at 06:35:16PM +1000, Nick Piggin wrote:
> akpm's solution is alright. They perform similarly on the workload in
> question. Of course, the bitlock will scale quite a lot better if you
> pushed it and will automatically be localised per device and have NUMA
> locality, etc.
> As far as page flags go - I agree but I didn't want to use one up.
> This is very localised and I don't think it is particularly worse
> than what was there before, so I think we can get away with it for
> the moment.

I'm ambivalent now I guess. I'm not wild about bh's in the first place,
so infecting core code with new dependencies on them doesn't sound hot,
though I still can't help cringing at using a bitflag in the first bh
in the list to protect against concurrent teardown of the bh list,
which relies on the setup/teardown patterns.

Might as well stop bothering people about it, I guess.


-- wli
