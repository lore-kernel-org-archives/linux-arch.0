Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 16 Jun 2005 21:46:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Global spinlock vs local bit spin locks
Message-ID: <20050617044611.GF3913@holomorphy.com>
References: <1118982092.5261.44.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118982092.5261.44.camel@npiggin-nld.site>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "David S. Miller" <davem@davemloft.net>, anton@samba.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Peter Keilty <Peter.Keilty@hp.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jun 17, 2005 at 02:21:32PM +1000, Nick Piggin wrote:
> Peter Keilty is running into some scalability problems with buffer
> head based IO. There are a couple of global spinlocks in the buffer
> completion path, and they're showing up on 16-way IA64 systems.
> Replacing these locks with a bit spin lock in the buffer head status
> field has been shown to eliminate the bouncing problem. We want to
> go with this unless anyone has an objection to the cost.
> There is a cost (though I haven't been able to measure a signficant
> change), but I think it will be outweighed by the the reduction in
> cacheline contention on even small SMPs doing IO.
> Any input would be appreciated.
> If anyone wants to run some tests, possibly the easiest would be to
> make ext2 on loopback on tmpfs (to test scalability, have one loop
> device for each CPU in the system and bind the loop threads to each
> CPU). Make sure ext2 block size is < PAGE_SIZE.

I'd feel far more comfortable with this if the lockbit resided in the
page. Also, compare it to akpm's solution.


-- wli
