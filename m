Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:59993
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755667Ab0JFMf6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2010 08:35:58 -0400
Date: Wed, 6 Oct 2010 14:35:21 +0200
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 1/7] perf: Add helper function to return number of
 counters
Message-ID: <20101006123521.GM13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
 <c4eb88b09da564fe093cc6571ed747971425e69a.1286222593.git.matt@console-pimps.org>
 <20101006121410.GK13563@erda.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20101006121410.GK13563@erda.amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101006123521.xvY6OWHPdVVfB1ThNf-Qaam6ruCzHQh4DzqqWTHSQBQ@z>

On 06.10.10 14:14:10, Robert Richter wrote:
> On 04.10.10 16:44:19, Matt Fleming wrote:
> > The number of counters for the registered pmu is needed in a few places
> > so provide a helper function that returns this number.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > Tested-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/kernel/perf_event.c |    6 ++++++
> >  arch/arm/oprofile/common.c   |   31 ++++++++++++++++++-------------
> >  arch/sh/kernel/perf_event.c  |    9 +++++++++
> >  include/linux/perf_event.h   |    1 +
> >  4 files changed, 34 insertions(+), 13 deletions(-)

> > diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> > index d660cb8..23f18a0 100644
> > --- a/arch/arm/oprofile/common.c
> > +++ b/arch/arm/oprofile/common.c
> > @@ -43,7 +43,7 @@ static DEFINE_MUTEX(op_arm_mutex);
> >  
> >  static struct op_counter_config *counter_config;
> >  static struct perf_event **perf_events[nr_cpumask_bits];
> > -static int perf_num_counters;
> > +static int perf_nr_counters;

Matt,

as we will have one more version with this patch set, please use
num_counters instead of perf_nr_counters. The same name is used also
for x86.

Thanks,

-Robert

> >  
> >  /*
> >   * Overflow callback for oprofile.

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

