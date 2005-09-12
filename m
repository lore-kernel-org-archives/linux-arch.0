Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j8CFaHnc023798
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 11:36:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8CFaHpK095218
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 11:36:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j8CFaGNn001580
	for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2005 11:36:16 -0400
Date: Mon, 12 Sep 2005 21:00:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 1/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
Message-ID: <20050912153053.GA4778@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <432595D5.1090502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432595D5.1090502@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 13, 2005 at 12:51:01AM +1000, Nick Piggin wrote:
> The recent file_table RCU work introduced a new rcuref.h thing,
> which is just begging to be atomic.h. Basically it uses atomic_t,
> digs into the atomic_t type, and also defines its own table of
> spinlocks if the arch doesn't have cmpxchg() thus rendering it
> unsafe for any other atomic_xxx operation to be performed on it.

The rcuref_xxx primitives were for only RCU protected refcounters
and I implemented all the primitives needed for them and use
of them was mandatory.

> Anyway, as it turns out, my lockless pagecache patches have the
> exact same requirement, and so I am proposing to implement two
> new atomic_ primitives that should be useful.
> 
> Only one is actually needed, atomic_inc_not_zero being the exact
> fit for both, however I did atomic_cmpxchg first and it can stay
> around because hopefully will be a generally useful primitive.
> 
> Now atomic_inc_not_zero is not really anything to do with RCU other
> than an RCU protected refcounted structure being an obvious user to
> take a reference on the read side where there is nothing to pin it.
> 
> 1/3 is atomic_cmpxchg, not guaranteed to even compile on most.

This is sooo much better. I would much rather kill rcuref.h
and directly use atomic_inc_not_zero() when necessary.
Please feel free to churn out the whole implementation and I will
test it.

Thanks
Dipankar
