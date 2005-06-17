Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B29635.2020700@yahoo.com.au>
Date: Fri, 17 Jun 2005 19:21:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Global spinlock vs local bit spin locks
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au> <20050617084521.GG3913@holomorphy.com>
In-Reply-To: <20050617084521.GG3913@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III wrote:

> 
> I'm ambivalent now I guess. I'm not wild about bh's in the first place,
> so infecting core code with new dependencies on them doesn't sound hot,
> though I still can't help cringing at using a bitflag in the first bh
> in the list to protect against concurrent teardown of the bh list,
> which relies on the setup/teardown patterns.
> 

It's not quite as bad as that - there will be no teardown while
any of the buffers are still in flight. The lock is simply to
protect concurrent completion of requests, it could just as
easily go in the last bh.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
