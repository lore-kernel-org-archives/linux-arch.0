From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Mon, 15 May 2017 18:47:28 +0300
Message-ID: <20170515154728.amzw3d67tw722wmu@yury-N73SV>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170514180917.bil7xr4bqtfk6fzj@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>
List-Id: linux-arch.vger.kernel.org

On Sun, May 14, 2017 at 08:09:17PM +0200, Ingo Molnar wrote:
> 
> * Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
> > sched_find_first_bit() is in fact the unrolled version of
> > find_first_bit(), which is theoretically faster in some cases.
> > But in the kernel it is called only in couple places in 
> > kernel/sched/rt.c, and both of them are not looking like hot
> > paths [...]
> 
> They are in terms of scheduling: pick_next_rt_entity() is in the RT scheduling 
> fastpath.

Sorry that. I'll be more specific. I was only saying that pick_next_rt_entity()
is big enough to feel any difference, and it's still true for me. Please
forget about hot paths.

> Which makes me just suspicious of how careful this patch really is:
> 
> > that will doubtly achieve measurable benefit from using unrolled version of 
> > find_first_bit() - there's no hard loops, and the execution path is not really 
> > short.
> 
> ... that's really just handwaving. Numbers please.

I use qemu running arm64 as my testing environment. It's not the best
for performance measurements, but allows estimate something... So,

This patch shows the time (in cycles) that kernel spends running the
pick_next_rt_entity() code:

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f04346329204..7c6194e30230 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1529,6 +1529,8 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	struct task_struct *p;
 	struct rt_rq *rt_rq = &rq->rt;
 
+	u64 cycles = get_cycles();
+
 	if (need_pull_rt_task(rq, prev)) {
 		/*
 		 * This is OK, because current is on_cpu, which avoids it being
@@ -1568,6 +1570,8 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	queue_push_tasks(rq);
 
+	pr_err("cycles: %lld\n", get_cycles() - cycles);
+
 	return p;
 }
 
I collected about 700 results in dmesg, and took 600 fastest.
For the vanilla kernel, the average value is 368, and for patched
kernel it is 388. It's 5% slower. But the standard deviation is 
really big for both series' - 131 and 106 cycles respectively, which
is ~ 30%. And so, my conclusion is: there's no benefit in using
sched_find_first_bit() comparing to find_first_bit().

I also think that sched_find_first_bit() may be faster that find_first_bit()
because it's inlined in the caller. We can do so for find_first_bit() if
it takes small sizes at compile time, and so all parts of kernel will
use fast find_first_bit, not only sched.

Yury
