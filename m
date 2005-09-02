Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <431807DD.5030105@yahoo.com.au>
Date: Fri, 02 Sep 2005 18:05:49 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [Fwd: [PATCH 2.6.13] lockless pagecache 2/7]
References: <4317F2FE.8030109@yahoo.com.au> <20050902.003940.68050984.davem@davemloft.net>
In-Reply-To: <20050902.003940.68050984.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:
> Sparc32 lacks compare and exchange.  I think PARISC lacks it
> as well.
> 
> For these older SMP systems, at best you can assume there
> is some kind of spinlock and perhaps a straight atomic
> exchange instruction.  You really can't assume the existance
> of compare-and-swap.
> 

Thanks David, I suspected as much.

PARISC emulates cmpxchg. I suspect sparc could do the same?
(provided all access goes through the atomic_xxx accessors)

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
