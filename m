Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B28B44.9090606@yahoo.com.au>
Date: Fri, 17 Jun 2005 18:35:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Global spinlock vs local bit spin locks
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com>
In-Reply-To: <20050617044611.GF3913@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

William Lee Irwin III wrote:

> 
> I'd feel far more comfortable with this if the lockbit resided in the
> page. Also, compare it to akpm's solution.
> 

akpm's solution is alright. They perform similarly on the workload in
question. Of course, the bitlock will scale quite a lot better if you
pushed it and will automatically be localised per device and have NUMA
locality, etc.

As far as page flags go - I agree but I didn't want to use one up.
This is very localised and I don't think it is particularly worse
than what was there before, so I think we can get away with it for
the moment.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
