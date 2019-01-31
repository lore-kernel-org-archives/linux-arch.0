Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57948 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaJ4w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Jan 2019 04:56:52 -0500
Date: Thu, 31 Jan 2019 10:56:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
Message-ID: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190131095638.BgeI5Pts9D_GeL_NN6FBaCa7vcV6RB-I75wapgB77KQ@z>

On Wed, Jan 30, 2019 at 10:01:32PM -0500, Alex Kogan wrote:
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA socket as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA sockets. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock.

Since you use NUMA, use the term node, not socket. The two are not
strictly related.

> CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> socket as the current lock holder, and a secondary queue for threads
> running on other sockets. Threads record the ID of the socket on which
> they are running in their queue nodes. At the unlock time, the lock
> holder scans the main queue looking for a thread running on the same
> socket. If found (call it thread T), all threads in the main queue
> between the current lock holder and T are moved to the end of the
> secondary queue, and the lock is passed to T. If such T is not found, the
> lock is passed to the first node in the secondary queue. Finally, if the
> secondary queue is empty, the lock is passed to the next thread in the
> main queue.
> 
> Full details are available at https://arxiv.org/abs/1810.05600.

Full details really should also be in the Changelog. You can skip much
of the academic bla-bla, but the Changelog should be self contained.

> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 5 runs) of the
> total number of ops (x10^7) reported at the end of each run. The stock
> kernel is v4.20.0-rc4+ compiled in the default configuration.
> 
> #thr  stock  patched speedup (patched/stock)
>   1   2.710   2.715  1.002
>   2   3.108   3.001  0.966
>   4   4.194   3.919  0.934

So low contention is actually worse. Funnily low contention is the
majority of our locks and is _really_ important.

>   8   5.309   6.894  1.299
>  16   6.722   9.094  1.353
>  32   7.314   9.885  1.352
>  36   7.562   9.855  1.303
>  72   6.696  10.358  1.547
> 108   6.364  10.181  1.600
> 142   6.179  10.178  1.647
> 
> When the kernel is compiled with lockstat enabled, CNA 

I'll ignore that, lockstat/lockdep enabled runs are not what one would
call performance relevant.
