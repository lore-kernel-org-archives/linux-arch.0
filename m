Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42B2977F.7040906@yahoo.com.au>
Date: Fri, 17 Jun 2005 19:27:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Global spinlock vs local bit spin locks
References: <1118982092.5261.44.camel@npiggin-nld.site> <20050617044611.GF3913@holomorphy.com> <42B28B44.9090606@yahoo.com.au> <20050617085426.GK31127@wotan.suse.de>
In-Reply-To: <20050617085426.GK31127@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
> On Fri, Jun 17, 2005 at 06:35:16PM +1000, Nick Piggin wrote:
> 
>>William Lee Irwin III wrote:
>>
>>
>>>I'd feel far more comfortable with this if the lockbit resided in the
>>>page. Also, compare it to akpm's solution.
>>>
>>
>>akpm's solution is alright. They perform similarly on the workload in
>>question. Of course, the bitlock will scale quite a lot better if you
>>pushed it and will automatically be localised per device and have NUMA
>>locality, etc.
> 
> 
> The buffer head is not necessarily NUMA local though - there is
> some chance that a BH from a different node is reused.

True, but compared to a hash which is almost guaranteed *not* to
be in local memory for any medium to large NUMA system :)

Though I guess on many, it is basically luck that you would get
an IO submitted on the same node that takes the completion
interrupt.

However, on really huge systems like SGI's, they often tend to
lock down devices and jobs quite tightly to nodes so I think
it has some merit.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
