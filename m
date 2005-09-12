Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4325A1D7.103@yahoo.com.au>
Date: Tue, 13 Sep 2005 01:42:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
References: <432595D5.1090502@yahoo.com.au> <20050912153053.GA4778@in.ibm.com>
In-Reply-To: <20050912153053.GA4778@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: dipankar@in.ibm.com
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Dipankar Sarma wrote:
> On Tue, Sep 13, 2005 at 12:51:01AM +1000, Nick Piggin wrote:
> 
>>The recent file_table RCU work introduced a new rcuref.h thing,
>>which is just begging to be atomic.h. Basically it uses atomic_t,
>>digs into the atomic_t type, and also defines its own table of
>>spinlocks if the arch doesn't have cmpxchg() thus rendering it
>>unsafe for any other atomic_xxx operation to be performed on it.
> 
> 
> The rcuref_xxx primitives were for only RCU protected refcounters
> and I implemented all the primitives needed for them and use
> of them was mandatory.
> 

Oh yes, I realise that and I did not spot a bug in your implementation.

> 
>>Anyway, as it turns out, my lockless pagecache patches have the
>>exact same requirement, and so I am proposing to implement two
>>new atomic_ primitives that should be useful.
>>
>>Only one is actually needed, atomic_inc_not_zero being the exact
>>fit for both, however I did atomic_cmpxchg first and it can stay
>>around because hopefully will be a generally useful primitive.
>>
>>Now atomic_inc_not_zero is not really anything to do with RCU other
>>than an RCU protected refcounted structure being an obvious user to
>>take a reference on the read side where there is nothing to pin it.
>>
>>1/3 is atomic_cmpxchg, not guaranteed to even compile on most.
> 
> 
> This is sooo much better. I would much rather kill rcuref.h
> and directly use atomic_inc_not_zero() when necessary.
> Please feel free to churn out the whole implementation and I will
> test it.
> 

OK, once I run it past the arch maintainers I will post a new set to
lkml (and cc you). If you are feeling brave, the atomic_cmpxchg on
ppc64 is working with my lockless pagecache patches, but I simply
haven't tested 3/3.

Anyway, please, arch maintainers: speak now if there is something
really nasty about doing this on your arch. Otherwise, if you can
cook up optimised versions then please send them to me. If not, I'll
try to do the dumb implementations as best I can.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
