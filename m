Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbfHUIyc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 04:54:32 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31AE32F30D9
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 08:54:32 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k8so905186wrx.19
        for <linux-arch@vger.kernel.org>; Wed, 21 Aug 2019 01:54:32 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: RE: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <87o90jq99w.fsf@vitty.brq.redhat.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net> <87wog1kpib.fsf@vitty.brq.redhat.com> <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com> <DM5PR21MB0137E03AAD8C2EA61EC81ED7D7D30@DM5PR21MB0137.namprd21.prod.outlook.com> <87sgq5a2hq.fsf@vitty.brq.redhat.com> <DM5PR21MB013730EB79A17AF02C170BD7D7AB0@DM5PR21MB0137.namprd21.prod.outlook.com> <87o90jq99w.fsf@vitty.brq.redhat.com>
Date: Wed, 21 Aug 2019 10:54:28 +0200
Message-ID: <87imqqrj97.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kelley <mikelley@microsoft.com>, Tianyu Lan <lantianyu1986@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190821085428.bOamOJVf753utqty51kTV7vkeN7R9zo9u0FfS7fzhC4@z>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Michael Kelley <mikelley@microsoft.com> writes:
>
>> I talked to KY Srinivasan for any history about TSC page on 32-bit.  He said
>> there was no technical reason not to implement it, but our focus was always
>> 64-bit Linux, so the 32-bit was much less important.  Also, on 32-bit Linux,
>> the required 64x64 multiply and shift is more complex and takes more
>> more cycles (compare 32-bit implementation of mul_u64_u64_shr vs.
>> the 64-bit implementation), so the win over a MSR read is less.  I
>> don't know of any actual measurements being made to compare vs.
>> MSR read.
>
> VMExit is 1000 CPU cycles or so, I would guess that TSC page
> calculations are better. Let me try to build 32bit kernel and do some
> quick measurements.

So I tried and the difference is HUGE.

For in-kernel clocksource reads (like sched_clock()), the testing code
was:

        before = rdtsc_ordered();
        for (i = 0; i < 1000; i++)
             (void)read_hv_sched_clock_msr();
        after = rdtsc_ordered();
        printk("MSR based clocksource: %d cycles\n", ((u32)(after - before))/1000);

        before = rdtsc_ordered();
        for (i = 0; i < 1000; i++)
            (void)read_hv_sched_clock_tsc();
        after = rdtsc_ordered();
        printk("TSC page clocksource: %d cycles\n", ((u32)(after - before))/1000);

The result (WS2016) is:
[    1.101910] MSR based clocksource: 3361 cycles
[    1.105224] TSC page clocksource: 49 cycles

For userspace reads the absolute difference is even bigger as TSC page
gives us functional vDSO:

Testing code:
	before = rdtsc();
	for (i = 0; i < COUNT; i++)
		clock_gettime(CLOCK_REALTIME, &tp);
	after = rdtsc();
	printf("%d\n", (after - before)/COUNT);

Result:

TSC page:
# ./gettime_cycles 
131

MSR:
# ./gettime_cycles 
5664

With all that I see no reason for us to not enable TSC page on 32bit,
even if the number of users is negligible, this will allow us to get rid
of ugly #ifdef CONFIG_HYPERV_TSCPAGE in the code.

I'll send a patch for discussion.

-- 
Vitaly
