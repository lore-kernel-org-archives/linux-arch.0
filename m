From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Date: Thu, 16 Sep 2010 16:48:28 +0200
Message-ID: <20100916144828.GD13563@erda.amd.com>
References: <cover.1284357372.git.matt@console-pimps.org>
 <1284372533.3042.11.camel@e102144-lin.cambridge.arm.com>
 <20100913111850.GC14882@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100913111850.GC14882@console-pimps.org>
Sender: linux-sh-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 13.09.10 07:18:50, Matt Fleming wrote:
> On Mon, Sep 13, 2010 at 11:08:53AM +0100, Will Deacon wrote:

> > I've tested this patch series on a multicore Cortex-A9 board. If I
> > revert patch 5/6 (ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS)
> > then everything seems to work fine. Otherwise, testing without
> > HW_PERF_EVENTS doesn't fall back to timer mode.
> > 
> > So, with the exception of the patch above:
> > 
> > Tested-by: Will Deacon <will.deacon@arm.com>
> 
> Hi Will, thanks for testing!
> 
> Ah yeah, making oprofile rely on CONFIG_HW_PERF_EVENTS is too
> strict. I hadn't noticed that armpmu_get_pmu_id() is wrapped in
> CONFIG_HW_PERF_EVENTS and had intended op->cpu_type to be NULL and so
> we'd fallback to the timer mode.
> 
> This patch needs to be dropped entirely (though another patch should
> conditionally include oprofile_perf.o based on CONFIG_HW_PERF_EVENT
> like I had in my original series).

Matt,

yes, the patch set looks good so far. With the exception of some minor
comments I made and patch #5 dropped, we should be fine. Please update
the patches.

Thanks,

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

