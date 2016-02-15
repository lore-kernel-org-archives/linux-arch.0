Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33568 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbcBOLNN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Feb 2016 06:13:13 -0500
MIME-Version: 1.0
In-Reply-To: <20160215105028.GB1748@arm.com>
References: <145544094056.28219.12239469516497703482.stgit@zurg>
	<20160215105028.GB1748@arm.com>
Date: Mon, 15 Feb 2016 14:13:11 +0300
Message-ID: <CALYGNiO3ibGftJ275V+x_3SCDPhQ8mCBcELMyMsGn3uWSP525w@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min operations
From: Konstantin Khlebnikov <koct9i@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Message-ID: <20160215111311.yHFLPvSSLSdBU0b6SvaSVPHlSBxhrFUU8dv1nSmv3eo@z>

On Mon, Feb 15, 2016 at 1:50 PM, Will Deacon <will.deacon@arm.com> wrote:
> Adding Peter and Paul,
>
> On Sun, Feb 14, 2016 at 12:09:00PM +0300, Konstantin Khlebnikov wrote:
>> bool atomic_add_max(atomic_t *var, int add, int max);
>> bool atomic_sub_min(atomic_t *var, int sub, int min);
>
> What are the memory-ordering requirements for these? Do you also want
> relaxed/acquire/release versions for the use-cases you outline?
>
> One observation is that you provide no ordering guarantees if the
> comparison fails, which is fine if that's what you want, but we should
> probably write that down like we do for cmpxchg.

Ok. Good point.

>
>> bool this_cpu_add_max(var, add, max);
>> bool this_cpu_sub_min(var, sub, min);
>>
>> They add/subtract only if result will be not bigger than max/lower that min.
>> Returns true if operation was done and false otherwise.
>>
>> Inside they check that (add <= max - var) and (sub <= var - min). Signed
>> operations work if all possible values fits into range which length fits
>> into non-negative range of that type: 0..INT_MAX, INT_MIN+1..0, -1000..1000.
>> Unsigned operations work if value always in valid range: min <= var <= max.
>> Char and short automatically casts to int, they never overflows.
>>
>> Patch adds the same for atomic_long_t, atomic64_t, local_t, local64_t.
>> And unsigned variants: atomic_u32_add_max atomic_u32_sub_min for atomic_t,
>> atomic_u64_add_max atomic_u64_sub_min for atomic64_t.
>>
>> Patch comes with test which hopefully covers all possible cornercases,
>> see CONFIG_ATOMIC64_SELFTEST and CONFIG_PERCPU_TEST.
>>
>> All this allows to build any kind of counter in several lines:
>
> Do you have another patch converting people over to these new atomics?

Thanks for comments.
Sure, I'll try to use this as wide as possible.

For now this solution is still incomlete. For example there is no simple way for
handing cpu-hotplug: per-cpu batches must be updated when cpu disappears.
Ideally cpu hotplug handlers should be registered in the same way as init/exit
functions and placed into separate code segment. Memory hotplug could be
handled in the same way too because resource limit or batching often depents
on memory size.
