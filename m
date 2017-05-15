From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Mon, 15 May 2017 18:06:18 +0200
Message-ID: <CAK8P3a3vLW+bX4PcZ6J6At49ptFnyqEM8FxCRKVDBD9wv2YyKQ@mail.gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
 <20170514180917.bil7xr4bqtfk6fzj@gmail.com> <20170515154728.amzw3d67tw722wmu@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33993 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756665AbdEOQGT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 12:06:19 -0400
In-Reply-To: <20170515154728.amzw3d67tw722wmu@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>

On Mon, May 15, 2017 at 5:47 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> On Sun, May 14, 2017 at 08:09:17PM +0200, Ingo Molnar wrote:
>>
>> * Yury Norov <ynorov@caviumnetworks.com> wrote:
>>
>> > sched_find_first_bit() is in fact the unrolled version of
>> > find_first_bit(), which is theoretically faster in some cases.
>> > But in the kernel it is called only in couple places in
>> > kernel/sched/rt.c, and both of them are not looking like hot
>> > paths [...]
>>
>> They are in terms of scheduling: pick_next_rt_entity() is in the RT scheduling
>> fastpath.
>
> Sorry that. I'll be more specific. I was only saying that pick_next_rt_entity()
> is big enough to feel any difference, and it's still true for me. Please
> forget about hot paths.
>
>> Which makes me just suspicious of how careful this patch really is:
>>
>> > that will doubtly achieve measurable benefit from using unrolled version of
>> > find_first_bit() - there's no hard loops, and the execution path is not really
>> > short.
>>
>> ... that's really just handwaving. Numbers please.
>
> I use qemu running arm64 as my testing environment. It's not the best
> for performance measurements, but allows estimate something... So,
>
> This patch shows the time (in cycles) that kernel spends running the
> pick_next_rt_entity() code:
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index f04346329204..7c6194e30230 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1529,6 +1529,8 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>         struct task_struct *p;
>         struct rt_rq *rt_rq = &rq->rt;
>
> +       u64 cycles = get_cycles();
> +
>         if (need_pull_rt_task(rq, prev)) {
>                 /*
>                  * This is OK, because current is on_cpu, which avoids it being
> @@ -1568,6 +1570,8 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>
>         queue_push_tasks(rq);
>
> +       pr_err("cycles: %lld\n", get_cycles() - cycles);
> +
>         return p;
>  }
>
> I collected about 700 results in dmesg, and took 600 fastest.
> For the vanilla kernel, the average value is 368, and for patched
> kernel it is 388. It's 5% slower. But the standard deviation is
> really big for both series' - 131 and 106 cycles respectively, which
> is ~ 30%. And so, my conclusion is: there's no benefit in using
> sched_find_first_bit() comparing to find_first_bit().
>
> I also think that sched_find_first_bit() may be faster that find_first_bit()
> because it's inlined in the caller. We can do so for find_first_bit() if
> it takes small sizes at compile time, and so all parts of kernel will
> use fast find_first_bit, not only sched.

I suspect the first step would be to 'select GENERIC_FIND_FIRST_BIT'
on ARM64, which should already improve the performance for those
files that never call the 'next' variants.

Adding an inline version of find_first_{,zero_}bit could also help, but
is harder to quantify.

        Arnd
