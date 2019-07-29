Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42186 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfG2MNU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 08:13:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so11678641wrr.9
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 05:13:18 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
In-Reply-To: <20190729110927.GC31398@hirez.programming.kicks-ass.net>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com> <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net>
Date: Mon, 29 Jul 2019 14:13:16 +0200
Message-ID: <87wog1kpib.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de, michael.h.kelley@microsoft.comashal@kernel.org
Message-ID: <20190729121316.MhQo7-tslXojSIM5B9iOpSiTc_NrAW_4SoimhT_SLcc@z>

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
>> lantianyu1986@gmail.com writes:
>> 
>> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> >
>> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
>> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
>> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
>> > to set the sched clock function appropriately.  On x86, this sets
>> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
>> > scaled and adjusted to be continuous.
>> 
>> Hypervisor can, in theory, disable TSC page and then we're forced to use
>> MSR-based clocksource but using it as sched_clock() can be very slow,
>> I'm afraid.
>> 
>> On the other hand, what we have now is probably worse: TSC can,
>> actually, jump backwards (e.g. on migration) and we're breaking the
>> requirements for sched_clock().
>
> That (obviously) also breaks the requirements for using TSC as
> clocksource.
>
> IOW, it breaks the entire purpose of having TSC in the first place.

Currently, we mark raw TSC as unstable when running on Hyper-V (see
88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
instead. The problem is that 'TSC page' can be disabled by the
hypervisor and in that case the only remaining clocksource is MSR-based
(slow).

-- 
Vitaly
