Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45412 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbfG2LJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 07:09:42 -0400
Date: Mon, 29 Jul 2019 13:09:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched
 clock function
Message-ID: <20190729110927.GC31398@hirez.programming.kicks-ass.net>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <87zhkxksxd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhkxksxd.fsf@vitty.brq.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: lantianyu1986@gmail.com, Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de, michael.h.kelley@microsoft.comashal@kernel.org
Message-ID: <20190729110927.AhfhRZNAERqnJ4TQzCZ4xxghPron35JLDR3dV-txwzQ@z>

On Mon, Jul 29, 2019 at 12:59:26PM +0200, Vitaly Kuznetsov wrote:
> lantianyu1986@gmail.com writes:
> 
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
> > on x86.  But native_sched_clock() directly uses the raw TSC value, which
> > can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
> > to set the sched clock function appropriately.  On x86, this sets
> > pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
> > scaled and adjusted to be continuous.
> 
> Hypervisor can, in theory, disable TSC page and then we're forced to use
> MSR-based clocksource but using it as sched_clock() can be very slow,
> I'm afraid.
> 
> On the other hand, what we have now is probably worse: TSC can,
> actually, jump backwards (e.g. on migration) and we're breaking the
> requirements for sched_clock().

That (obviously) also breaks the requirements for using TSC as
clocksource.

IOW, it breaks the entire purpose of having TSC in the first place.
