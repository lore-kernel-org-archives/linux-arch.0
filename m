From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] Add NUMA-awareness to qspinlock
Date: Thu, 31 Jan 2019 10:56:38 +0100
Message-ID: <20190131095638.GA31534@hirez.programming.kicks-ass.net>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190131030136.56999-1-alex.kogan@oracle.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, dave.dice@oracle.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, steven.sistare@oracle.com, longman@redhat.com, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
