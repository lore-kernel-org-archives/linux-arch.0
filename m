Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 17 Jun 2005 02:28:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617092828.GI3913@holomorphy.com>
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au> <20050617084521.GG3913@holomorphy.com> <42B29635.2020700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B29635.2020700@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III wrote:
>> I'm ambivalent now I guess. I'm not wild about bh's in the first place,
>> so infecting core code with new dependencies on them doesn't sound hot,
>> though I still can't help cringing at using a bitflag in the first bh
>> in the list to protect against concurrent teardown of the bh list,
>> which relies on the setup/teardown patterns.

On Fri, Jun 17, 2005 at 07:21:57PM +1000, Nick Piggin wrote:
> It's not quite as bad as that - there will be no teardown while
> any of the buffers are still in flight. The lock is simply to
> protect concurrent completion of requests, it could just as
> easily go in the last bh.

I'd hoped what I had in mind with all that would've been clearer. It
should be clear that I understand it is not overtly broken.


-- wli
