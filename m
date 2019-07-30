Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44507 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Nl3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jul 2019 09:41:29 -0400
MIME-Version: 1.0
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com> <20190729110927.GC31398@hirez.programming.kicks-ass.net>
 <87wog1kpib.fsf@vitty.brq.redhat.com>
In-Reply-To: <87wog1kpib.fsf@vitty.brq.redhat.com>
From: Tianyu Lan <lantianyu1986@gmail.com>
Date: Tue, 30 Jul 2019 21:41:18 +0800
Message-ID: <CAOLK0py6ngy9kAnZcRMBK8U45s2L5Wo4X0NP_qPM0zv7WjeVQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, michael.h.kelley@microsoft.comashal@kernel.org
Message-ID: <20190730134118.0n0vZy6d4jEa4C8bTM7FK4KOaiN0rGFfzNfHhH3ulOw@z>

Hi Vitaly & Peter:
    Thanks for your review.

On Mon, Jul 29, 2019 at 8:13 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
> >> lantianyu1986@gmail.com writes:
> >>
> >> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >> >
> >> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> >> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
> >> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> >> > to set the sched clock function appropriately.  On x86, this sets
> >> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> >> > scaled and adjusted to be continuous.
> >>
> >> Hypervisor can, in theory, disable TSC page and then we're forced to use
> >> MSR-based clocksource but using it as sched_clock() can be very slow,
> >> I'm afraid.
> >>
> >> On the other hand, what we have now is probably worse: TSC can,
> >> actually, jump backwards (e.g. on migration) and we're breaking the
> >> requirements for sched_clock().
> >
> > That (obviously) also breaks the requirements for using TSC as
> > clocksource.
> >
> > IOW, it breaks the entire purpose of having TSC in the first place.
>
> Currently, we mark raw TSC as unstable when running on Hyper-V (see
> 88c9281a9fba6), 'TSC page' (which is TSC * scale + offset) is being used
> instead. The problem is that 'TSC page' can be disabled by the
> hypervisor and in that case the only remaining clocksource is MSR-based
> (slow).
>

Yes, that will be slow if Hyper-V doesn't expose hv tsc page and
kernel uses MSR based
clocksource. Each MSR read will trigger one VM-EXIT. This also happens on other
hypervisors (e,g, KVM doesn't expose KVM clock). Hypervisor should
take this into
account and determine which clocksource should be exposed or not.

-- 
Best regards
Tianyu Lan
